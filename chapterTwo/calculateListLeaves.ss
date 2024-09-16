(define (leaf x)
    (cond 
        ((null? x) 0)
        ((not (pair? x)) 1)
        (else 
            (+  (leaf (car x))
                (leaf (cdr x))
            )
        )
    )
)

(define x (cons (list 1 2) (list 3 4)))
(define y (cons 0 (list 1 2)))
(define z (cons y x))

(display (leaf x))
(newline)
(display (leaf y))
(newline)
(display (leaf z))

(exit)
