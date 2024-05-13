(define (square x)
        (* x x)
)
;compute from f(n) to f(1)
(define (recursiveF n)
    (if (< n 3) n
                ( +
                    (recursiveF (- n 1))
                    (* (recursiveF (- n 2)) 2)
                    (* (recursiveF (- n 3)) 3)
                )
    )
)
;compute from f(1) to f(n)
(define (iterativeF n)
    (define (iter-f fn fn-1 fn-2 n)
            (if (= n 0) fn
                (iter-f
                        (+ fn
                            (* fn-1 2)
                            (* fn-2 3)
                        )
                        fn fn-1 (- n 1)
                )
            )
    )
    (if (< n 3) n
                (iter-f 2 1 0 (- n 2))
    )
)

(display (recursiveF 11))
(newline)
(display (iterativeF 11))
(exit)