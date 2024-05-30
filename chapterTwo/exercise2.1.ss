(define (makeRate n d)
        (if (< (* n d) 0)
            (cons (- 0 (abs n)) (abs d))
            (cons (abs n) (abs d))
        )
)

(define (numerator x) (car x))
(define (denominator x) (cdr x))

(define x (makeRate 3 35))

(define (showRate x)
    (display (numerator x) )
    (display "/")
    (display (denominator x) )
    (newline)
)

(showRate x)

(exit)