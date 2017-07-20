#

Data analysis involves a lot of comparing groups. 
We regularly split our sample into subgroups and
see if they are qualitatively similar or different.
We split the sample into subgroups and then
compute statistics on each group or plot them.

We split based on one or mor factors. We get a subgroup
for each combination of the different levels of each factor.
We can split on numeric variables by first binning them into a
factor using, e.g., cut().


In R, we can use split() to create the subgroups.
Then we can revisit the subgroups using lapply().
For example, 
```r
grps = with(mtcars, split(mpg, cyl) )
```
We can find the number of groups with length(grps).
This corresponds to the number of unique values in mtcars$cyl.
The names of grps are the unique values of mtcars$cyl - 4, 6, 8 -
and R orders them (alphabetically).

We can now compute statistics on these groups, e.g.
```r
sapply(grps, length)
```
to compute the number in each group. This is the same as
```r
table(grps$cyl)
```

We can compute other statistics
```r
sapply(grps, summary)
            4     6     8
Min.    21.40 17.80 10.40
1st Qu. 22.80 18.65 14.40
Median  26.00 19.70 15.20
Mean    26.66 19.74 15.10
3rd Qu. 30.40 21.00 16.25
Max.    33.90 21.40 19.20
sapply(grps, min, na.rm = TRUE)
   4    6    8 
21.4 17.8 10.4 
```

We can pass the result of split() directly to boxplot, e.g.,
```r
boxplot(grps)
```

The split-apply idiom is so common that R provides a single
function to do this, and in fact 3 very related functions.
These are tapply(), by() and aggregate.

These 3 functions are analogous to SQL's GROUP BY operation.

Let's do what we did above with tapply():
```r
with(mtcars, tapply(mpg, cyl, summary))
$`4`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  21.40   22.80   26.00   26.66   30.40   33.90 

$`6`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  17.80   18.65   19.70   19.74   21.00   21.40 

$`8`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  10.40   14.40   15.20   15.10   16.25   19.20 
```
Note that tapply did not simplify the result as sapply() did above.
This is because tapply() requires that all the results have length 1 before it will
attempt to simplify. 
Computing a single value, e.g.,
```r
with(mtcars, tapply(mpg, cyl, median))
```
tapply(), does simplify the result
In other cases, we could call simplify2Array() ourselves.



Instead of splitting/grouping by a single categorical variable,
let's use two - cyl and am (for automatic transmission or not).
(Note while these are not categorical, they are integer valued i.e. discrete
and to the automatic transmission should be considered categorical.)

```r
g = with(mtcars, split(mtcars, list(cyl, am)))
```
Note that we are splitting the entire data frame, not just the vector mpg.
This means that we are grouping the observations based on the unique combinations
of both cyl and am
```r
names(g)
[1] "4.0" "6.0" "8.0" "4.1" "6.1" "8.1"
```
The 0 and 1 after the . correspond to am = 0 or 1.
TRUE or FALSE would be better
```r
g = with(mtcars, split(mtcars, list(cyl, as.logical(am))))
names(g)
[1] "4.FALSE" "6.FALSE" "8.FALSE" "4.TRUE"  "6.TRUE"  "8.TRUE" 
```
Again, we can use lapply/sapply() to process each group.

Can we use tapply() on a data.frame?
Let's do a regression of mpg on wt for each of these subgroups
```r
with(mtcars, tapply(mtcars, list(cyl, as.logical(am)), function(x) lm(mpg ~ wt, x)))
```
No, we get an error about "arguments must have same length".
This means we should use the by() function!

```r
f = with(mtcars, by(mtcars, list(cyl, as.logical(am)), function(x) lm(mpg ~ wt, x)))
: 4
: FALSE

Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
     13.896        3.068  

---------------------------------------------------- 
: 6
: FALSE

Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
      63.65       -13.14  

---------------------------------------------------- 
: 8
: FALSE

Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
     25.059       -2.439  

---------------------------------------------------- 
: 4
: TRUE

Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
     44.194       -7.893  

---------------------------------------------------- 
: 6
: TRUE

Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
    22.2021      -0.5936  

---------------------------------------------------- 
: 8
: TRUE

Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
      22.14        -2.00  
```

Notice that names(f) is NULL, unlike tapply().
Instead, it has attributes which provides the dimenions
and their names:
```r
attributes(f)
$dim
[1] 3 2

$dimnames
$dimnames[[1]]
[1] "4" "6" "8"

$dimnames[[2]]
[1] "FALSE" "TRUE" 


$call
by.data.frame(data = mtcars, INDICES = list(cyl, as.logical(am)), 
    FUN = function(x) lm(mpg ~ wt, x))

$class
[1] "by"
```

The print() method for by objects uses these to display the result
and add the names.

Note that a by object is also subsettable, as are all R objects,  and in this case with 2
splitting vectors (cyl and as.logical(am)), it is a 2-dimensional data structure.
So, we can access elements by position and name in each dimension, e.g.,
```r
f[[1, 2]]
Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
     44.194       -7.893  
	 
f[["4", "TRUE"]]

Call:
lm(formula = mpg ~ wt, data = x)

Coefficients:
(Intercept)           wt  
     44.194       -7.893  
```



<!--
The aggregate() function is a more enhanced, flexible 
version of by().
It uses S3 methods and deals with time series as well as data frames, 
it simplifies results, allows us to subset
the original data frame within the call, 
allows us to deal with NAs,
drop unused/unobserved levels or combinations of levels.
-->

