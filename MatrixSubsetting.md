##


We can subset a matrix by
+ row and column indices
+ a k x 2 matrix of row-column index pairs
+ a logical matrix with the same dimensions that 



Consider a simple, toy matrix 
```r
m = matrix(1:15, 5, 3, byrow = TRUE)
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9
[4,]   10   11   12
[5,]   13   14   15
```
Something this simple allows us to do the calculations in our head to see what R
is doing.

Suppose we want to extract the elements from the upper triangular part of the matrix,
include the diagonal itself.
So we want the values 1, 2, 3, 5, 6, and 9.

We want all the elements where the column number is greater
than or equal to the row index.


## 

What if we try
```
 m[c(1, 1, 1, 2, 2, 3), c(1, 2, 3, 2, 3, 3) ]
```
This works as we discussed previously, but not necessarily as we want.
Consider the first index vector, i.e. for the rows.
```
 m[c(1, 1, 1, 2, 2, 3), ]
```
This will get the first row 3 times, then then second row twice and the third row once.
So we will end up with six rows and 3 columns:
```
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    1    2    3
[3,]    1    2    3
[4,]    4    5    6
[5,]    4    5    6
[6,]    7    8    9
```
Then if we apply the column subsetting `c(1, 2, 3, 2, 3, 3)`,
we would get the first three columns, followed by the second and third, and then third, so again
six columns with repeats.


In general, when we have `x[i, j]`, you can break this down into
`x[i,][, j]`.


## Subsetting by Row-Column Index Pairs

We can create a k x 2 matrix in which each row 
contains the row and column number of an element we want.
We can create this manually
```
cbind(row = c(1, 1, 1, 2, 2, 3), column = c(1, 2, 3, 2, 3, 3)) 
     row column
[1,]   1      1
[2,]   1      2
[3,]   1      3
[4,]   2      2
[5,]   2      3
[6,]   3      3
```
We are specifying all the elements on the first row, the last 2 elements on the second row,
and the third element of the third row.

We can use this to subset m:
```r
m[cbind(row = c(1, 1, 1, 2, 2, 3), column = c(1, 2, 3, 2, 3, 3)) ]
[1] 1 2 3 5 6 9
```


 


## Subsetting a Matrix by a Logical Matrix.
One way to get this is to create a 5 x 3 matrix (same dimensions as m)
of logical values with TRUE for the cells we want to extract and
FALSE for the others.
We want
```
i
      [,1]  [,2]  [,3]
[1,]  TRUE  TRUE  TRUE
[2,] FALSE  TRUE  TRUE
[3,] FALSE FALSE  TRUE
[4,] FALSE FALSE FALSE
[5,] FALSE FALSE FALSE
```
and then we can use this to subset m to get what we want.
```
m[i]
[1] 1 2 5 3 6 9
```

One way to create the matrix i is  to use the functions row() and col().
row() creates a matrix with all the values in each row equal to that row number.
Similarly, col() creates a matrix with all the elements in each column equal to the column number,
e.g.,
```r
 col(m)
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    1    2    3
[3,]    1    2    3
[4,]    1    2    3
[5,]    1    2    3
```

So
```
i = ( col(m) >= row(m) )
```





