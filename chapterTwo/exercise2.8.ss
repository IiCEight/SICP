(define (makeInterval a b) 
        (cons a b)
)

(define (upperBound x) (car x) )
(define (lowerBound x) (cdr x) )


(define (subInterval a b)
        (makeInterval (min (- (upperBound a) (upperBound b) 
                           (- (lowerBound a) (lowerBound b))))
                      (max (- (upperBound a) (upperBound b) 
                           (- (lowerBound a) (lowerBound b))))
                    
        )
)

(exit)