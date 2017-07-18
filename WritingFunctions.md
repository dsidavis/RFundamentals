ADD: ...
force() Lazy evaluation

# Writing Functions

More than the syntax, one wants to understand the ideas, *concepts* and **process** of writing functions.

We can create an R function very easily with
```
function()
  4
```
We have not assigned the function to a name - a variable.
So when we define it, it disappears.
But these anonymous functions are convenient, e.g., in
calls to lapply():
```r
lapply(docTexts, function(x) grep("foo", x))
```


But we can assign functions to variables:
```
f = function()
          4
```
does assign the function to a variable. 
We can assign any object in R to a variable,
just like we discussed defining variables [before](Variables.html).
There is nothing special about a function.



## Parameters

`function` is a keyword in R.  The () immediately following provides
the parameter names and their default values, if provided.
The body of the function can be any R expression -
a literal value, a call, or commonly a collection of expressions within
a { }.

As we have discussed in how functions are called, a function starts its work after R has create the
call frame and matched the arguments to the parameters.  It then evaluates each expression in the
body in sequence. So when writing functions, we don't really have to think about
how the arguments in a call to that function get there; we just work with them in the call frame.



## Default Values 

Some very convenient features of R functions include
+ we can give any parameter a default value so that the user does not have to specify it,
+ these default values  do not have to be literals but can be complex R expressions
+ the expressions for default values can reference other parameters, even if we end up using their
  default values also,
+ we can specify arguments for any of the parameters and omit the rest without having to worry about
  the order of the parameters,etc.

Indeed, a parameter does not even have to have a default value and we still do not have to provide a
value for it.


The following is an idiom I use frequently.
We'll make this concrete. I want to process a collection
of XML files. It is not important for our purposes, but we'll extract the number of <page> elements
each contains.
The XML files are in a directory named XML.
Our function will parse each file into a list, then compute the number of pages in each.
We might define this as
```r
getNumPages = 
function()
{
  ff = list.files("XML", full.names = TRUE, pattern = "xml$")
  docs = lapply(ff, xmlParse)
  sapply(docs, function(x) length(getNodeSet(x, "//page")))
}
```
This does the job.

How can we improve it? or what are its weaknesses?
+ The directory is hard-coded! ("XML")
+ The pattern for the names of the XML files is hardcoded ("xml$"), wherease we may want to process
  e.g., Rdb files, etc.
+ We should put the names of the files on both docs and the answer. Putting it on docs will put it
  on the answer.
  
Let's fix these first, although there are other issues we may want to addres.
One "obvious" approach is to make the directory/path and the pattern parameters with default values:
```r
getNumPages = 
function(dir = "XML", pattern = "xml$")
{
  ff = list.files(dir, full.names = TRUE, pattern = pattern)
  docs = lapply(ff, xmlParse)
  sapply(docs, function(x) length(getNodeSet(x, "//page")))
}
```
This is essentially the same code as before, but more flexible. 
If we call `getNumPages()`, i.e. with no arguments, we get the same result.
However, the caller can work on a different directory and also specify a different pattern for the extension

We might go one step further here and allow the caller to specify other 
arguments that are passed on to list.files, e.g. recursive, ignore.case. 
```r
getNumPages = 
function(dir = "XML", pattern = "xml$", ...)
{
  ff = list.files(dir, full.names = TRUE, pattern = pattern, ...)
  docs = lapply(ff, xmlParse)
  sapply(docs, function(x) length(getNodeSet(x, "//page")))
}
```

However, consider the following change
```r
getNumPages = 
function(dir = "XML", pattern = "xml$",  
         ff = list.files(dir, full.names = TRUE, pattern = pattern, ...), 
		 ...)
{
  docs = lapply(ff, xmlParse)
  sapply(docs, function(x) length(getNodeSet(x, "//page")))
}
```
We have lifted the first expression in the body of the function into the parameters.
So this creates a new parameter named ff (probably a bad name now that it is seen by the callers)
and the default value is just the original computation.

Why does this help?  Well, the caller doesn't have to specify it but can still control
the call to list.files().  However, if the caller does want to work on a smaller
set of files (e.g., when developing and debugging the code), she has control over which files
are processed.
```r
files = list.files('XML', pattern = "xml$", full.names = TRUE)
getNumPages(ff = sample(files, 20))
```


