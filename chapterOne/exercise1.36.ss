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



(display (fixedPoint 
                    (lambda (x) (/ (log 1000) (log x)))
                    2
         )

)

(exit)
