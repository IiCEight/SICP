(define (makePoint x y)
        (cons x y)
)

(define (xAxis p) (car p))
(define (yAxis p) (cdr p))


(define (showPoint p)
    (display "(")
    (display (xAxis p) )
    (display ",")
    (display (yAxis p) )
    (display ")")
    (newline)
)

(define (makeSegment s e)
        (cons s e)
)

(define (startPoint segment) (car segment))
(define (endPoint segment) (cdr segment))

(define (average a b)
        (/ (+ a b) 2)
)

(define (midpoint segment)
        (makePoint (average (xAxis (startPoint segment))  
                            (xAxis (endPoint segment)) 
                   )
                   (average (yAxis (startPoint segment))  
                            (yAxis (endPoint segment)) 
                   )
        )
)
(define seg (makeSegment (makePoint 1 2)  (makePoint 2 3)))


(showPoint  (midpoint seg))


(exit)