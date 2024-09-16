# Structure and Interpretation of Computer Programs

## 1 Building Abstractions with Procedures

### 1.1 The Elements of Programming

#### 1.1.2 Naming and the Environment

In the Scheme dialect of Lisp, we name things with `define`. Typing

```scheme
(define size 2)
```



#### 1.1.4 Compound Procedures

```scheme
(define (<name> <formal parameters>) <body>)
(define (square x) (* x x))
```



#### 1.1.5 The Substitution Model for Procedure Application

To apply a compound procedure to arguments, evaluate the body of the procedure with each  formal parameter replaced by the corresponding argument.



#### 1.1.6 Conditional Expressions and Predicates

```scheme
(cond	(<p1> <e1>)
		(<p2> <e2>)
		...
		(<pn> <en>))
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
```

If none of the `<p>`  is found to be true, the value of the cond is **undefined**.



```scheme
(if <predicate> <consequent> <alternative>)
(define (abs x) (if (< x 0) (- x) x))
```

This uses the special form if, a restricted type of conditional that can be used when there are precisely 

**two cases** in the case analysis. 

```scheme
(and <e1> <e2> ... <en>)
(or <e1> <e2> ... <en>)
(not <e>)
(and (> x 5) (< x 10))
```

The interpreter evaluates the expressions <*e*> one at a time, in **left-to-right** order. Notice that and and or are special forms, not procedures, because the subexpressions are **not necessarily** all evaluated. Not is an ordinary procedure.



#### 1.1.8 Procedures as Black-Box Abstractions

A user should not need to know how the procedure is implemented in order to use it.

```scheme
(define (sqrt x)
 	(define (good-enough? guess x)
		(< (abs (- (square guess) x)) 0.001))
 	(define (improve guess x)
 		(average guess (/ x guess)))
 	(define (sqrt-iter guess x)
 		(if (good-enough? guess x)
 			guess
 			(sqrt-iter (improve guess x) x)))
 	(sqrt-iter 1.0 x))
```

Such nesting of definitions, called **block structure**, is basically the right solution to the simplest namepackaging problem.



Thus, it is not necessary to pass x explicitly to each of these procedures. Instead, we allow x to be a free variable in the internal definitions, as shown below. This discipline is called **lexical scoping**.

```scheme
(define (sqrt x)
	(define (good-enough? guess)
		(< (abs (- (square guess) x)) 0.001))
 	(define (improve guess)
 		(average guess (/ x guess)))
	(define (sqrt-iter guess)
 		(if (good-enough? guess)
 			guess
			(sqrt-iter (improve guess))))
 	(sqrt-iter 1.0))
```



### 1.2 Procedures and the Processes They Generate

#### 1.2.1 Linear Recursion and Iteration

In contrasting iteration and recursion, we must be careful not to confuse the notion of a **recursive process** with the notion of a **recursive procedure**.



### 1.3 Formulating Abstractions with Higher-Order Procedures

Procedures that manipulate procedures are called **higher-order** procedures.

#### 1.3.1 Procedures as Arguments

#### 1.3.2 Constructing Procedures Using lambda

In general, **lambda** is used to create procedures in the same way as define, except that no name is specifified for the procedure.

```scheme
(lambda (<formal-parameters>) <body>)
```



The general form of a let expression is

```scheme
(let ((<var1> <exp1>)
      (<var2> <exp2>)
      (<var3> <exp3>)
     )
  	<body>
)
```



#### Newton’s method 

 If $f(x)$ is a differentiable function, then a solution of the equation $f(x) = 0$ is a fixed point of the function $g(x)$, where
$$
g(x) = x - \frac {f(x)}{f'(x)}
$$





## 2 Building Abstractions with Data

#### Pair

```scheme
(define x (cons 1 2))
(car x) ;1
(cdr x) ;2
```



### Hierarchical Data and the Closure Property

The ability to create pairs whose elements are pairs is the essenceb of list structure’s importance as a representational tool. We refer to this ability as the closure property of cons.



#### List

```scheme
(list ⟨a1⟩ ⟨a2⟩ . . . ⟨an⟩)
```

 is equivalent to

```scheme
(cons ⟨a1⟩ 
      (cons ⟨a2⟩ 
            (cons . . .
				(cons ⟨an⟩
						nil). . .)))
```

Scheme includes a **primitive** predicate `null?`, which tests whether its argument is the empty list.


#### Dotted-tail notation

```scheme
(define (f x y . z) <body>)
(f 1 2 3 4 5 6)
```

Then in the body of $f$, $x$ will be 1, $y$ will be 2, and $z$ will be the list (3 4 5 6). 

see also exercise 2.20


#### Mapping over list
One extremely useful operation is to apply some transformation to each element in a list and generate the list of results.

map takes as arguments a procedureof one argument and a list, and returns a list of the results produced by applying the procedure to each element in the list

```scheme
(define (map proc items)
		(if (null? items)
			nil
			(cons (proc (car items))
				(map proc (cdr items))
			)
		)
)
(map abs (list -10 2.5 -11.6 17))
```