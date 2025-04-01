; evaluate from left to right
(define (listOfValues exp env)
    (if (isNoOperand exp)
        '()
        (let
            ((firstExpValue (eval (firstOperand exp) ebv)))
            (cons
                firstExpValue
                (listOfValues (restOperand exp) env)
            )
        )
    )
)

; right to left is similar by using let