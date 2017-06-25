# Hierarchies of Vector Types in R

There are 4 fundamental vector types that people encounter most often.
These are, in order
 + logical - `TRUE`, `FALSE`
 + integer - 1L, 2L, as.integer(4)
 + numeric - 1, 1.0, 2.3443242e4, pi
 + character - "1", "1.0", "abc"
 
Why are these ordered?  Basically, information from one can be converted without loss of information
from the previous level to the next level.  We can convert a logical value of `TRUE` to an integer
value of 1 and `FALSE` to an integer 0.  Similary, for example, we can convert an integer from 1L to
1.0, a numeric.
So a  
+ logical maps to an integer
+ integer maps to a numeric
+ a numeric maps to a character

Importantly, we can convert each of these back to "lower" types.
```r
as.logical(2)
[1] TRUE
```
```r
as.integer("2")
[1] 2
```


After these 4 fundamental types, we have the factor type.
This is built on top of an integer
