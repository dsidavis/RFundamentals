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
These are ordered collections of elements.

**Vectors** are homogeneous in that all the elements must have the same type
and R will make this happen automatically by coercion.

**Lists** can be heterogeneous, i.e. each element can have a different type.


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


# Names of Vector Elements

Vectors are ordered collections of elements.

The elements may have names.  We can then refer to the elements
by name rather or position.

The names() function returns a character vector of the names, or `NULL`.
We can set the names() with
```
 names(x) = c("a", "b", "c")
``` 

# Attributes

names() are treated as attributes of an object.
We can have arbitrary attributes on an object.
names is special, as is dim, class, row.names, and other important
foundational attributes.

One can get the attributes of an object with
```
attributes(mtcars)
```

We can get an individual attribute with attr()
```
attr(mtcars, "row.names")
```

We can also set an attribute with attr()
```
attr(mtcars, "origin") = "myData.csv"
```
Then we can query it with
```
attr(mtcars, "origin") 
```

The function str() shows attributes.

The function structure() is also convenient for creating
objects and associating one or more attributes on the object.
```
x = structure(1:26, names = LETTERS, class = c("alphabet"))
```


# Data Frame

While the order may not be important for statistical analysis,
it is often important for data analysis, e.g. to match observations
in two vectors where the i-th element in one vector corresponds
to the same observational unit in the other vector.


We can keep measurements from the same observational units
in two "parallel" vectors.

Alternatively, we can combine two or more 'parallel' vectors in
a data.frame.

A data.frame is a list. Check the typeof() of a data.frame.
The elements of the list are the columns.
But a data.frame has extra properties  than a list.
Every element of the list has to have the same length as all the others.
e.g.,
```r
x = data.frame(a = 1:10, b = 1:10)
71> x$y = 1:100
Error in `$<-.data.frame`(`*tmp*`, "y", value = 1:100) : 
  replacement has 100 rows, data has 10
```
But, via the recycling rule,
```r
x$y = 1
```
works fine. 1 is repeated nrow(x) times.


A data frame is guaranteed to be 2-dimensional - it has a dim().
The names() are the names of the elements. This comes from being a list.
We can subset using the list operations, e.g. df[["y"]], df$y.

We can also use 2-dimensional subsetting
```r
df[ i, j]
```
[See 2-D Subsetting](Subsetting2D.html).




