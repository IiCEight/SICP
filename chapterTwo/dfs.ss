(define (dfs x)
    (if (pair? x)
        (cons
            (dfs (car x))
            (dfs (cdr x))
        )
        x
    )
)
