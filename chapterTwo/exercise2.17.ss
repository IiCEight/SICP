(define (lastPair l)
        (if (null? (cdr l))
            (car l)
            (lastPair (cdr l))
        )
)

(display (lastPair (list 23 72 149 34 1234 42)))

(exit)