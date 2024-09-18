; awesome
(define (subset s)
    (if (null? s)
        (list (list)) ; return set which has one element: empty set.
        (let 
            ((rest (subset (cdr s)))) ;let rest = (subset (cdr s))
            (append
                rest
                (map
                    (lambda (x)
                        (cons (car s) x)
                    )
                    rest
                )
            )
        )
    )
)


(display (subset  (list 1 2 3 4) ))
(exit)