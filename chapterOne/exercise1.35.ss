(define tolerance 0.00001)

(define (closeEnough? lhs rhs)
        (< (abs (- lhs rhs)) tolerance)
)

(define (try guess f)
        ;next = f(guess);
        (let ( (next (f guess)) )
             (if (closeEnough? guess next)
                 next
                 (try next f)
             )
        )
)

(define (fixedPoint f guess)
    (try guess f)
)

(define (average lhs rhs)
        (/ (+ lhs rhs) 2)
)

(define goldenRatioInv
                                ;(1 + 1/x)
        (fixedPoint (lambda (x)  (+ 1.0 (/ 1 x)) ) 
                    1
        )
)

; (display (productIter identity 1 4 next 1))
; (display (fixedPoint cos 1))

(display (/ 1 goldenRatioInv) )
(exit)
