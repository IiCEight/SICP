(define (fringe x) 
        (if (pair? x) 
            (append (fringe (car x))  
                    (fringe (cdr x)))
            (if (null? x)
                x
                (list x)
            )
        )
) 

(define my-tree (list 1 (list 2 (list 3 4) (list 5 6)) (list 7 (list 8)))) 

(display (fringe (list 23 72 149 34 1234 42)))
(newline)
(display (fringe my-tree))


(exit)