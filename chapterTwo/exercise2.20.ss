(define (pushFront l x)
        (cons x l)
)

(define (sameParity a . b)
        (define (dfs l)
                (if (null? l)
                    (list )
                    (if (= (remainder (car l) 2) (remainder a 2))
                        (pushFront (dfs (cdr l)) (car l))
                        (dfs (cdr l))
                    )
                )
        )
    (pushFront (dfs b) a)
)

(display (sameParity 2 3 4 5 6 7))

(exit)