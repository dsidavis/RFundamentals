
# Subsetting Data.Frames and Matrices

Subsetting a 2-dimensional object in R follows the same rules as one dimension.
We can use positions, negative positions, logical vectors, names, empty/missing indices
for each dimension.
The computation is 
```r
obj[i, j]
```
This is essentially the same as the two step
```r
obj[i, ] [, j]
```

The empty/missing index means all the elements from that dimension.
So for a data.frame df,
```r
df[, ]
```
means all of the rows and all of the columns.

```r
df[ c(1, 3, 6), ]
```
means rows 1, 3 and 6, and all of the columns.
Since this is [, we get back a data frame.


## Single Column as Vector or Data Frame?

Typically, if we subset a single column, e.g,
```r
mtcars[, "mpg"]
```
R recognizes we want that as a vector and not as a data frame with one column.

However, if we do want to ensure it is a data.frame with one column, we can use
the `drop = FALSE` in the [ ] operation, as we did for factors when we wanted to drop the levels
that were not in the subset.
So 
```r
mtcars[, 'mpg', drop = FALSE]
                     mpg
Mazda RX4           21.0
Mazda RX4 Wag       21.0
Datsun 710          22.8
Hornet 4 Drive      21.4
Hornet Sportabout   18.7
......
```
gives a data.frame with one column.

Again, like  list[[x]] where x may have more than one element, it 
can be useful to use drop = FALSE to ensure you get a data frame
in a computation such as `df[, x]` where x may have 1 or more than one element.



