(define (composition f g)
        (lambda (x) (f (g x)))
)


(define (repeated f n)
    (define (dfs g x n)
            (if (= n 1)
                (g x)
                (dfs (composition g f) x (- n 1))
            )
    )
    (lambda (x) (dfs f x n))
)

(define (inc x)
    (+ x 1)
)
(define (square x)
        (* x x)
)

(display ((repeated square 2) 5) )

(exit)