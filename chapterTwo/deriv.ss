(define (variable? x) (symbol? x))

(define (sameVariable? v1 v2) 
    (and
        (variable? v1)
        (variable? v2)
        (eq? v1 v2)
    )
)

(define (=number? exp num) (and (number? exp) (= exp num)))

; (define (makeSum x y) (list '+ x y))
(define (makeSum x y)
    (cond
        ((=number? x 0) y)
        ((=number? y 0) x)
        ((and (number? x) (number? y)) (+ x y))
        (else (list '+ x y))
    )
)


; (define (makeProduct x y) (list '* x y))

(define (makeProduct m1 m2)
    (cond 
        ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))
    )
)

(define (sum? x) 
    (and
        (pair? x)
        (eq? (car x) '+)
    )
)

; second item
(define (addend s) (cadr s))
; third item
(define (augend s) (caddr s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

; second item
(define (multiplier x) (cadr x))
; third item
(define (multiplicand x) (caddr x))



; dexp/dvar
(define (deriv exp var)
    (cond
        ((number? exp) 0)
        ((variable? exp)
            (if (sameVariable? exp var) 1 0)
        )
        ; (u+v)' =u' + v' 
        ((sum? exp) 
            (makeSum 
                (deriv (addend exp) var)
                (deriv (augend exp) var)
            )
        )
        ; (uv)'=uv'+u'v
        ((product? exp)
            (makeSum 
                (makeProduct 
                    (multiplier exp)
                    (deriv (multiplicand exp) var)
                )
                (makeProduct
                    (deriv (multiplier exp) var)
                    (multiplicand exp)
                )
            )
        )
        (else (display "error"))
    )
)

(display (deriv '(* x y) 'x ) )

(exit)