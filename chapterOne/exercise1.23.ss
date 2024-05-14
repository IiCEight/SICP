; It seems like my compiler doesn't support runtime
(define (square x)
        (* x x)
)

(define (timed-prime-test n)
        (start-prime-test n)
)

(define (smallest-divisor n)
        (find-divisor n 2)
)

(define (next n)
    (if (= n 2) 1 2)
)

(define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor (next test-divisor))))
        )
)
(define (divides? a b)
        (= (remainder b a) 0)
)

(define (prime? n)
    (= n (smallest-divisor n))
)

(define (report-prime n count)
    (display n)
    (newline)
    (search-for-primes (+ n 1) (- count 1))
)

(define (search-for-primes n count)
    (cond ((> count 0)
                (if (prime? n) (report-prime n count)
                            (search-for-primes (+ n 1) count)
                )
          )
    )
)

(search-for-primes 53456 3)
(exit)