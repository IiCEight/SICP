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

he let expression binds variables to values and evaluates a body of expressions using these bindings. 

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

Scheme standardly provides a map procedure that is more general than the one described here. is more general map takes a procedure of n arguments, together with n lists, and applies the procedure to all the first elements of the lists, all the second elements of the lists, and so on, returning a list of the results.

```scheme
map(+ (list 1 2 3 4) (list 1 2 3 4)) ; (2 4 6 8)
```


#### Hierarchical Structures

```scheme
(cons (list 1 2) (list 3 4))
```
The result is `((1 2) 3 4)`. Now `car` will get a list.

```scheme
(define x (cons (list 1 2) (list 3 4)))
(length x)
```
It will get `3`.

So we need to count the number of leaves of a list.

To aid in writing recursive procedures on trees, Scheme provides the **primitive** predicate `pair?`, which tests whether its argument is a pair.

#### append
```scheme
(define x (list (list 1) 2))
(define y (list 3 4))
(define z (append x y))

(display x) ; ((1) 2)
(newline)
(display z) ; ((1) 2 3 4)
```
It will remove one pair of parentheses and add one in the external.

More examples:
```scheme
(define x (list)) ; ()
(define y (list 3 4)) ; (3 4)

(cons x y); (() 3 4)
(append x y); (3 4)
(list x y); (() (3 4))
```
`(list a b)` will remain a,b unchanged and add one pair of parentheses of them (a b).

`(cons a b)` will remain a but remove one external pair of parentheses of b (if exists) and add one pair of parentheses of them.

`(append a b)` will remove one external pair of parentheses of a and b and then add one pair of parentheses of them.


#### Horner’s rule

In fact, it is possible to prove that any algorithm for evaluating arbitrary polynomials must use at least as many additions and multiplications as does Horner’s rule, and thus Horner’s rule is an **optimal** algorithm for polynomial evaluation.

#### flatmap

```scheme
(define (flatmap proc seq)
    (accumulate append nil (map proc seq))
)
```

#### Picture Language(Skipped)



### 2.3 Symbolic Data

```scheme
(define a 1)
(define b 2)
(list a b)
(1 2)
(list 'a 'b)
(a b)
(list 'a b)
(a 2)
```

Strictly, our use of the quotation mark violates the general rule that all compound expressions in our language should be delimited by parentheses and look like lists. We can recover this consistency by introducing a special form quote, which serves the same purpose as the quotation mark. us, we would type (quote a) instead of 'a, and we would type (quote (a b c)) instead of '(a b c).

```scheme
(car '(a b c))
a
(cdr '(a b c))
(b c)
```

In keeping with this, we can obtain the empty list by evaluating `'()`, and thus dispense with the variable `nil`.

One additional primitive used in manipulating symbols is `eq?`, which takes two symbols as arguments and tests whether they are the same.

#### memq
```scheme
(define (memq item x)
	(cond
		((null? x) falsh)
		((eq? item (car x)) x)
		(else (memq item (cdr x)))
	)
)
```

for example:

```scheme 
(memq 'apple '(pear banana prune))
```



### 2.4 Multiple Representations for Abstract Data

We begin with the simple complex-number example. We will see how type tags and data-directed style enable us to design separate rectangular and polar representations for complex numbers while maintaining the notion of an abstract “complex-number” data object.



#### Message passing
See at page 252




### 2.5 Systems with Generic Operations


#### Hierarchies of types



## 3 Modularity, Objects, and State
#### 3.1.1 Local State Variables
This **Local State Variables** will store even after this function is called. This Local State Variables describing the actual state of function.

#### set!

```scheme
(set! <name> <new-value>)
```


#### begin

```scheme
(begin <exp1> <exp2> ... <expk>)

```

Evaluate exp1, and then evaluate exp2,and so on. Finally return the evaluation of expk.

Now we give a gobal state variable as an example:
```shceme
(define balance 100)
(define (withdraw amount)
	(if (>= balance amount)
		(begin (set! balance (- balance amount)) balance)
		"Insufficient funds"
	)
)

(withdraw 25)
75
(withdraw 25)
50
(withdraw 60)
"Insufficient funds"
(withdraw 15)
35
```
**Note:** Balance is a **Global state variable**. `(withdraw 25)` Evaluated two times with the same parameter but gives different value. **This is not a pure function since it depends on global state variable `balance`**

However this presents a problem. As specified above, balance is a name defined in the global environment and is freely accessible to be examined or modified by any procedure.

It would be much beer if we could somehow make balance
internal to withdraw, so that withdraw would be the only procedure that could access balance directly and any other procedure could access balance only indirectly (through calls to withdraw). This would more accurately model the notion that balance is a **local state variable** used by `withdraw` to keep track of the state of the account..

We can make balance internal to withdraw by rewriting the definition as follows:
```scheme
(define new-withdraw
	(let ((balance 100))
		(lambda (amount)
			(if (>= balance amount)
				(begin (set! balance (- balance amount)) balance)
				"Insufficient funds"
			)
		)
	)
)
```
What we have done here is use `let` to establish an environment with a
local variable balance, bound to the initial value 100.

#### 3.1.2 The Benefits of Introducing Assignment