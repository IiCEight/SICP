(define (integral f a b n)
    (define (term x) 
            (+ (f x) (* 4 (f (+ x h))) (f (+ x (* 2 h))))
    )
    (define h (/ (- b a) n))
    (*  (/ h 3)
        (sumIter term a (- b (* 2 h)) next 0)
    )
)

(define (cube x) 
        (* x x x)
)
(define (next x) (+ x 1))

(define (identity x) x)


(define (productIter term l r next res)
    (if (> l r) res
                (productIter term (next l) r next (* res (term l)))    
    )
)

(define (pi n)
    (define (term x) 
            (if (= (remainder x 2) 0)
                    (/ (+ x 2) (+ x 1))
                    (/ (+ x 1) (+ x 2))
            )
    )
    (*  4.0
        (productIter term 1 n next 1)
    )
)



; (display (productIter identity 1 4 next 1))
(display (pi 10000))
(exit)
