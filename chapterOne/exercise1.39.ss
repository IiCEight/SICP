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

(define (average lhs rhs)
        (/ (+ lhs rhs) 2)
)


(define (contFrac x fn fd k cnt)
        (if (> cnt k)
                0
                (/ (fn x cnt) (- (fd cnt) (contFrac x fn fd k (+ cnt 1) )))
        )
)

(define (fd i)
        (- (* 2 i) 1)
)

(define (fn x i) 
        (if (= i 1) x (square x))
)

(define (tanContFrac x k)
        (contFrac x fn fd k 1)
)



(display (tanContFrac 1.0 100) )

(exit)
