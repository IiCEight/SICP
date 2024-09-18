(define (squareTree x)
    (cond
        ((null? x) x)
        ((pair? x) 
            (cons
                (squareTree (car x))
                (squareTree (cdr x))
            )
        )
        (else 
            (* x  x)
        )
    )
)

(define (squareTreeMap x)
    (map
        (lambda (subTree)
            (if (pair? subTree)
                (squareTreeMap subTree)
                (* subTree subTree)
            )
        )
        x
    )
)


(display (squareTreeMap (list 1 (list 2 (list 3 4) 5)(list 6 7)) ) )

(exit)