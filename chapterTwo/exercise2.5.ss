(define (square x)
        (* x x)
)
; calculate a^p
(define (qpow a p)
    (define (iter-qpow result producta p)
        (if (= p 0) result
            (if (even? p) (iter-qpow result (square producta) (/ p 2))
                        (iter-qpow (* result producta) producta (- p 1))
            )
        )
    )
    
    (iter-qpow 1 a p)
)

(define (even? n)
    (= (remainder n 2) 0)
)

(define (makePair a b) 
        (* (qpow 2 a) (qpow 3 b))
)

(define (first x)
    (define (dfs cnt x)
        (if (= (remainder x 2) 0) 
            (dfs (+ cnt 1) (/ x 2))
            cnt
        )
    )
    (dfs 0 x)
)

(define (second x)
    (define (dfs cnt x)
        (if (= (remainder x 3) 0) 
            (dfs (+ cnt 1) (/ x 3))
            cnt
        )
    )
    (dfs 0 x)
)


(define x (makePair 123 212))

(display (first x) )
(newline)
(display (second x) )

(exit)