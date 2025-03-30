
;----------------Stream definition--------------------

; let proc have property that many calls will
; evaluate once by memorizing the result
(define (memoProc proc)
    (let 
        ((alreadyRun #f) (result #f))
        (lambda ()
            (if (eq? alreadyRun #f)
                (begin
                    (set! result (proc))
                    (set! alreadyRun #t)
                    (display result)
                    result
                )
                result
            )
        )
    )
)

; memorize the lambda with expression we want
; to delay
(define (delay expression)
    (memoProc (lambda () expression))
)

; call such lambda will exactly evaluate the expression
(define (force delayedObject) (delayedObject))

(define (consStream a b) (cons a (delay b)))

(define (streamCar stream) (car stream))
(define (streamCdr stream) (force (cdr stream)))

(define emptyStream '())

(define (isStremNull s) (null? s))

; access stream by index
(define (streamRef s n)
    (if (= n 0)
        (streamCar s)
        (streamRef (streamCdr s (- n 1)))
    )
)

; apply proc on each item of s and form a new stream
(define (streamMap proc s)
    (if (isStremNull s)
        emptyStream
        (consStream 
            (proc (streamCar s))
            (streamMap proc (streamCdr s))
        )
    )
)

(define (streamFilter condition s)
    (cond 
        ((isStremNull s) emptyStream)
        ((condition (streamCar s))
            (consStream
                (streamCar s)
                (streamFilter condition (streamCdr s))
            )
        )
        (else
            (streamFilter condition (streamCdr s))
        )
    )
)

(define (displayLine x) (newline ) (display x))

(define (displayStream s)
    (if (isStreamNull s)
        'done
        (begin
            (displayLine (streamCar s))
            (displayStream (streamCdr s))
        )
    )
)

; this doesn't work since delay must be some special
; form, or our interpreter will evaluate before delay 
; take effects.
(define (integerStartFrom n)
    (consStream n (integerStartFrom (+ n 1)))  ; Infinite loop!
)

(exit)