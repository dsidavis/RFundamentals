# Subsetting in R

Subsetting starts with vectors.
As we explored, there is a [hierarchy](VectorHierarchy.html) of  vector types in R.

There are several ways to subset a vector.


General rule of thumb.
+ Subsetting with [] (single [) returns an object of the same type.
+ [[ ]] gives a single element.

[[ ]] mostly used for lists, but works for vectors.


We start with a vector, i.e., an ordered collection of values/elements.

The most "obvious" way to subset is to specify the positions/indices of the elements you want.



## Subsetting By Index/Position
```r
x[ c(1, 3, 6) ]
```

```r
i = match(a, b)
x[ i ] 
```

### Subsetting position 0
For any position that is 0 in our set of indices, R ignores that.
So 
```r
x[ c(1, 0, 5) ]
```
will return a vector of length 2 containing (a copy of) the 1st and 5th element of x.

This is useful, especially in conjunction with match().
When we call match(a, b), we find the position of the first element in b for each of the elements in
a.
If an element of a is not in b, match() gives an NA for the position of this element of a.
However, the third parameter of match() allows us to specify an alternative value for this
situation.
We often use 0 for this so that when we use the result from match() to subset a vector,
we ignore the values that were not found.
In other words,
```r
x[  match(a, b, 0) ]
```


### Subsetting By Empty Position Vector
What about 


### Subsetting with index value 0
R treats 0 as an index value by just ignoring that  element of the request.
```r
x = 1:10
x[c(1, 0, 2)]
[1] 1 2
```
This can be used with match()
```r
  i = match(ids, tt, 0)
  tt[i]
``




### Subsetting by Negative Index



### Subsetting Non-elements

What if we subset an element of a vector that is beyond the length?
```
x = c(1, 5, 10)
x[5]
NA
```



```r
l = list(1, 2, 3)
l[[5]]  
error - subscript out of bounds.
```
Error.

But
```r
l[["abc"]]
NULL
```




## Factors 
### Dropping Levels in Subsets

Consider the following factor:
```r
x  = factor(rep(letters[1:3], rpois(3, 10)))
table(x)
x
 a  b  c 
 9 16 14 
```
These are ordered, by design.
Let's take the first 5 elements
```r
x[1:5]
[1] a a a a a
Levels: a b c
```

What if we don't want the other two levels b and c?
We can convert the subset/result to a factor (which will implicitly convert it to character vector)
```r
factor(x[1:5])
[1] a a a a a
Levels: a
```
Alternatively, we can use drop = TRUE within the [ ] operation:
```r
15> x[1:5, drop = TRUE]
[1] a a a a a
Levels: a
```

The drop parameter is also useful for data.frames, matrices and arrays when we get to two and higher
dimensional subsetting.




### Subsetting By a Factor

A factor is an integer vector with an associated set of levels.
The integer values are indices into the set of levels.
So if x is a factor,
```r
levels(x)[x]
```
prints the factor.

This may not seem important, but it illustrates something important.
We can subset using a factor as the indices/positions.

Suppose we have a set of colors, one for each level of the factor.
Then
```r
colors[ x ]
```
would give a vector of colors corresponding to the actual values of x.
So 
```r
plot(x, y, col = colors[ x ], pch = c(".", "+", "O")[ x ])
```
will use the colors and plotting character corresponding to the values of x.


We could do the same with
```r
names(colors) = levels(x)
colors[ as.character( x ) ]
```
but that is not as convenient.




## Lists

There are three operators for subsetting a list - [], [[ ]] and l$var
+ [ ] is for getting back a sub-list.
+ [[ ]] is for extracting a single element out of the list
+ $ is for extracting a single element out of the list.


The $ operator takes the name on the right hand side of the $ as a literal name.
So l$var  looks for an element named  var.  It does **NOT** look for the variable named var and
then use its value as the name of the element.
So
```r
l = list(abc = 1, def = 2)
var = "abc"
l$var
```
gives back NULL, not 1.
In short, x$var  does not evaluate var.
But 
```r
l$abc
l$ab
l$a
```
would work.
The $ does partial name matching.

You cannot use a number after the $. That is a syntax error.
(Check it with the parse() function.)


The l[[ expr ]] does evaluate the expression within the [[ ]].
So in our example above,
```r
l[[ var ]] 
```
would return 1, the value of the element named "a" since var is a character vector.

But note that that [[ ]] does not do partial name matching!
So 
```r
l[[ "ab" ]]
```
yields NULL.


Also note that 
```r
l[[ c("abc", "def") ]]
```
gives an error.
Why?  because [[ ]] treats an index with length more than 1 as a hierarchical path through the list.
So suppose we had a list
```r
l = list(abc = mtcars, def = data.frame(a = 1, b = 2))
```
Then
```r
l [[ c("abc", "mpg") ]]
```
is the same as
```r
l[[ "abc" ]] [[ "mpg" ]]
```
This can be a real problem in a computation such as
```r
x = someComputation()
i = match(x, y)
l[[ i ]]
```
where we expect x to have length 1 but it has more than one element.
Then match(x, y) gives a value with length more than 1 and so l[[ i ]]
tries to treat the list hierarchically.
So be careful.
