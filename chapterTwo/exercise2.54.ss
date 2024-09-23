(define (equal? x y)
    (cond 
        ((and (not (pair? x)) (not (pair? y))) (eq? x y))
        ((and (pair? x) (pair? y))
            (and 
                (eq? (car x) (car y)) 
                (equal? (cdr x) (cdr y))
            )
        )
        (else #false)
    )
)

(display (equal? (list 1 2 3 1) (list 2 3 1 1)))

(exit)