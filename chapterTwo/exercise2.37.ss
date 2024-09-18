(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op 
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)

(define (accumulateN op init seq)
    (define nil '())
    (if (null? (car seq))
        nil
        (cons 
            (accumulate op init (map car seq)) ; Amazing!
            (accumulateN op init (map cdr seq)) 
        )
    )
)

(define (dotProduct u v)
    (accumulate + 0 (map * u v))
)

(define (matrixTimesVector m v)
    (map 
        (lambda (u) (dotProduct u v))
        m
    )
)

(define matrix 
    (list
        (list 1 2 3 4)
        (list 4 5 6 6)
        (list 6 7 8 9)
    )
)

(define m1 
    (list
        (list 1 2)
        (list 3 4)
        (list 5 6)
    )
)
(define m2
    (list
        (list 1 2 1)
        (list 3 4 5)
    )
)


(define (transpose m)
    (accumulateN cons (list)  m)
)

(define (matrixTimesMatrix m n)
    (let 
        ((cols (transpose n)))
        (map (lambda (v) (matrixTimesVector cols v)) m)
    )
)

(display (dotProduct (list 1 2 3 4) (list 1 2 3 4)))
(newline)
(display (matrixTimesVector matrix (list 1 2 3 4)))
(newline)
(display (transpose matrix ))

(newline)
(display (matrixTimesMatrix m1 m2))

(exit)