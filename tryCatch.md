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


# Reasons for Errors

When we evaluate a command in R, we might get an error.
There are so many possible causes for such errors, including common ones such as
+ a programming error with the wrong variable name, 
+ the wrong variable that is the wrong type for a call, 
+ the dimension of a matrix is incorrect,
+ not having loaded a package,
+ the package failing to load eventhough it is installed,
+ not finding a file because the path is incorrect or it doesn't exist
+ no internet connection,
+ a Web server is down and the URL request fails.


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


Unfortunately, not enough functions raise errors with specific classes describing
the errors. (You should make functions in the packages you write raise errors with 
informative classes.) <!-- SHOW HOW -->
The RCurl  package is one that does, so we'll use it as an example
```r
library(RCurl)
```

We'll deliberately request a bad URL and get an error

```r
u = getURLContent("http://www.nytime.org")
```
Instead, we'll catch the error with try()
```r
u = try(getURLContent("http://www.nytime.org"))
```
We can find the attributes of the error object
```r
attributes(u)
$class
[1] "try-error"

$condition
<COULDNT_RESOLVE_HOST in function (type, msg, asError = TRUE) {    if (!is.character(type)) {        i = match(type, CURLcodeValues)        typeName = if (is.na(i))             character()        else names(CURLcodeValues)[i]    }    typeName = gsub("^CURLE_", "", typeName)    fun = (if (asError)         stop    else warning)    fun(structure(list(message = msg, call = sys.call()), class = c(typeName,         "GenericCurlError", if (asError) "error" else "warning",         "condition")))}(6L, "Couldn't resolve host 'www.nytime.org'", TRUE): Couldn't resolve host 'www.nytime.org'>
```
Within the error is a condition and that has a lot more information.
To deal with this better, we will use tryCatch().

tryCatch() allows us to specify an R expression to evaluate and
then a collection of error and warning handler functions.
We specify these hander functions by the name of the class corresponding to 
the type of error to which we want the function to be called in response.
In our case, we had an error with an S3 class  vector with 4 elements:
```r
class(attr(u, "condition"))
[1] "COULDNT_RESOLVE_HOST" "GenericCurlError"    
[3] "error"                "condition"           
```
So we want to handle a COULDNT_RESOLVE_HOST error by perhaps 
going to a different Web site.
We may also want to handle a GenericCurlError differently from
a regular R error by indicating this was a failure in a URL request.
We can do both of these with
```r
u = tryCatch(getURLContent("http://www.nytime.org"),
             COULDNT_RESOLVE_HOST = function(e, ...)
			                           getURLContent("http://www.nytimes.com", followlocation = TRUE),
             GenericCurlError = function(e, ...)
			                      cat("Error in RCurl: ", e$message, "\n"))

```


# Warnings as Errors
Sometimes it is convenient to raise warnings to actual errors.
This is useful when debugging and you want to stop when the warning
occurs.  One could trace() or debug() the 

```r
options(warn = 2)
```


