; Note it will return a function
(define (makeAccumulator sum)
    (define (accumulator fund)
        ; first let sum = sum + fund, then return sum    
        (begin
            (set! sum (+ sum fund))
            sum
        )
    )
    accumulator
)

(define A (makeAccumulator 5))

(define B (makeAccumulator 100))

(display (A 10))
(newline)
(display (A 10))

(newline)
(display (B 10))

(exit)