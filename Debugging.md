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


# Post-mortem Debugging

## Batch Debugging
