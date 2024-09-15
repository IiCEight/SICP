(define (pushFront l x)
        (cons x l)
)

(define (reverse l)
        (define (dfs newlist l)
                (if (null? l)
                        newlist
                        (dfs (pushFront newlist (car l)) (cdr l))
                )
        )
        (dfs (list ) l)
)


(display (reverse (list 23 72 149 34 1234 42)))

(exit)