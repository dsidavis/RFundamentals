# (Almost) Everything is a Call

We saw that we have symbols/names such as `pi` and `x` and that 
R evaluates this by finding the symbol in an environment and
then returning the value bound to that.

We also saw literal values such as 1, 2, TRUE, FALSE, "a string".
R evaluates these as themselves.

Everything else is a function call,
e.g., numeric(), list(), plot(x, y), 1 + 2, x[1], x[2] = 10.

What about :, the sequence creation operator.
This is a function.
```r
`:`
.Primitive(":")
```

Similar to +, all the math and logic operators are functions, e.g.,
```r
`&`
function (e1, e2)  .Primitive("&")
```

What about if(), for() and while(), i.e. the control flow operators.
Indeed, these are also functions.
Consider the simple function
```r
z = function(n = 10)  
{ 
  ctr = 0 
  while(ctr < n) 
     ctr = ctr + 1
  ctr
}
```
If we call this, we get the count up to 10.

However, if we redefine `while`, we can change how this works.
```r
while =
function(...)
 101
```
Now if we call z(), we get back 0, i.e. the value we assigned to ctr in the first line.
The second expression in the body of z calls our new while function and that just returns 101.
We ignore this and so return 0.

Similarly, we can redefine if() and for().
