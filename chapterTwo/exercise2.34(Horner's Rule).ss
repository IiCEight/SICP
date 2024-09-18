(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op 
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)

(define (hornerEval x coefficientSequence)
    (accumulate 
        (lambda (coeff highTerms)
            (+ coeff (* x highTerms))
        )
        0
        coefficientSequence
    )
)

(display (hornerEval 2 (list 1 3 0 5 0 1)))

(exit)