
(define (composition f g)
        (lambda (x) (f (g x)))
)

(define (inc x)
    (+ x 1)
)
(define (square x)
        (* x x)
)

(display ((composition square inc) 6) )

(exit)