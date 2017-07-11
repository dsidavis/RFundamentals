# Questions

+  What is the class of `NA`?  Why?



+
Consider the function
```
f =
function(x, len = length(x))
{
  x = x[!is.na(x)]
  sum(x)/len
}
```
Now, 
```
a = rnorm(10)
a[c(3, 9)] = NA
f(a)
```
What is the value of `n` in `sum(x)/n`?

And in
```
f(a, 20)
```


+ Why did I not use `n` as the name for the parameter `len` above?

+ Consider the function definition
```
f = 
function(x, y)
{
   if(is.numeric(x) && all(x < 0))
     return(sum(x))
	 
    x ^ y
}
```
Now we call this with 
```
 f(a, z <- 3)
```
What is the value of `z` at the end of the call?

You don't know `a`? Okay
```
a = rnorm(100, - 20, 4)
```

```
f(a, z <- 3)
```
What is `z`?

<!-- Doesn't exist - most likely?  -->

+ We define a function as
```
toPDF =
function(imgFile, outFile = removeExtension(imgFile), 
         renderer = PDFRenderer(outFile, GetDataPath(api), ...),
         api = tesseract(, PSM_AUTO), ...)
{
   args = list(...)
   args$x
}
```
Can the default value of renderer be a call that references outFile?
How will it find outFile?  And how will it find the api variable?  


+ In the function `toPDF()` above, explain the three uses of  `...`

+ Consider the function
```
area =
function(r)
{
   pi * r^2
}
```
What are the parameters? the local variables? the global/non-local variables?
Where are the global variables found?

+ Continuing from the previous question
What is `area(10)`?

+ Continuing, what is the result of 
```
pi = 2
area(10)
```


+ The `gaussian()` function is defined in stats package. It is used to define a gaussian family in a
  generalized linear model (see the help `?gaussian`).
  It uses the variable  `pi`.
  When we redefine `pi` as we did above,  will `gaussian()` behave differently?
Is this good or bad? 
If we wanted the opposite to occur, how could we do this?

+ 
```
f = 
function(x)
{
  function(theta)
     sum(log(dexp(x, theta)))
}
```
Where will f find theta?

+ Continuing from the previous question
```
d = rexp(10)
lik = f(d)
``` 
What class of object is `lik()`?


+ Continuing again 
```
sapply(seq(1, 2, by = .01), lik)
```
What is theta in each call to `lik()`.



+ Some people think it would be a good idea if R found non-local variables by walking up the **call
stack**.  Why is this not a good idea?
