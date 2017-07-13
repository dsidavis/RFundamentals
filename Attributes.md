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
in other words, how it is constructred.

The function str() is also useful for seeing the structure of an object and an overview of its
contents.

head() and tail() show us the top and bottom of a vector, data.frame, matrix, etc.
These are also good for taking a quick look at an object to verify it is as expected.

Many objects have names.
The name 



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

