(define (factorial n)
    (define (iter-fact x n)
        (if (= n 1) x
                    (iter-fact (* x n) (- n 1))
        )
    )
    (if (= n 0) 1
                (iter-fact 1 n)
    )
)

;It can be compute by combination C_b^a = b! /(a!(b - a)!)
(define (pascal a b)
        (/ (factorial b) (* (factorial a) (factorial (- b a))))
)

(display (pascal 2 4))
(exit)