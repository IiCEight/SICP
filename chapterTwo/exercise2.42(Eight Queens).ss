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

(define (safe? k posi)
    
)


(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens)
                        (map 
                            (lambda 
                                (new-row)
                                (adjoin-position new-row k rest-of-queens)
                            )
                            (enumerate-interval 1 board-size)
                        )
                    )
                    (queen-cols (- k 1))
                )
            )
        )
    )
    (queen-cols board-size)
)


(display (generateTriple 5))

(exit)