A similar "inconvenice" is that we may have already parsed all the documents.
This won't always be the case, but it probably will be when we are developing the function.
So it would be convenient to be able to avoid reparsing them each time and be able to pass the
list() of parsed documents. In fact, we can skip list.files() and just pass the documents.
So again, we lift the first expression in the body of the function into the parameter definitions,
giving a new parameter named docs with a default value:
```r
getNumPages = 
function(dir = "XML", pattern = "xml$",  
         ff = list.files(dir, full.names = TRUE, pattern = pattern, ...), 
         docs = lapply(ff, xmlParse)
		 ...)
{
  sapply(docs, function(x) length(getNodeSet(x, "//page")))
}
```
So if we have done
```r
xdocs = lapply(files, xmlParse)
```
earlier, we can then pass these direcly
```r
getNumPages(docs = xdocs)
```
and skip the repeated calls to list.files() and xmlParse().


All of these make the function more flexible, albeit slightly less clear, but only just.




The default value of a parameter can even refer to a local variable defined within
the body of the function. All that is necessary is that the parameter is not referenced
before that local variable is created. For example,
```r
f = 
function(files, y = sum(nonempty))
{
   ll = lapply(files, readLines)
   nlines = sapply(ll, length)
   nonempty = nlines > 0
   
   ....
}
```
This works because the default value is evaluated within the call frame when it is needed.
So it sees the parameters and the local variables that exist at the time it is evaluated.

There is no doubt that such use makes the code somewhat unclear to callers since they
don't know what this variable is or how it is defined.
But they can look at the body of the function.  But if the local variable is defined
within an if() statement, things can be unclear.


## Complex Default Values

The default value can be any R expression.
This means it can include if() and if()-else statements
each with complicated bodies.  
Don't take this too far. 
Instead of complex code in the default values,
make the code a  function that returns the correct value.
You'll have to pass the relevant parameters to the function.


### Circular Definitions in Parameter Default Values

Consider
```r
circular = 
function(x = length(y), y = length(x))
{
   x
}
```

So what if we call this function with no arguments
```r
circular()
Error in circular() : 
  promise already under evaluation: recursive default argument reference or earlier problems?
```
The default value of x refers to y and the default value of y refers to x.

However,
```r
f = 
function(x = length(y), y = length(z), z = length(w), w = NULL)
{
   x
}
```
yields
```r
f()
[1] 1
```



## Return Value
A function returns control to the caller, i.e. complete the call to this function,
by explicitly calling return() with a value (or not),
or when the last expression in the body is evaluated.
The return value is the value in the return() call that is evaluated
or the value of the last expression evaluated in the function.

This means that in functions that have a simple sequence of commands, we don't 
need an explicit return call.
```r
function(x, y)
{
    z = x - y
	sqrt(sum(z * z))
}
```

Consider the following function: 
```r
getTextByCols =
function(p, threshold = .1, asNodes = FALSE)
{
    if(length(p) == 0)
       return(character())
    
    txtNodes = getNodeSet(p, ".//text")
    bb = getBBox2(txtNodes)
    bb = as.data.frame(bb)
    bb$text = sapply(txtNodes, xmlValue)

    tt = table(bb$left)
      # Subtract 2 so that we start slightly to the left of the second column 
	  # to include those starting points
      # or change cut to be include.lowest = TRUE
    breaks = as.numeric(names(tt [ tt > nrow(bb)*threshold])) - 2

    if(asNodes) 
        split(txtNodes, cut(bb$left, c(0, breaks[-1], Inf)))
    else {
        cols = split(bb, cut(bb$left, c(0, breaks[-1], Inf)))
        cols = sapply(cols, function(x) paste(x$text[ order(x$top) ], collapse = "\n"))
    }
}
```
There is an explicit call to return within an if() statement at the beginning of the body
of the function.

After this, the function proceeds sequentially until the final expression - an if()-else
command.
This is evaluated and its value returned (implicitly).

What is the value of an if() statement?
It is the value of the last expression evaluated in the if()-else statement.
if() evaluates the condition and then evaluates the body for either the TRUE or the FALSE
condition.  In this case, the TRUE condition is 
```r
split(txtNodes, cut(bb$left, c(0, breaks[-1], Inf)))
```

However, for the FALSE condition, the body is the else part
```r
{
   cols = split(bb, cut(bb$left, c(0, breaks[-1], Inf)))
   cols = sapply(cols, function(x) paste(x$text[ order(x$top) ], collapse = "\n"))
}
```
R evaluates the calls within this {} block and returns the value of the last one.
So the value returned is
```r
sapply(cols, function(x) paste(x$text[ order(x$top) ], collapse = "\n"))
```

