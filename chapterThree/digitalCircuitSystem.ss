; recursively call all procedure
; with no parameter
(define (callEach procedure)
    (if (null? procedure)
        'done
        (begin
            ((car procedure))
            (callEach (cdr procedure))
        )
    )
)

; this a procedure without parameter
; it will return a procedure called 
; dispatch
(define (makeWire)
    (let
        ((signalValue 0) (actionProcedure '() ))
        (define (setMySignal newValue)
            (if (not (= signalValue newValue))
                (begin 
                    (set! signalValue newValue)
                    (callEach actionProcedure)
                    'done
                )
            )
        )
        
        ; this procedure add new procedure into
        ; actionProcedure list and then run 
        ; new procedure one;
        (define (accpetActionProcedure proc)
            (set! actionProcedure
                (cons proc actionProcedure)
            )
            (proc)
        )

        (define (dispatch m)
            (cond
                ((eq? m 'getSignal) signalValue)
                ((eq? m 'setSignal) setMySignal)
                ((eq? m 'addAction) accpetActionProcedure)
                (else
                    (error "Unknown operation: WIRE" m)
                )
            )
        )
        dispatch
    )
)

; remeber that wire is a procedure dispatch
(define (getSignal wire) (wire 'getSignal))

(define (setSignal wire newValue)
    ((wire 'setMySignal) newSignal)
)

(define (addAction wire actionProcedure)
    ((wire 'addAction) actionProcedure)
)

(define (afterDelay delay action)
    (addToAgenda
        (+ delay (currentTime theAgenda))
        action
        theAgenda
    )
)

(define (propagate)
    (if (isEmptyAgenda theAgenda)
        'done
        (let 
            ((firstItem (firstAgendaItem theAgenda)))
            (firstItem)
            (removeFirstAgendaItem theAgenda)
            (propagate)
        )
    )
)

(define (probe name wire)
    (addAction wire
        (lambda ()
            (newline )
            (display name)
            (display " ")
            ; (display (currentTime theAgenda))
            (display " NewValue = ")
            (display (getSignal wire))
        )
    )
)

(define (logicalNot s)
    (cond 
        ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))
    )
)

(define (inverter input output)
    (define (invertInput)
        (let
            ((newValue (logicalNot (getSignal input))))
            (afterDelay 
                invertDelay
                (lambda ()
                    (setSignal output newValue)
                )
            )
        )
    )
    (addAction input invertInput)
)


(define (halfAdder a b s c)
    (let
        ((d (makeWire) ) (e (makeWire)))
        (orGate a b d)
        (andGate a b c)
        (inverter c e)
        (andGate d e s)
        'ok
    )
)

(define (makeTimeSegment time queue)
    (cons time queue)
)
(define (segmentTime s) (car s))
(define (segmentQueue s) (cdr s))


(define (makeAgenda) (list 0))

(define (currentTime agenda) (car agenda))

(define (setCurrentTime agenda time)
    (set-car! agenda time)
)

(define (segments agenda) (cdr agenda))

(define (setSegments agenda segments)
    (set-cdr! agenda segments)
)

(define (firstSegment agenda) (car (segments agenda)))
(define (restSegments agenda) (cdr (segments agenda)))

(define (emptyAgenda agenda)
    (null? (segments agenda))
)

; To be implemented
(define (addToAgenda time action agenda)
    (define (belongsBefore segments)
        (or 
            (null? segments)
            (< time (segmentTime (car segments)))
        )
    )

    (define (makeNewTimeSegment time action)
        (let ((q (makeQueue)))
            (insertQueue q action)
            (makeTimeSegment time q)
        )
    )

    (define (addToSegment segments)
        (if (= (segmentTime (car segments)) time)
            (insertQueue
                (segmentQueue (car segments))
                action
            )
            (let ((rest (cdr segments)))
                (if (belongsBefore rest)
                    (set-cdr! 
                        segments
                        (cons 
                            (makeNewTimeSegment time action)
                            (cdr segments)
                        )
                    )
                    (addToSegment rest)
                )
            )
        )
    )

    (let ((segments (segments agenda)))
        (if (belongsBefore segments)
            (setSegments
                agenda
                (cons 
                    (makeNewTimeSegment time action)
                    segments
                )
            )
            (addToSegments segments)
        )
    )
)