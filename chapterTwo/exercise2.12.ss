(define (makeCenterPercent c p) 
        (cons (- c (* c p))
              (+ c (* c p))
        )
)

(define (upperBound x) (car x) )
(define (lowerBound x) (cdr x) )

(define (center i)
(/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
    (define c (center i))
    (/ c (- c (lowerBound i)))
)


(exit)