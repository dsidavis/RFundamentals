# c() versus list()

A common mistake in programming is to use c() instead of list() to
create a list.

What's the difference between c() and list()
i.e. c(x, y, z) and list(x, y, z)?

Consider the following:
```r
x = 1:10
y = TRUE
z = seq(1.5, length = 20, by = 2)

a = list(x, y, z)
b = c(x, y, z)
```

What's the class of a? and b?
What is the length of each?
```r
class(a)
class(b)
length(b)
```
