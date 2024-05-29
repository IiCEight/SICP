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

(define (average a b c)
        (/ (+ a b c) 3)
)

(define (smooth g)
    (define dx 0.00001)
        (lambda (x)
                ;(g(x + dx) - g(x)) / dx
                (average (g (- x dx)) (g x) (g (+ x dx))  )
        )
)

(display ((smooth square) 5))
(newline)
(display (((repeated smooth 10) square) 5))



(exit)