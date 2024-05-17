(define (integral f a b n)
    (define (term x) 
            (+ (f x) (* 4 (f (+ x h))) (f (+ x (* 2 h))))
    )
    (define (next x) (+ x (* 2 h)))
    (define h (/ (- b a) n))
    (*  (/ h 3)
        (sumIter term a (- b (* 2 h)) next 0)
    )
)

(define (cube x) 
        (* x x x)
)

(define (identity x) x)


(define (sumIter term l r next res)
    (if (> l r) res
                (sumIter term (next l) r next (+ res (term l)))    
    )
)



(display (integral cube 0 1 1000))
(exit)
