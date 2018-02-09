
# Missing Values

A very important aspect of the R language is the concept of a missing value - an NA.
This stands for Not Available.  This occurs often in data analysis and R captures it conceptually
and as a fundamental part of the computational model.
This is different from representing a missing value arbitrarily as -99 or -999 or some other 
value that is unlikely to occur.
Many R functions allow us to deal with NA values in different ways and how we do so is an important
statistical concern/issue.

We can write an NA literal value exactly as NA, e.g.,
```r
c(1, 4, NA, 10)
```


NA values are very different from NaN values.
NaN stands for Not a Number. It arises from mathematical
calculations that don't make sense. For example, log(-10)
gives NaN.


NA values print as 
```r
NA
[1] NA
```
i.e., with no quotes.
Compare this with
```r
"NA"
```
"NA" may be an abbreviation for Nebraska which is very different from a missing value (NA).


NA values in a factor print as `<NA>` so that we can distinguish them from a level with the name NA.
For example,
```r
factor(c("A", "B", NA, "A"))
[1] A    B    <NA> A   
Levels: A B
```
Whereas,
```r
factor(c("CA", "NA", "AK", "AZ"))
[1] CA NA AK AZ
Levels: AK AZ CA NA
```
for state abbreviations!


## NA Logic.

What is  the value of 
```r
1 + NA
```
What is the result of adding one to a number I don't know?  I still don't know.
So the result is NA.

Similarly, sum(), mean(), sd(), cor(), cov(), etc. for a vector values
yields NA.
However, these have an na.rm = TRUE/FALSE argument that allow us to "remove" missing values from the
computations,  i.e. skip them, not actually remove them from the vector(s).
So
```r
mean(c(12, 233, 10, NA), na.rm = TRUE)
```
yields 85 (so dividing by 3)
and the same as
```r
mean( na.omit(c(12, 233, 10, NA)) )
```
The function na.omit() is useful for omiting elements of a vector or rows of a data.frame.

Don't remove rows with missing values.  Instead, omit them from specific computations.
Removing a row because it has an NA value for a variable we don't care about throws away valuable observations.


## Testing if a Value is NA
How can we test if a value is?
An obvious approach is 
```r
x == NA
```
So we take a vector x as, e.g., 
```r
c(1, NA, 4) == NA
```
Is 1 equal to the value we don't know?  I don't know?
So the first element of the answer is NA.

What about 
```r
NA == NA
```
Is the value I don't know equal to the other value I don't know?
How can I know? They are both unknown but can be different. So the result is also NA.

So 
```r
c(1, NA, 4) == NA
[1] NA  NA  NA
```


So how do we tell which values are missing in an vector?
The function is.na() tells us 
```r
is.na( c(1, NA, 4))
[1] FALSE  TRUE FALSE
```


So we can subset only the non-missing values with
```r
x[ is.na( x ) ]
```
or

```r
myDataFrame[ !is.na(myDataFrame$x), ]
```
to exclude  all the rows in which x has an NA value.
