# Vectorized Operations

R is a vectorized language.
There are no scalar values - these are vectors of length 1.
And most of the built-in R functions operate on vectors of inputs.

There are two aspects of vectorization
+ element-wise operations
+ aggregate functions

## Element-wise Operations
Functions such as +, -, ..., &, |, grepl, gregexpr,
and many more take as input a vector and return a vector
of the same length.


One example of an "unexpected" vectorization is rnorm().
This takes the number of observations/values to generate
and typically a mean and a standard deviation.
However these second and third parameters can be vectorized.
So 
```r
rnorm(3, c(-100, 0, 100), c(20, 1, 10))
```
gives 3 values from N(-100, 20), N(0, 1), and N(100, 10).

# Recyling Rule

Since R is vectorized, i.e., does element-wise operations,
what happens when we have two vectors with different lengths
in an operation, e.g.,
```r
x + 2
x - y
a & b
mapply(f, a, b)
```

The answer is generally that R makes both vectors the same length.
R takes the vector with the smaller length and extends that vector
to have the same length as the longer one.
It does this by the (equivalent of the) rep() function.
Suppose x is a vector of length n1 and y is a vector length n2
and n2 < n1.
R rep()s the y vector with
```r
rep(y, length = length(x))
```

So let's look at this with an example.
```r
x = rnorm(10)
x < 0
```
R computes this as the equivalent as 
```r
x < rep(0, length = length(x))
```

Now consider 
```r
x = rnorm(11)
x < c(0, 1)
```
We get 
```r
Warning message:
In x < c(0, 1) :
  longer object length is not a multiple of shorter object length
```
The problem here is that x has 11 elements and the right-hand-side of the < operator
has 2 elements. So when we use the recycling rule, the 2 


Recycling happens in many places.
```r
x < 1
df$newVar = 10  # repeats 10 to have the same length as the number of rows already in df
plot(x, col = "red") # repeats red length(x) times.
```
