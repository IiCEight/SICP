(define (pushFront l x)
        (cons x l)
)

(define (deepReverse x)
        (if (pair? x)
            (append
                (deepReverse (cdr x))
                (list (deepReverse (car x)))
            )
            x
        )
)

(define (deep-reverse x) 
(if (pair? x) 
    (append (deep-reverse (cdr x))  
            (list (deep-reverse (car x)))) 
    x)) 

(define x (list 1 2))
(define y (list 3 4))
(define z (list x y))

(display (deepReverse (list 23 72 149 34 1234 42)))
(newline)
(display (deepReverse z))


(exit)