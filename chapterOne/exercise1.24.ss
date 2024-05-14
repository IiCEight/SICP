; It seems like my compiler doesn't support runtime
(define (square x)
        (* x x)
)

(define (expmod base exp m)
 (cond ((= exp 0) 1)
 ((even? exp)
 (remainder (square (expmod base (/ exp 2) m))
 m))
 (else
 (remainder (* base (expmod base (- exp 1) m))
 m))))

(define (fermat-test n)
 (define (try-it a)
 (= (expmod a n n) a))
 (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
 (cond ((= times 0) #t)
 ((fermat-test n) (fast-prime? n (- times 1)))
 (else #f)))

(define (report-prime n count)
    (display n)
    (newline)
    (search-for-primes (+ n 1) (- count 1))
)

(define (search-for-primes n count)
    (cond ((> count 0)
                (if (fast-prime? n 20) (report-prime n count)
                            (search-for-primes (+ n 1) count)
                )
          )
    )
)

(display (search-for-primes 40 5))
(exit)