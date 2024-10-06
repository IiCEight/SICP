
; Every node is represented by a list with three element.
; First is the entry, and second is left subtree while third is right subtree
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
    (list entry left right)
)

(define (element-of-set? x set)
    (cond 
        ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
            (element-of-set? x (left-branch set))
        )
        ((> x (entry set))
            (element-of-set? x (right-branch set))
        )
    )
)

