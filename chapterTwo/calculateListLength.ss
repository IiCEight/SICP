(define (length items)
        (define (iterLength a count)
                (if (null? a)
                    count
                    (iterLength (cdr a) (+ count 1))
                )
        )
    (iterLength items 0)
)


(display (length (list 1 2 3 4 5 6 7)))

(exit)