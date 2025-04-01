(define (eval exp env)
    (cond
        ((isAnd exp) (evalAnd (andExp exp) env))
        ((isOr  exp) (evalOr  (orExp) env))
    )
)

(define (isAnd exp) (isTaggedList exp 'and))

; first item is operator and rest are expressions
(define (andExp exp) (cdr exp))

(define (evalAnd exp env)
    (cond
        ((null? exp) #t)
        ((isLastExp exp) (eval exp env))
        ((= (eval (firstExp exp) env) #f) #f)
        (else
            (evalAnd (restExp exp) env)
        )
    )
)

; or is the same