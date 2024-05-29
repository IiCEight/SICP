(define tolerance 0.00001)

(define (square x)
        (* x x)
)

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

(define dx 0.0001)

(define (deriv g)
        (lambda (x)
                ;(g(x + dx) - g(x)) / dx
                (/ (- (g (+ x dx)) (g x) )  dx )
        )
)

(define (newtonTransform g)
        (lambda (x) (- x (/ (g x) ((deriv g) x))))
)

(define (newtonMethod g guess)
        (fixedPoint (newtonTransform g) guess)
)

(define (cubic a b c)
        (lambda (x)
                (+ (* x x x)
                   (* a x x)
                   (* b x)
                   c
                )
        )
)

(display (newtonMethod (cubic 1 1 0) 1) )

(exit)
