(define (square x) (* x x))

(define (squareList items)
        (if (null? items)
            items
            (cons (square (car items))
                (squareList (cdr items))
            )
        )
)


(define (squareListMap items)
        (map square items)
)

(display (squareListMap (list 1 2 3 4)))

(exit)