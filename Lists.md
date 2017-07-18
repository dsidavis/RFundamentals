# List

A list is an ordered collection of elements, just like each of the vector types.
However, very importantly and differently,  the elements of a list can have different types.
Within a list, we can have a numeric vector of length 2, an integer vector with 0 elements,
a function, a data.frame, another list containing arbitrary elements, and so on.

The elements in a list do not have to have the same length.
In a data.frame, which is a list, we ensure that the elements do have the same length
so that the i-th row corresponds to the i-th observation across all.


When creating lists, we use the list() function, e.g.m
```r
ll = list(x = 1, y = 1:10, z = mtcars, a = lm(mpg ~ ., mtcars))
```

[See here](ListAndC.html) for serious issues using c() instead of list().


## Subsetting Lists

[See](Subsetting.html)

The key thing is to understand using [ on a list will return a list.
So if you want an element from the list, and not a list containing that one element,
you need to use  `ll[[ index ]]` and not `l[index]`.

Consider
```r
ll = list(1, 2)
a = ll[1]
b = a[1]
a
b
identical(a, b) # TRUE
identical(b, b[1]) # TRUE
```
So we are not making progress.

But 
```r
ll[[1]]
[1] 1
```
is what we want.

### [[ multiple element vector]]
Be careful of subsetting a list with [[ ]] and a vector that has multiple elements.

Firstly,
```r
ll [[ c(TRUE, FALSE) ]]
```
gives an error
```
Error in ll[[c(TRUE, FALSE)]] : 
  attempt to select less than one element in integerOneIndex
No suitable frames for recover()
```

Instead, use
```r
ll[[ which( c(TRUE, FALSE)) ]]
```

But
```r
ll [[ c(1, 2) ]]
```
is quite different.
This is equivalent  to
```r
ll[[1]][[2]]
```
So this only works if the first element we get has 2 elements, and it doesn't.

But
```r
ll = list(1:10, letters)
ll[[2]][[3]]
```
gives "c".


### $ operator
The $ operator 
+ uses partial matching of names, while ll[[ "ab" ]] doesn't.
+ treats var in `ll$var` as a literal value "var", and does not evaluate var to get its value.
  e.g. ```r
        i = "abc"
	    ll$i
    ```
	 looks for the element that starts with i, not abc.
  


## Pre-allocating


Often we want pre-allocate a list and then fill in its value in subsequent computations.
We can do this for an logical, integer, numeric, character with, e.g.,
```r
x = numeric(10)
```
But the call 
```r
x = list(10)
```
creates a list with one element - the value 10.
So how do we create a list with 10 elements. There are several imaginative ways, but the best is
```r
x = vector("list", 10)
```


One possible issue you may run into with both  lists and vectors 
is preallocating the the vector and then adding elements to it by name.
Consider
```r
x = vector("list", 10)
for(i in 1:10) 
 x[[ letters[i] ]] = i
```
What will x contain at the end of this?
