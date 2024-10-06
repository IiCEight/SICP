; awesome

(define (make-from-mag-ang r a)
    (define (dispatch op)
        (cond 
            ((eq? op 'real-part) (* r (cos a))) 
            ((eq? op 'imag-part) (* r (sin a))) 
            ((eq? op 'magnitude) r) 
            ((eq? op 'angle) a)
            (else (error "Unkown op --- MAKE-FROM-MAG-ANG" op))
        )
    )
    dispatch
)

(define z (make-from-mag-ang 1 3.1415926))

(display (z 'real-part))

(exit)