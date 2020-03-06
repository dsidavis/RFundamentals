# Attributes


Every object has a class(), typeof() and a length().
In other words, we can always call the class(), typeof() and length()
functions on any R object and get a result with some meaning.
And I nearly always use these after a command just to make certain that I get what I think I 
am getting - in other words, to verify my expectations.

The class() tells us how we as users should think about this object.
For example, the result of a call to lm() is a linear model and has class `lm`.
The actual object is a list, but we are to think of it as an lm object.

The typeof() function tells us the fundamental type of the object,
in other words, how it is constructed.

The function str() is also useful for seeing the structure of an object and an overview of its
contents.

head() and tail() show us the top and bottom of a vector, data.frame, matrix, etc.
These are also good for taking a quick look at an object to verify it is as expected.

Many objects have names.
The names are very useful when we, e.g., subset the vector as we can still identify the
elements by their names.
For example, consider the two vectors
```r
x = c(history = 100, psychology = 900, statistics = 400)
y = c(100, 900, 400)
```
Now,
```r
x[ x > 200]
psychology statistics 
       900        400 
```
But 
```r
y [ y > 200]
[1] 900 400
```
So we don't know which elements are included in the result, just their values.

And often the same names  are used on parallel vectors, i.e., two vectors whose elements
are in order that correspond to each other and the same observational unit.
So the subset of one tells us which values to extract from the the other.
The logical condition does this also, so the names are not vital.

However, the names are vital if we have two vectors x and y 
and we want to get the elements of y corresponding to the names of x, regardless of the 
order of the two vectors:
```r
y[ names(x) ]
```



## structure()

Often we compute a vector (or list) and then  set the names and possibly specify the class.
In a function, we often see
```r
  ans = computeVector()
  names(ans) = c("a", "b", "c")
  class(ans) = "myData"
  ans
```
So we create a temporary variable, set its names() attribute and then return it.

Or on the command line, we may have to create this temporary variable, set its names, pass it to 
another function and then remove the temporary variable:
```r
tmp = computeVector()
names(tmp) = c("a", "b", "c")
ans = fun(tmp)
rm(tmp)
```

Often it is more convenient to set attributes in a single call that also creates the object.
We use structure(), e.g.
```r
structure(computeVector(),  names = c("a", "b","c"), class = "myData")
```
and now we can return that or put it directly into a call to fun().



