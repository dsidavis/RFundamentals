# Assignments to Variables


There are three common operators to assign a value to a variable:
=, <- and ->.
These are all equivalent.

There is a fourth <<- which does "non-local"/global assignment.
This requires understanding to use properly.

The -> operator is left over from when it was hard/impossible 
to go back to the beginning of a command and add an assignment.
So one could add it at the end. Most R interfaces make it easy to jump
back to the beginning of the command and add text.

= is simpler to type than <-.

There is one case = and <- are not interchangable.
This is a call such as
```r
plot(x, abc <- rnorm(length(x)))
```
This calls rnorm(), assigns the value to the variable abc and then passes the same value
as the second **unnamed** argument to call.
However, if we change the <- to an =, i.e.,
```r
plot(x, abc = rnorm(length(x)))
```
we do not get the same effect.
abc is now the name of the argument
and we do not assign the value of rnorm() to abc in the global environment (or callers environment).

Using abc <- ... in a call is also potentially problematic due to lazy evaluation.
[See here](FunctionCalls.html#LazyEval)


Variable names cannot start with a digit.

When we assign a value at the top-level prompt,
the variable is assigned to the global environment.

Within a function, the assignment is made within the call frame.
