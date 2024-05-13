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

(display (qpow 3 4))
(exit)