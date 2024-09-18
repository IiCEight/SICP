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

(display (accumulateN + 0 (list (list 1 2 3 4) (list 1 2 3 4))))
; (newline)

(exit)