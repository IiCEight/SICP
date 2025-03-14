; NICE ONESHIT ONETRY

(define NULL '())
; x received as a list or pair
(define (countPair x)
    ; when countPair is called, it will create a environment with a local variable 
    ; existPairs. Once we iterate list and meet a pair which is not in existPairs
    ; we count one pair and add it into existPairs.
    (let
        ((existPairs NULL))

        ; this funtion has side effect.
        (define (isPairFirstCounted remainPairs checkPair)
            (if (eq? remainPairs NULL)
                (begin
                    ;Note that we insert new pair to the head of existPairs
                    (set! existPairs (cons checkPair existPairs))
                    1
                )
                (if (eq? (car remainPairs) checkPair)
                    0
                    (isPairFirstCounted (cdr remainPairs) checkPair)
                )
            )
        )

        (define (dfs x)
            (if (not (pair? x))
                0
                (+
                    (dfs (car x))
                    (dfs (cdr x))
                    (isPairFirstCounted existPairs x)
                )
            )
        )
        ; body of let
        (dfs x)
    )
)

(define pairOne (cons 5 6))
(define x (list 1 2 3 4))

(define y (cons pairOne pairOne))

(display (countPair y))

(exit)

