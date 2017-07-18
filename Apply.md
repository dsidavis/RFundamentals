
# The Apply Function Family

The *apply() functions basically perform loops over a collection of elements.
They are simpler and slightly more efficient than loops.
The are much more efficient than user-programmed loops that don't preallocate the results!

These include
+ apply() - matrices, over rows or over columns
+ lapply() - vectors/lists
+ sapply() - same as lapply() but attempts to 'S'implify the result to a vector/matrix
+ tapply(), by(), aggregate() - for split/group by and apply a function to each group
+ mapply() - looping over two or more parallel vectors, passing the i-th element of each to the function.
+ eapply() - looping over all the elements of an evironment
+ Map() - alternative version of mapply()
+ Reduce - for aggregating over a vector in a "cumulative"/rolling manner
+ rep() and replicate()

Consider a vector x with n elements.
The command
```r
lapply(x, f)
```
gives the result equivalent to
```r
list( f(x[[1]]), f(x[[2]]), ...., f(x[[n]]) )
```
That's the heart of the lapply function.



# Passing Additional Arguments to FUN

Often, we want to pass additional arguments to the function we are apply'ing.
A simple example is computing the quantiles of each column in a data.frame.
By default, we get the 0%, 25%, 50%, 75% and 100%.
If we want 0, 10, 20, , ..., 100,  we would call the quantile function as
```r
quantile(x, seq(0, 1, by = .1))
```

So in our lapply() function, we might create an anonymous function as
```r
lapply(df, function(x) quantile(x, seq(0, 1, by = .1)))
```
This is often quite convenient. However, there is a simpler version for this scenario.
It looks very similar:
```r
lapply(df, quantile,  seq(0, 1, by = .1))
```
This is the equivalent of 
```r
list( quantile(x[[1]], seq(0, 1, by = .1)), 
      quantile(x[[2]], seq(0, 1, by = .1)), 
	  ...., 
	  quantile(x[[n]], seq(0, 1, by = .1) ))
```


We can pass any number of additional arguments to our FUN in lapply().
```r
lapply(df, quantile, seq(0, 1, by = .1), TRUE, FALSE)
```

It is often much clearer to specify the arguments by name
```r
lapply(df, quantile, seq(0, 1, by = .1), na.rm = TRUE, names = FALSE)
```

It is somewhat confusing that these arguments are for FUN, and not for lapply.
So let's look at the definition of lapply, specifically the signature (i.e. parameters and default values)
```r
function (X, FUN, ...) 
{
    FUN <- match.fun(FUN)
    if (!is.vector(X) || is.object(X)) 
        X <- as.list(X)
    .Internal(lapply(X, FUN))
}
<bytecode: 0x7fca1902ae60>
<environment: namespace:base>
```
So all of the additional arguments are mapped to `...`.
What we cannot see in the definition of the function (because it calls .Internal())
is that all of the ... are passed to FUN.
So if we implemented lapply  in R code, 
it would involve calls of the form
```r
FUN( X[[i]], ...)
```

We, of course, do not have to name all arguments or specify a value for each parameter.
Instead, we can use [the way R matches arguments to parameters](FunctionCalls.html) to understand how to 
specify the arguments in the way that will match the parameters as we desire.



# Simplification in sapply()

sapply() is literally a call to lapply() followed up by an attempt to simplify the 
result. This is useful for interactive use or when we know that all calls to the function FUN will 
definitely give us a value we expect and sapply() will simplify to what we want.
For example, if FUN always returns a single scalar value (logical, integer, numeric, character), sapply() will 
collapse the result to a vector, e.g.,
```r
sapply(docTexts, function(x) any(grepl("colorado", x)))
```
The (anonymous) function will return a single logical value.
sapply() will then collapse this to a logical vector.

Is our anonymous function we are apply()'ing guaranteed to return a TRUE or a FALSE value?
What will grepl() return if the character vector `x` is the empty character vector?
It will return logical(0).  So what will any(logical(0)) return?
We might expect a logical(0), but in fact, it returns FALSE.
So our function is guaranteed to return a non-empty logical vector with length 1.

So sapply() will collapse the result to a vector.


However, consider if we had done the computations differently, by collapsing
the lines from `readLines()`, so that docTexts was a character vector
and not a list with each element a character vector of different lengths, i.e.,
the number of lines.
```r
md = list.files(pattern = "md$")
docTexts = sapply(md, function(x) paste(readLines(x), collapse = "\n"))
names(docTexts) = md
```
Note that we used sapply() rather than lapply() to collapse the result to a character vector.
Do we know that paste() will collapse an empty character to a non-empty character vector?
Yes, 
```r
paste(character(), collapse = "\n")
```
But 
```r
paste(character(), sep = "")
```
does return an empty character vector character(0) .

