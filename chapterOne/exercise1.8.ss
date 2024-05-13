(define (square x)
        (* x x)
)

(define (improve y x)
    (/  (+  (/ x (square y)) (+ y y) )
        3
    )
)

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

(display (sqrt 27))
(exit)