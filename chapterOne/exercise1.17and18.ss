; calculate a*p
(define (qmul a p)
    (define (iter-qmul result suma p)
        (if (= p 0) result
            (if (even? p) (iter-qmul result (+ suma suma) (/ p 2))
                        (iter-qmul (+ result suma) suma (- p 1))
            )
        )
    )
    
    (iter-qmul 0 a p)
)

(define (even? n)
    (= (remainder n 2) 0)
)

(display (qmul 6 9))
(exit)