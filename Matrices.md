# Matrices

Matrices are important for linear algebra,
distances (although we typically represent only the upper-diagonal of a symmetric distance matrix), 
and a few other situations.
However, matrices are not as important for data analysis as people think,
and instead we want data frames.
Matrices and data.frames are quite similar conceptually but are represented
very differently.

Every cell in a matrix  must have the same type, e.g. logical, integer, numeric, character.
So different columns cannot have a different type.  And in fact, matrices in R are represented
as vectors so must be logical, integer, numeric, character, etc.
So all the elements will be coerced to the type that loses no information.

So there is no way to represent integer values along side  dates, real values,
strings and categorical data within a matrix.


Consider the integer matrix
```r
matrix(1:15, 5, 3)
     [,1] [,2] [,3]
[1,]    1    6   11
[2,]    2    7   12
[3,]    3    8   13
[4,]    4    9   14
[5,]    5   10   15
```
However, this is arranged column-wise as an integer vector
```r
as.integer(matrix(1:15, 5, 3))
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
```

When creating the matrix, we can use byrow = TRUE to tell  R to arrange the given elements 
along the rows, e.g.,
```r
m = matrix(1:15, 5, 3, byrow = TRUE)
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9
[4,]   10   11   12
[5,]   13   14   15
```

However, R still stores the values in column-order, i.e., the values of the first column
followed by those of the second column, and so on:
```r
as.integer(m)
[1]  1  4  7 10 13  2  5  8 11 14  3  6  9 12 15
```



Matrices are useful ways to store 2-dimensional where the types are the same and
we want to do operations that are easier and/or more efficient than a collection of vectors
or a data.frame.
See BML model simulation in Case Studies in Data Science: Nolan, Temple Lang.

We can subset matrices in the same way we can data frames, i.e.,   m[i, j].
However, matrices also support subsetting by  matrices. [See here](MatrixSubsetting.html)