Note that the final expression in the FALSE/else case is assigned to a local variable
`cols`. This has the effect of making the result invisible, i.e. equivalent to 
```r
invisible(sapply(cols, function(x) paste(x$text[ order(x$top) ], collapse = "\n")))
```
In other words, assigning the return value of a function causes the result not to be printed at
the top-level prompt.

<!--
# Exercise
What is the return value from the following function
and call
```r
```
-->


## Unwanted Lazy Evaluation

Lazy evaluation is very useful. However, there are some times it is not what we want.
Sometimes we want one or more arguments to be evaluated immediately.
This is easy to do - just reference the parameters.
For example, 
```r
f = 
function(x, y)
{
   x
   y
   ....
}
```
Merely referring to a parameter will cause it to be evaluated at that point.

These lines look a little odd to some and somebody may remove them since, ostensibly, they don't do
anything. Using `x = x` is somewhat odd also.
For this reason, the function `force()` can be used, e.g.,
```r
f = 
function(x, y)
{
   force(x)
   force(y)
   ....
}
```
Hopefully people know to leave this code. But again, it does nothing more than just referencing x directly.




## Querying How the Function Was Called.

We alluded to the fact that a function can know how an argument was specified in the call to this
function.  For example, the plot() function "traps" the call for x and y to use as the labels for
the horizontal and vertical axis.  As I hope you understand, there is nothing special about the plot
function.

So how does plot find this information?
It calls substitute(x)  **before** it uses the value of x.
```r
f = 
function(x)
{
   k = substitute(x)
   print(k)
   x+1
}
```
When we call this with `f(rnorm(3, sd = 10))`,
we see
```
rnorm(3, sd = 10)
```
printed and then we get the result we expect.

How does this work?
Because of lazy evaluation and because the substitute() function uses non-standard evaluation (NSE),
substitute() returns the call in the promise for x.

We often see 
```r
 deparse(substitute(x))
```
to get a text version of the call. But deparse() is not part of the magic of getting
the langage obejct/call. It just turns the language object into text.
We can verify this with, e.g.,
```r
deparse( quote(x + y ^ 2) )
```


## The Call Stack
We have discussed the stack of function calls when discussing how a function is invoked
and how it proceeds, calling other functions, which in turn call other functions.
And we also saw  that the stack of calls may seem out of order due to non-standard evaluation,
e.g., the call to mtcar[] after the call to xy.coords in
```r
where 1: `[.data.frame`(mtcars, , c("wt", "mpg"))
where 2: mtcars[, c("wt", "mpg")]
where 3: xy.coords(x, y, xlabel, ylabel)
where 4: scatter.smooth(mtcars[, c("wt", "mpg")])
```
(Aside: We got here with debug(xy.coords) and then debug(`[`))



We can actually get a list of all the active calls via sys.calls()
```r
sys.calls()
[[1]]
scatter.smooth(mtcars[, c("wt", "mpg")])

[[2]]
xy.coords(x, y, xlabel, ylabel)

[[3]]
mtcars[, c("wt", "mpg")]

[[4]]
`[.data.frame`(mtcars, , c("wt", "mpg"))
```
Each of these is a call, in this case.

We can deparse() any of these, we can manipulate them in other ways.

Parallel to the calls is the call frames which is accessible via sys.frames().
These are in the same order as sys.calls().
Note however that the call stack in the debugger above (obtained via the command where)
is upside-down relative to these! Confusing and one of the reasons I prefer the recover() function.


See the help page for ?sys.parent to see what else we can explore on the call stack.




# Warnings and Errors

Your functions should verify the type and contents of the arguments
and also any intermediate values that may cause problems.
When you find a problem, you should raise either a warning
or an error.
The two basic functions for these are 
warning() and stop().
Both can be called with just an error message.
Make the error message as informative as possible. Remember 
how you responded when reading cryptic error messages.
R will tell the caller (which could be you) where the error took place.
But you can provide much more contextual information about what
was expected, what differed from this and possible explanations and 
common causes.


## Classes on Errors and Warnings

While the warning and error messages are very useful,
they are not easy to programmatically use.
For one, they may be translated to a different language.
Secondly, they are free form text and we have to make sense of that.

The R "condition" mechanism - warnings and errors - allows us
to create warnings and errors that have classes.
Specifically, we can set a class vector on the warning or error.
Importantly, callers can then identify these types/classes of errors
and react differently to different classes.
This is done best via [tryCatch()](tryCatch.html).
Adding classes to your errors and warnings is really a good thing to do.



