# Warnings

First rule about warnings - they are almost always errors.

There are only 2 warnings that *might* **NOT** be errors.
+ `Incomplete final line found on`
+ `closing unused connection`


The first means that the last line of a file did not have a new line
at the end and maybe the content of that last line was truncated.
Check the result. 

The second means that somebody forgot to close a connection.  While it is a lot better (and on
occassion crucial) to close connections (e.g. using on.exit()), this is not an error and R will
close the connection retroactively.




# Handling Errors

Some functions raise errors while others return a value that indicates an error.
Both approaches are useful.  But you probably have to deal with both.
We often loop over a collection of things, e.g., files, URLs, vectors, data frames
and and want to continue on with other elements even if one or more fails.
To do this, we can use the try() function, e.g.
```r
ans = lapply(docs, function(x) try(getDocTitle(x)))
```

After this, we can find which ones failed by querying if
an element inherits from the try-error class.
We do this with
```r
w = sapply(ans, is, 'try-error')
```


## More Discriminating Error Handling

We often want to catch any type of error, but sometimes we want to deal
with different types of errors in different ways.
For example, if we might have an error due to a file not existing
but we may want to check if a capitalized version exists.
Or we may want to handle an error from requesting a Web site
by visiting an alternative URL.
To do this, we need the error to identify the type of error
via its class.
If this happens (rather than being just a generic error),
we can use the tryCatch() function to specify errors
for one or more classes of errors.


# Warnings as Errors
Sometimes it is convenient to raise warnings to actual errors.
This is useful when debugging and you want to stop when the warning
occurs.  One could trace() or debug() the 

```r
options(warn = 2)
```
