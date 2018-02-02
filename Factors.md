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
The simple idea is that since a factor is really an integer vector
with values between 1 and the number of levels, we can use it to subset
another vector that parallels the levels.
For example, we can subset a vector of color values with the same
length as the levels, i.e.,
```r
plot(x, y, col = colors[ my.factor ])
```
The same applies for plotting characters.

We could also do this with names, e.g.,
```r
names(colors) = levels(my.factor)
colors[ as.character( my. factor) ]
```
but direct subsetting by using the factor values as indices is more direct.

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






# Creating a Factors with Levels and Labels

Consider the following vector
```r
x = c("A", "A", "B", "C", "A", "B")
[1] "A" "A" "B" "C" "A" "B"
```

Now we create a factor
```r
factor(x)
[1] A A B C A B
Levels: A B C
```

We can also specify the levels and/or the labels 
```r
factor(x, labels = c("x1", "x2", "x3"))
[1] x1 x1 x2 x3 x1 x2
Levels: x1 x2 x3
```

```r
 factor(x, levels = c("C", "B", "A"))
[1] A A B C A B
Levels: C B A
```


Consider

```
x = c("A", "B", "B", "A", "C")
```

```
factor(x)
[1] A B B A C
Levels: A B C
```

Now let's specify a different set of levels
```
factor(x, c("X", "Y", "Z"))
[1] <NA> <NA> <NA> <NA> <NA>
Levels: X Y Z
```
None of the values were found in the levels vector.

But if our goal was to relabel the levels, we can use
```
factor(x, labels = c("X", "Y", "Z"))
[1] X Y Y X Z
Levels: X Y Z
```
This maps A, B, C to X, Y, Z


The labels parameter also allows us to map two or more levels to one (new) level
```
184> factor(x, labels = c("A", "B", "B"))
[1] A B B A B
Levels: A B
```
There is no C in the result and it was mapped to B.

We can also do all of this by manipulating the levels attribute.
