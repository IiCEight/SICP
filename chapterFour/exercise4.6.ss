(define (eval exp env)
    (cond
        ((isLet exp) (eval (letToCombination exp) env))
    )
)


; see page 509

(define (isLet exp) (isTaggedList exp 'let))
(define (letAssignmentClause exp) (cadr exp))
(define (letBody exp) (caddr exp))

(define (letVariable clause)
    (if (null? clause)
        '()
        (cons
            (caar clause)
            (letVariable (cdr clause))
        )
    )
)
(define (letExp clause)
    (if (null? clause)
        '()
        (cons
            (cdar clause)
            (letExp (cdr clause))
        )
    )
)

(define (letToCombination exp)
    (cons
        (cons
            'lambda
            (cons
                (letVariable (letAssignmentClause exp))
                (letbody exp)
            )
        )
        (letExp (letAssignmentClause exp))
    )
)