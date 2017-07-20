# Debugging in R

+ print()/cat()/message()
+ browser()/recover()
+ debug()
+ trace()
+ traceback()
+ options()  error = recover/browser/dump.frames

# Proactive Debugging
Stop in a given function before it starts doing its work.


# Reactive Debugging
When an error occurs, we want to stop and look around at
the current state of the computations.
This includes not only the line where the error occurred
and the variables used in that expression, but
also the state of other function calls that led to this error.
While the error clearly occurs in function y, the problem
may have been caused by function x calling y with a bad/unexpected argument
which was computed in x erroneously.

We arrange to stop when there is an error
```r
options(error = recover)
```

An alternative is to call `traceback()`
immediately after an error occurred (i.e. before we issue another R command at the REPL).


# Turning warnings into errors

Warnings are harder to catch.
Warnings are typically displayed at the end of a computation, not when they occur.
We can change this with
```r
options(warn = 1)
```

To trap warnings as they occur and stop to examine the call stack,
we might debug the warning() function and see where it is called.
Alternatively, we can elevate **all** warnings to errors with
```r
options(warn = 2)
```

# Post-mortem Debugging
After an error occurs and the next prompt is shown,
you can use traceback() to explore the call stack.
This behaves much like debugging with `options(error = recover)`.
It merely changes the default where now you chose to examine
the call stack, whereas with error = recover, you are always asked
to explore it and have to exit.

## Batch Debugging
We can run R in "batch" mode, i.e., you run R not interactively
but as a background/asynchronous job/process.
This is useful for very long running tasks
what happens when there is an error.




#

```r
tmp = mtcars[-31,]
by(tmp, list(tmp$cyl, tmp$am), function(x) lm(mpg ~ wt, x)))
by(tmp, list(tmp$cyl, tmp$am), lm, formula = mpg ~ wt)
```

```r
debug(lm)
by(tmp, list(tmp$cyl, tmp$am), lm, formula = mpg ~ wt)
```


```r
trace(lm, quote(print(data)), print = FALSE)
by(tmp, list(tmp$cyl, tmp$am), lm, formula = mpg ~ wt)
```


The following gives an error:
```r
by(tmp, list(tmp$cyl, tmp$am), lm, formula = mpg ~ et)
```



## 

```r
library(ReadPDF)
getDocTitle("foo")
```


```r
library(ReadPDF)
f = list.files("~/DSIProjects/Zoonotics-shared/LatestDocs/PDF/0000708828/", pattern = "xml$", full = TRUE)
getDocTitleString(f)
```

```r
source("~/DSIProjects/ReadPDF/R/getTitle.R")
```
Note that some of the functions getDocTitle() calls
**may** be in the ReadPDF namespace and unexported. In this case,
our new functions won't find them as we have source()d
these into the global environment.


Let's debug isTitleBad() to see why it thinks this txt is
not a title.
```r
debug(isTitleBad)
```
