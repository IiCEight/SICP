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


(define (contFrac fn fd k cnt)
        (if (> cnt k)
                0
                (/ (fd cnt) (+ (fd cnt) (contFrac fn fd k (+ cnt 1) )))
        )
)


(display (contFrac (lambda (i) 1.0) (lambda (i) 1.0) 1000 1) )

(exit)
