(define (square x)
        (* x x)
)

(define (average x y)
    (/ (+ x y) 2))

(define (improve guess x)
    (average guess (/ x guess)))

(define (sqrt-iter guess x lastValue)
    (if (good-enough? guess lastValue)
        guess
        (sqrt-iter (improve guess x) x guess
        )
    )
)

(define (sqrt x)
    (sqrt-iter 1.0 x 0.5))

; Here is what I do
(define (good-enough? guess lastValue)
        (< 
            (/ (abs (- guess lastValue)) guess)
            0.001
        )
)

(display (sqrt 1000000))
(exit)