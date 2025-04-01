(define (eval exp env)
    (cond
        ((isSelfEvaluating exp) exp)
        ((isVariable exp)   (loopUpVariableValue exp env))
        ((isQuoted exp)     (textOfQuotation exp))
        ((isAssignment exp) (evalAssignment exp env))
        ((isDefinition exp) (evalDefinition exp env))
        ((isIf exp)         (evalIf exp env))
        ((isLambda exp)
            (makeProcedure
                (lambdaParameter exp)
                (lambdaBody exp)
                env
            )
        )
        ((isBegin exp)
            (evalSequence (beginAction exp) env)
        )
        ((isCond exp)       (eval (cond->if exp) env))
        ((isAppication exp)
            (apply
                (eval (operator exp) env)
                (listOfValues (operand exp) env)
            )
        )
        (else
            (error "Unknown expression type: EVAL" exp)
        )
    )
)


(define (apply procedure argument)
    (cond
        ((isPrimitiveProcedure procedure)
            (applyPrimitiveProcedure procedure argument)
        )
        ((isCompoundProcedure procedure)
            (evalSequence
                (procedureBody procedure)
                (extendEnvironment
                    (procedureParameter procedure)
                    argument
                    (procedureEnvironmnet procedure)
                )
            )
        )
        (else
            (error "Unknown procedure type: APPLY" procedure)
        )
    )
)

(define (listOfValues exp env)
    (if (isNoOperand exp)
        '()
        (cons
            (eval (firstOperand exp) env)
            (listOfValues (restOperand exp) env)
        )
    )
)

(define (evalIf exp env)
    (if (isTrue (eval (ifPredicate exp) env))
        (eval (ifConsequent exp) env)
        (eval (ifAlternative exp) env)
    )
)

(define (evalSequence exp env)
    (cond 
        ((isLastExp exp) (eval (firstExp exp) env))
        (else
            (eval (firstExp exp) env)
            (evalSequence (restExp exp) env)
        )
    )
)

(define (evalAssignment exp env)
    (setVariableValue 
        (assignmentVariable exp)
        (eval (assignmentValue exp) env)
        env
    )
    'ok
)

(define (evalDefinition exp env)
    (defineVariable
        (definitionVariable exp)
        (eval (definitionValue exp) env)
        env
    )
    'ok
)

(define (isSelfEvaluating exp)
    (cond
        ((isNumber exp) #t)
        ((isString exp) #t)
        (else           #f)
    )
)

(define (isVariable exp) (isSymbol exp))

(define (isQuoted exp) (isTaggedList exp 'quote))
(define (textOfQuotation exp) (cadr exp))

(define (isTaggedList exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        #f
    )
)

(define (isAssignment exp) (isTaggedList exp 'set!))
(define (assignmentVariable exp) (cadr exp))
(define (assignmentValue exp) (caddr exp))

(define (isDefinition exp) (isTaggedList exp 'define))
(define (definitionVariable exp)
    (if (isSymbol (cadr exp))
        (cadr exp)
        (caadr exp)
    )
)
(define (definitionValue exp)
    (if (isSymbol (cadr exp))
        (caddr exp)
        (makeLambda 
            (cdadr exp)     ; formal parameters
            (cddr exp)      ; body
        )
    )
)

; lambda expressions are lists that begin with the symbol lambda
(define (isLambda exp) (isTaggedList exp 'lambda))
(define (lambdaParameter exp) (cadr exp))
(define (lambdaBody exp) (cddr exp))

(define (makeLambda parameters body)
    (cons 'lambda (cons parameters body))
)

(define (isIf exp) (isTaggedList exp 'if))
(define (ifPredicate exp) (cadr exp))
(define (ifConsequent exp) (caddr exp))
(define (ifAlternative exp)
    (if (not (null? (cdddr exp)))
        (cadddr exp)
        'false
    )
)

(define (makeIf predicate consequent alternative)
    (list 'if predicate consequent alternative)
)

(define (isBegin exp) (isTaggedList exp 'begin))
(define (beginAction exp) (cdr exp))
(define (isLastExp  seq) (null? (cdr seq)))
(define (firstExp   seq) (car seq))
(define (restExp    seq) (cdr seq))

(define (sequenceToExp seq)
    (cond
        ((null? seq) seq)
        ((isLastExp seq) (firstExp seq))
        (else (makeBegin seq))
    )
)
(define (makeBegin seq) (cons 'begin seq))

;---------------------------application related--------------------------

; A procedure application is any compound expression that is not
; one of the above expression types. The car of the expression is
; the operator, and the cdr is the list of operands

(define (isAppication exp) (pair? exp))
(define (operator exp) (car exp))
(define (operand  exp) (cdr exp))
(define (isNoOperand  ops) (null? ops))
(define (firstOperand ops) (car ops))
(define (restOperand  ops) (cdr ops))

;---------------------------cond related--------------------------

; One clause includes predicate condition and corresponding action
; eg: 
;   (cond 
;       ((<predicate>) <action>) ; one clause
;       ((<predicate>) <action>)
;       (else <action>)
;   )
(define (isCond exp) (isTaggedList exp 'cond))
(define (condClause exp) (cdr exp))                
(define (isCondElseClause clause)                   
    (eq? (condPredicate clause) 'else)
)
(define (condPredicate clause) (car clause))
(define (condAction clausee) (cdr clause))
(define (condToIf exp) (expandClause (condClause exp)))
(define (expandClause clause)
    (if (null? clause)
        'false      ; no else clause
        (let
            ((first (car clause)) (rest (cdr clause)))
            (if (isCondElseClause first)
                (if (null? rest)
                    (sequenceToExp (condAction first))
                    (error "ELSE clause isn't last: condToIf" clause)
                )
                (makeIf
                    (condPredicate first)
                    (sequenceToExp (condAction first))
                    (expandClause rest)
                )
            )
        )
    )
)