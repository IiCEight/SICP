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
                (/ (fn cnt) (+ (fd cnt) (contFrac fn fd k (+ cnt 1) )))
        )
)

(define (fn i)
    (if (= (remainder i 3) 2)
        (* 2.0 (/ (+ i 1) 3))
        1.0
    )
)

; (display (dn 11))
; (newline)
(display (+ 2 (contFrac (lambda (i) 1.0) fn 100 1)) )

(exit)
