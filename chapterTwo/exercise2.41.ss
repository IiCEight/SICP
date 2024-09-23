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

(define (flatmap proc seq)
    (accumulate append nil (map proc seq))
)

(define (filter predicate sequence)
    (cond 
        ((null? sequence) nil)
        ((predicate (car sequence))
            (cons 
                (car sequence)
                (filter predicate (cdr sequence))
            )
        )
        (else (filter predicate (cdr sequence)))
    )
)


(define (generateTriple n)
    (flatmap 
        (lambda (i)
            (flatmap
                (lambda (j)
                    (map
                        (lambda (k)
                            (list k j i)
                        )
                        (enumerateInterval 1 (- j 1))
                    )
                )
                (enumerateInterval 1 (- i 1))
            )
        )
        (enumerateInterval 1 n)
    )
)

(define (filterSumS s seq)
    (filter
        (lambda (triple)
            (= (accumulate + 0 triple) s)
        )
        seq
    )
)
(display (generateTriple 5))

; (display (filterSumS 10 (generateTriple 10)))

(exit)