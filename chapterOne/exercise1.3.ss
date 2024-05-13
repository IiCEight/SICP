;solution one:
(define (square x)
        (* x x)
)

(define (largerSquareSum a b c)
    (cond ((and (>= a b) (>= b c)) (+ (square a) (square b))) 
          ((and (>= b a) (>= a c)) (+ (square a) (square b)))
          ((and (>= a c) (>= c b)) (+ (square a) (square c)))
          ((and (>= c a) (>= a b)) (+ (square a) (square c)))
          ((and (>= b c) (>= c a)) (+ (square c) (square b)))
          ((and (>= c b) (>= b a)) (+ (square c) (square b)))
    )
)
;solution two:
(define (max a b)
        (if (>= a b) a b)
)
(define (min a b)
        (if (<= a b) a b)
)
; The middle of three is equal to the sum minus max and min 
(define (newLargerSquareSum a b c)
    (define maxOfThree (max (max a b) c))
    (define minOfThree (min (min a b) c))
        (+
            (square maxOfThree)
            (square (- (+ a b c) (+ maxOfThree minOfThree)))
        )
)

(display (newLargerSquareSum 2 4 1))
(exit)