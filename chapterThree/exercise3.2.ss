(define (makeMonitored f)
    ; create a local state variable
    (let 
        ((count 0))
        (lambda (parameter)
            (cond
                ((eq? parameter 'howManyCalls?) count)
                ((eq? parameter 'resetCount) (set! count 0))
                (else
                    (begin
                        (set! count (+ count 1))
                        (f parameter)
                    )
                )
            )
        )
    )

)

(define (square x)
    (* x x)
)

(define moniteredSquare (makeMonitored square))

(display (moniteredSquare 2))

(newline)
(display (moniteredSquare 3))

(newline)
(display (moniteredSquare 4))

(newline)
(display (moniteredSquare 'howManyCalls?))
(newline)
(display (moniteredSquare 'resetCount))
(newline)

(display (moniteredSquare 2))
(newline)
(display (moniteredSquare 'howManyCalls?))


(exit)