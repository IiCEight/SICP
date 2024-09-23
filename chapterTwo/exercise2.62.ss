(define (element-of-set? x set)
(cond ((null? set) false)
((= x (car set)) true)
((< x (car set)) false)
(else (element-of-set? x (cdr set)))))

(define (unionSet set1 set2)
    (cond
        ((and (null? set1) (null? set2)) '())
        ((and (not (null? set1)) (null? set2))
            (cons (car set1) (unionSet (cdr set1) set2))
        )
        ((and (not (null? set2)) (null? set1))
            (cons (car set2) (unionSet set1 (cdr set2)))
        )
        (else
            (let 
                ((x1 (car set1)) (x2 (car set2)))
                
                (cond 
                    ((< x1 x2)
                        (cons 
                            x1 
                            (unionSet (cdr set1) set2)
                        )
                    )
                    ((> x1 x2)
                        (cons 
                            x2 
                            (unionSet set1 (cdr set2))
                        )
                    )
                    (else
                        (cons x1 (unionSet (cdr set1) (cdr set2)))
                    )
                )
            )
        )
    )
)

(display (unionSet (list 1 2 3 8) (list 2 6 7 9)))

(exit)