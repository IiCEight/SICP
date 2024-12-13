; use MonteCarlo to calculate Pi

(define (square x)
    (* x x)
)
(define radius 1000000)
(define (oneTrial)
    (<= (+ (square (random (+ radius 1))) (square (random (+ radius 1)))) (square radius))
)

(define (MonteCarlo trialNum resultOfOneTrial)
    (define (iter trialRemain trialSuccess)
        (cond
            ((= trialRemain 0) (/ trialSuccess trialNum))
            ((resultOfOneTrial) 
                (iter (- trialRemain 1) (+ trialSuccess 1))
            )
            (else
                (iter (- trialRemain 1) trialSuccess)
            )
        )
    )
    (iter trialNum 0)
)

(define circleArea (* (square radius) (MonteCarlo 1000000 oneTrial)))


(display  (/ (* 4.0 circleArea) (square radius)))

(exit)