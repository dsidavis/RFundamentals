# Factors for Categorical Data

We could represent categorical data as character strings.
However, R does better than this using factors and ordered factors.
Sometimes this is not useful, but often it is.

## Factor
A factor is a vector whose elements take values from a fixed 
finite set of possible values called the levels.
Consider majors, states, ethnicities, racial groups. These are all categories.

Typically we just define a factor() by giving the observed values and R then assumes
that these are the possible levels.
```r
x = factor(sample(LETTERS[1:3], 20, replace = TRUE))
```

We can look at the levels of the factor with
```r
levels(x)
```
In this case, it is just A, B, C.

Similarly, if we had sample 20 items from the full set of 26 LETTERS,
the levels of the factor would only reflect those that were observed in the sample.
```r
set.seed(123123)
x = factor(sample(LETTERS, 20, replace = TRUE))
table(x)
x
C D E G K L N O P T Z 
1 1 1 1 3 3 4 1 1 2 2 
```
However, we often want to include all the potential possible levels - be they observed or not.
We can do this with 
```r
factor(x, levels = LETTERS)
[1] P O K N K T N L T K N E Z C Z D G L L N
Levels: A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
```

**(Repeat of above.)**
Sometimes we need to be able to indicate that there are additional categories that
were not observed in our sample. A factor allows us do this by specifying
the possible values in the levels and the observed values in the vector,
e.g.,
```r
factor(c("African American", "White", "Hispanic", ...),
       levels = c("African American", "Hispanic", "White", "Native American", "Eskimo""))
```


To summarize a factor, we can call summary() or table(). These do almost exactly the same thing.
```r
table(x)
x
 A  B  C 
 6  3 11 
```

However, `table(factor1, factor2)` gives a two way table and we can include more factors also.



Factors are very useful for subsetting. See [Subsetting](Subsetting.html)

## Ordered Factor

Some categorical variables have an implict order.
For example Freshman < Sophmore < Junior < Senior.
And for grades, A+ > A > A- > .... > F.
And we  might map a continuous variable into bins/intervals
and then the bins have a natural order, 
e.g. 
```r
z = cut(rnorm(10000, 0, 100), c(-Inf, -10, 0, 10, 30, 40, Inf), ordered = TRUE)
class(z)
[1] "ordered" "factor" 
[1] "(-Inf,-10]" "(-10,0]"    "(0,10]"     "(10,30]"    "(30,40]"   "(40, Inf]" 
levels(z)
```

R uses the ordering when displaying the computations involving the ordered
factor, e.g. in tables or on plots.

An ordered factor is a factor. This is an example of S3 inheritance.



