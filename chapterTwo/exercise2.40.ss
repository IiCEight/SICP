(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op 
            (car sequence)
            (accumulate op initial (cdr sequence))
        )
    )
)
(define nil '())
(define (accumulateN op init seq)
    (if (null? (car seq))
        nil
        (cons 
            (accumulate op init (map car seq)) ; Amazing!
            (accumulateN op init (map cdr seq)) 
        )
    )
)

(define (enumerateInterval l r)
    (if (> l r)
        nil
        (cons
            l
            (enumerateInterval (+ l 1) r)
        )
    )
)


(define (generatePair n)
    (accumulate 
        append 
        nil 
        (map 
            (lambda (i)
                (map
                    (lambda (j)
                        (list j i)
                    )
                    (enumerateInterval 1 (- i 1))
                )
            )
            (enumerateInterval 1 n)
        )
    )
)

(display (generatePair 4))

(exit)