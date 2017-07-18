# Data Frames

A data frame is a 2-dimensional data structure. It is different from a matrix.
The rows are observations, the columns are variables.
All columns/variables must have the same number of elements and they are
expected to be aligned so that the i-th element in each column
corresponds to the same i-th observational unit.

The purpose of a data frame is to allow each column have a different type.
This allows us to have integers in one column, logical values in another,
Dates in another, and even a vector of more complex objects, e.g.,
each element in a column might be a data frame itself, or a matrix, or a function.

A data frame is  a list. Query this with typeof().

So we can use list subsetting
```r
mtcars[ c(1, 2) ]
mtcars[ c("mpg", "wt") ]
mtcars[ grepl("^d", names(mtcars) ) ]
mtcars[[ "mpg" ]]
mtcars$mpg
```


When we assign a value to a column, e.g.,
```r
mtcars$old = TRUE
```
the recycling rule is used.
R ensures that each column (element of the list) of the data.frame 
has the same length. So R repeats TRUE nrow(mtcars) times.

So what does
```r
mtcars$old = c(TRUE, FALSE, TRUE)
```
yield.



We can use 2-dimensional subsetting  also.
See
