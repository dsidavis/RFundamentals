# Hierarchies of Vector Types in R


In data analysis, we typically have a collection of observations.
We rarely have just a single value. This is one of the reasons
why R is a vector-based "language".  We deal with samples and subsamples.

We very rarely have a sample of size 1. 
So R doesn't bother with single values, i.e. scalars.
We have vectors.  A scalar is a vector of length 1.
So 1 is a number.


We may have a single value for each observational unit.
We combine these into a single collection of values.

There are two basic types of collections in R.
vectors and lists (although we can create lists with a call to vector()!)

Vectors are homogeneous in that all the elements must have the same type
and R will insist on this

Lists can be heterogeneous, i.e. each element can have a different type.




There are 4 fundamental vector types that people encounter most often.
These are, in order,
 + logical - `TRUE`, `FALSE`
 + integer - 1L, 2L, as.integer(4)
 + numeric - 1, 1.0, 2.3443242e4, pi
 + character - "1", "1.0", "abc"
 
There is also complex  for representing complex numbers (real + imaginary part).
 
Why do we consider these vector types ordered? 
Basically, information from one can be converted without loss of information
from the previous level to the next level.  We can convert a logical value of `TRUE` to an integer
value of 1 and `FALSE` to an integer 0.  Similary, for example, we can convert an integer from 1L to
1.0, a numeric.
So a 
+ logical maps to an integer, e.g., `c( TRUE, 2L)` becomese `c(1L, 2L)`
+ integer maps to a numeric, e.g., `c(2L, 3.1)` becomes `c(2, 3.1)`. 
+ a numeric maps to a character

(Recall 3 is actually numeric, not an integer and we need to use 3L.)

Importantly, we can convert each of these back to "lower" types.
There are functions for this - as.logical(), as.integer(), as.numeric(), as.character():
```r
as.logical(2)
[1] TRUE
```
```r
as.integer("2")
[1] 2
```
But we may lose information.


After these 4 fundamental types, we have the factor type.
This is built on top of an integer



# Exercise
What is the class of 
```r
c(1:10, 20, 40)
```
?

And
```r
c(TRUE, 20L, "abc")
```

And
```r
c(TRUE, 20)
```


#

While the order may not be important for statistical analysis,
it is often important for data analysis, e.g. to match observations
in two vectors where the i-th element in one vector corresponds
to the same observational unit in the other vector.