If by some means, each element of docTexts was a character vector,
but one or more were empty, the following command
```r
sapply(docTexts, function(x) grepl("colorado", x))
```
would result in some values being TRUE or FALSE and those corresponding
to 0-length inputs would be logical(0).

In this case, 
sapply() would loose information if it collapses the result
to a logical vecto.
Consider the following example:
```r
c(TRUE, FALSE, TRUE, logical(0), FALSE)
```
becomes
```r
c(TRUE, FALSE, TRUE, FALSE)
```
and we cannot determine which element corresponds to the input elements.


## Multiple Return Values
When a function returns more than one value and we use it as the FUN in
sapply(), sapply() might collapse the result in a different way.
If all the calls to FUN return a vector of length n, then
sapply() will create an n x length(x).
For example, we'll process each column in mtcars and compute the min and max:
```r
sapply(mtcars, function(x) c(min(x), max(x)))
      mpg cyl  disp  hp drat    wt qsec vs am gear carb
[1,] 10.4   4  71.1  52 2.76 1.513 14.5  0  0    3    1
[2,] 33.9   8 472.0 335 4.93 5.424 22.9  1  1    5    8
```
sapply essentially calls cbind() on the results of each.
Actually, more accurately, it does the equivalent of 
```r
tmp = lapply(mtcars, function(x) c(min(x), max(x)))
do.call(cbind, tmp)
```
Note the use of do.call() to call an argument 


# vapply()
Whether sapply() collapses the result may depend on the actual **contents** (i.e. the
values, not just the structure) of the vector
over which we are applying FUN.
This isn't reliable.
So using lapply() and examing the result works generally.

However, we can also use vapply() to indicate what we expect from each function call.



# mapply()

Consider two vectors, x and y.
```r
mapply(f, x, y)
```
is equivalent to
```r
c( f(x[[1]], y[[1]]), f(x[[2]], y[[2]]), ..., f(x[[n]], y[[n]]))
```

Well this is not quite true. By default, mapply() will attempt to simplify the result
like sapply() does. 
We can disable this with 
```r
mapply(f, x, y, SIMPLIFY = FALSE)
```


Note that if x and y don't have the same length, the recycling rule will come into effect
to make the shorter of these the same length as the longer.




# Exercise
Why is the function first in the call to mapply() in contrast to 
the second parameter in lapply(), sapply(), apply(), etc.



# apply()

We already discussed that matrices are not as commonly used in data analysis and
at the top-level commands as data.frames. As a result, apply() doesn't get used
as much as either.

If we do use apply(), it coerces the first argument to a matrix.
So if we pass a data.frame() with columns of different types, the elements of the matrix
will have to be of the most general type of the columns.
So, e.g.,
```r
d = data.frame(values = rnorm(26), b = letters, c = LETTERS, stringsAsFactors = FALSE)
table(apply(d, 1, class))
character 
       26 
```
So all of the row vectors passed to class() are character vectors.

The same applies if we operate column-wise:
```r
table(apply(d, 2, class))
character 
        3 
```

So not only would we make a copy of the values in the data.frame into a matrix,
we'd also make a mess of the data types.

Suppose we have stringsAsFactors = TRUE in our example.
Will apply coerce the two factor columns into character vectors or leave them as integer vectors
without the labels for the levels?
Let's see:
```r
d = data.frame(values = rnorm(26), b = letters, c = LETTERS, stringsAsFactors = TRUE)
apply(d, 1, print)
```

When we have a matrix(), we do use apply().
And apply() works for higher-dimensional arrays, i.e. 3-D, 4-D, ...
In that case, we specify a vector of dimensions over which to compute,
e.g, instead of rows, perhaps the first and third dimension with
```r
apply(arr, c(1, 3), function(x) {})
```



# When to use which apply function

+ When you have a matrix, use apply().
+ When you want to loop over row, use apply(), or lapply(seq_len(nrow(df)), function(i) df[i, ])
+ When you loop over pairs, triples, etc. of vectors, use mapply().
+ When you have a vector or list and don't know what the result of each call will be, use lapply() 
+ For a vector/list and you know the structure of the result  of each call, use vapply()
+ For a vector/list when you anticipate that the result can be simplified to a vector/matrix/array,
  use sapply() and check the results.
+ When looping over elements of an environment, use eapply(). 


