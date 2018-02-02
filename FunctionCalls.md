# How Function Calls Work?

Consider a function call in R.
We'll use getDocTitle() from the ReadPDF package we are developing
as an example. There is nothing special about this.

We'll source() the file  getTitle.R into the R session, so the
functions defined in that file will be in the global environment.


Consider the function
```
getDocTitle =
function(file, page = 1, doc = readPDFXML(file), meta = FALSE, minWords = 1, ...)
{
   # R CODE HERE.....
}
```

Consider the call 
```r
getDocTitle("article.xml", 2,  me = TRUE)
```
R first finds the getDocTitle function by searching in the appropriate places.
It is now ready to actually invoke/call this function

R has the function so it can query informatio about it, i.e. its parameters/formal arguments
and body.

The signature of getDocTitle() is 
```r
function(file, page = 1, doc = xmlParse(file), meta = FALSE, minWords = 1, ...)
```

R creates a call frame.
It creates bindings for each of the parameters:
file, page, doc, meta and minWords and also `...`.
For each of these, it assigns a **promise**
that is either empty if there is no default value
or to the expression for the default value.
So file is assigned an empty promise,
page is assigned the literal value 1,
doc is assigned the expression `xmlParse(file)`,
and meta and minWords get the literal values `FALSE` and 1,
respectively.
The `...` gets an entry also in the call frame.

These default values will only be used if they are needed.

I use the term parameter for a formal argument in the signature of the function,
i.e. the name of an input the author of the function used when writing the body.
An argument is a value passed in a specific call to the function.


Next, R matches the arguments in the call to the parameters in the call frame.
It does this in 3 steps:
1. named arguments whose names exactly match an expected parameter name
2. named arguments whose names partially match an expected parameter name that has not been
  previously matched in step 1
3. all other arguments, i.e. the unnamed ones, are matched by position to the remaining parameters.


Our call to getDocTitle() was
```r
getDocTitle("article.xml", 2,  meta = TRUE)
```

### Step 1
So step 1 matches meta = TRUE in the call  to the parameter meta in the function definition
and assigns `TRUE` (the argument value) to the meta parameter's binding in the call frame.
Technically it doesn't assign the value of the argument, but rather a promise to evaluate
it when it is needed.  This is *lazy evaluation*.

There are no other named arguments in the call, so this ends setp 1.

We have matched  the parameter meta.


### Step 2
There are no other named arguments, so none to partially match by name.


### Step 3
The remaining 2 arguments in the call are "article.xml" and 2.
We match these two the first parameters.


Remember that R has not evaluated the arguments in the call.
It has only associated the expressions in the call with the relevant parameters.
Lazy evaluation defers the evaluation of each argument until the corresponding
parameter is actually referenced.


match.call()






## scatter.smooth()

Consider the scatter.smooth() function.
We will call it as
```r
scatter.smooth(mtcars$mpg, mtcars$wt, fam = "gaussian", xl = "Weight of car", 
               yla = "Miles per Gallon", 
			   lpars = list(lwd = 2, col = "red"),
			   main = "Motor Trends Data")
```
Its signature is 
```r
function (x, y = NULL, span = 2/3, degree = 1, family = c("symmetric", 
    "gaussian"), xlab = NULL, ylab = NULL, ylim = range(y, pred$y, 
    na.rm = TRUE), evaluation = 50, ..., lpars = list()) 
```
So in our call we are not spelling out the full names for family, xlab and ylab.
Also, we are not specifying span or degree (or ylim or evaluation). 

We can use match.call() to see what R will actually match.
```r
match.call(scatter.smooth, 
           quote(scatter.smooth(mtcars$mpg, mtcars$wt, fam = "gaussian", xl = "Weight of car", 
               yla = "Miles per Gallon", 
			   lpars = list(lwd = 2, col = "red"),
			   main = "Motor Trends Data")))
scatter.smooth(x = mtcars$mpg, y = mtcars$wt, family = "gaussian", 
    xlab = "Weight of car", ylab = "Miles per Gallon", main = "Motor Trends Data", 
    lpars = list(lwd = 2, col = "red"))			   
```
> Note the use of quote() to stop R evaluating the command but just to return it as a language object
> (of class call)

R returned the actual call with the argument names for all of the inputs.

In our call, the named arguments are 
fam, xl, yla, lpars, and  main.

### Step 1 - Full name matching
Only the lpars argumet matches a parameter by name. So we assign that to the parameter in the call
frame.


### Step 2 - Partial name matching
Having matched lpars, we have 
fam, xl, yla, and  main as named arguments.
The first three clearly partially match family, xlab and ylab.
Note that yl would have been an ambiguous as it matches ylim and ylab.
So we needed to add the 'a'.

main does not match any parameter name. So this is added to the `...`.

### Step 3 - Unnamed argument matching
We are now left with 2 arguments `mtcars$mpg` and `mtcars$wt`.
We have filled in family, xlab, ylab, lpars.
This leaves, in order, x, y, span, degree, ylim and evaluation.
So these two arguments are mapped to x and y.


## Skipping Parameters
Consider a different call to scatter.smooth():
```r
scatter.smooth(mtcars[, c("mpg", "wt")], , , , "gaussian", "Weight of car", "Miles per Gallon", 
			   lpars = list(lwd = 2, col = "red"),
			   main = "Motor Trends Data")
```

Here there are only 2 named arguments - lpars and main.
The other arguments are specified by position.


The first argument matches x.
Then we explicitly skip y, span and degree by specifying no values for them but have a space in the
call for them identified by the ,.
Then we specify the value for family, xlab, ylab by position.

In this case, we have explicitly specified a **missing** value for the parameters y, span and
degree.  R has already assigned the default value to each so those will be used.

## Exercise
+ What happens in the following call:
```r
scatter.smooth(mtcars$mpg, mtcars$wt, family = "gaussian", x = "Weight of car", y = "Miles per Gallon")
```

<!-- 
o = ls("package:base")
o = ls("package:stats")
i = sapply(o, function(x){ f = get(x, "package:stats"); 
                               if(is.function(f)) { p = names(formals(f)); ("..." %in% p && match("...", p) < length(p))} else FALSE})
-->


## Specifying Named Arguments after `...`
There is one additional important aspect when the function has a `...` parameter.
Any named argument corresponding to a parameter defined after ... must match the parameter name
exactly. Otherwise, it will be in stored in the `...` list.
Consider the function
```r
f =
function(a, ..., xyz = 10)
{

}
```
If we call f() as
```r
f(99, xy = 20)
```
this will leave xyz as 10 and ... will be a list with one named element
named xy and a value of 20.

Let's check this
```
debug(f)
f(99,  xy = 20)
```

At the `Browse[2]> ` prompt, we can issue commands to look at the local variables
```r
ls(all = TRUE)
[1] "..." "a"   "xyz"
```
We see all of the ones we are expecting
What are their values
```
xyz
[1] 10
```
So it did not receive our value 20, as we said.
And it is in `...`:
```r
list(...)
$xy
[1] 20
```


In our call to scatter.smooth, if we had specified lpars as lp or lpa, 
it would have been matched to `...` and not lpars.





##  Evaluation of the Function Body
Once we have matched the arguments to the parameters,
R evaluates the call by evaluating each of the expressions
in the body of the function.
It evaluates each expression within the context of the current
call frame. This means that it looks for variables in the call frame first.
This is like looking in the global environment first for a top-level 
command. 

Consider the call to scatter.smooth() above,
i.e.,
```r
scatter.smooth(mtcars$mpg, mtcars$wt, fam = "gaussian", xl = "Weight of car", 
               yla = "Miles per Gallon", 
			   lpars = list(lwd = 2, col = "red"),
			   main = "Motor Trends Data")
```
After matching the arguments to the parameters, we have the call frame

The full definition of scatter.smooth can be seen by printing it:
```
scatter.smooth
function (x, y = NULL, span = 2/3, degree = 1, family = c("symmetric", 
    "gaussian"), xlab = NULL, ylab = NULL, ylim = range(y, pred$y, 
    na.rm = TRUE), evaluation = 50, ..., lpars = list()) 
{
    xlabel <- if (!missing(x)) 
        deparse(substitute(x))
    ylabel <- if (!missing(y)) 
        deparse(substitute(y))
    xy <- xy.coords(x, y, xlabel, ylabel)
    x <- xy$x
    y <- xy$y
    xlab <- if (is.null(xlab)) 
        xy$xlab
    else xlab
    ylab <- if (is.null(ylab)) 
        xy$ylab
    else ylab
    pred <- loess.smooth(x, y, span, degree, family, evaluation)
    plot(x, y, ylim = ylim, xlab = xlab, ylab = ylab, ...)
    do.call(lines, c(list(pred), lpars))
    invisible()
}
<bytecode: 0x7ff242f2b270>
<environment: namespace:stats>
```r
We'll ignore the first two expressions for now.

Note the
```r
<environment: namespace:stats>
```
at the end of the output. This tells us that the function
lives in the stats package.

R evaluates the call `xy.coords(x, y, xlabel, ylabel)`
in the same way we described in the REPL
but uses a different starting  environment
for finding variables.
R first finds the function xy.coords by searching
in the call frame for this call to scatter.smooth.
xy.coords is not in the call frame.
So it searches the parent environment of the call frame.
This is the environment of the definition of the function scatter.smooth.
This is the namespace:stats that we see in the display of the scatter.smooth function.

xy.coords is not in the stats package (either exported or or not).
In fact, it is in grDevices package. So how does R find it from the 
call frame of scatter.smooth()?
The parent environment of the namespace:stats is an environment named
"imports:stats"
```r
parent.env(getNamespace("stats"))
<environment: 0x7fca18b6f9b8>
attr(,"name")
[1] "imports:stats"
```
We can list all the variables in this with
```r
ls(parent.env(getNamespace("stats")), all = TRUE)
  [1] ".filled.contour"  "abline"           "arrows"          
  [4] "as.graphicsAnnot" "assocplot"        "axis"            
  [7] "Axis"             "axis.Date"        "axis.POSIXct"    
 [10] "axTicks"          "barplot"          "barplot.default" 
 [13] "box"              "boxplot"          "boxplot.default" 
 [16] "boxplot.matrix"   "bxp"              "cdplot"          
 [19] "clip"             "close.screen"     "co.intervals"    
 [22] "contour"          "contour.default"  "coplot"          
 [25] "count.fields"     "curve"            "dev.cur"         
 [28] "dev.flush"        "dev.hold"         "dev.interactive" 
 [31] "dev.new"          "dev.set"          "devAskNewPage"   
 [34] "dotchart"         "erase.screen"     "extendrange"     
 [37] "filled.contour"   "flush.console"    "fourfoldplot"    
 [40] "frame"            "grconvertX"       "grconvertY"      
 [43] "grid"             "hist"             "hist.default"    
 [46] "identify"         "image"            "image.default"   
 [49] "layout"           "layout.show"      "lcm"             
 [52] "legend"           "lines"            "lines.default"   
 [55] "locator"          "matlines"         "matplot"         
 [58] "matpoints"        "mosaicplot"       "mtext"           
 [61] "n2mfrow"          "pairs"            "pairs.default"   
 [64] "palette"          "panel.smooth"     "par"             
 [67] "persp"            "pie"              "plot"            
 [70] "plot.default"     "plot.design"      "plot.function"   
 [73] "plot.new"         "plot.window"      "plot.xy"         
 [76] "points"           "points.default"   "polygon"         
 [79] "polypath"         "rasterImage"      "rect"            
 [82] "rug"              "screen"           "segments"        
 [85] "smoothScatter"    "spineplot"        "split.screen"    
 [88] "stars"            "stem"             "str"             
 [91] "strheight"        "stripchart"       "strwidth"        
 [94] "sunflowerplot"    "symbols"          "tail"            
 [97] "text"             "text.default"     "title"           
[100] "xinch"            "xspline"          "xy.coords"       
[103] "xyinch"           "yinch"           
```
We see xy.coords is there as an imported variable.
We can also directly query whether that environment has a variable named xy.coords with
```r
exists("xy.coords", parent.env(e))
```
or better, look for a function,
```r
exists("xy.coords", parent.env(e), mode = "function")
```
So R will find xy.coords() by searching the call frame of scatter.smooth, its parent environment,
its parent and will then find it.


Let's explore the computations and environments.
```r
debug(scatter.smooth)
scatter.smooth(mtcars$mpg, mtcars$wt, fam = "gaussian", xl = "Weight of car", 
               yla = "Miles per Gallon", 
			   lpars = list(lwd = 2, col = "red"),
			   main = "Motor Trends Data")
```


```r
sys.frames()
[[1]]
<environment: 0x7ff24861cb40>

Browse[2]> sys.frames()[[1]]
<environment: 0x7ff24861cb40>
Browse[2]> ls(sys.frames()[[1]], all = TRUE)
 [1] "..."        "degree"     "evaluation" "family"     "lpars"     
 [6] "span"       "x"          "xlab"       "xlabel"     "y"         
[11] "ylab"       "ylabel"     "ylim"      
```

What is the parent environment of this call frame
```r
parent.env(sys.frames()[[1]])
<environment: namespace:stats>
```
Yes, the statistics package's environment that is also on the search path.
This is because the xy.coords() function is in the stats package
as we saw when we printed it and the environment was displayed at the bottom of the output.
This allows xy.coords to see other functions and variables in the stats package.
We won't look along the search path as we did when we defined our function in
the global environment.
But note that the computational model is still the same.
We look in the call frame, then its parent environment, then its parent's parent environment and so
on.
In this case, the parent environment of the call frame is a package's environment.
<!-- In our function ???, the parent environment is the global environment. -->

So R finds xy.coords in the stats package via the parent environment of the call frame.  It then
creates the call frame and matches the arguments to the paremeters.  The arguments are x, y,
xlabel and ylabel.  It finds all of these in the current call frame.  So it assigns a promise to each
of the corresponding parameters in the new call frame for xy.coords() to evaluate each of these
expressions.  This means that they will be evaluated when they are needed within xy.coords().  R
will evaluate these promises within the call frame to this call to scatter.smooth(), not within the
xy.coords call frame.

If we follow all of environment parents, we see the ancestors of the scatter.smooth() call frame
are
```r
<environment: namespace:stats>
<environment: 0x7ff2458acbb8>
attr(,"name")
[1] "imports:stats"
<environment: namespace:base>
<environment: R_GlobalEnv>
```
and then all the subsequent elements on the search path.
The second of these is an additional environment for the stats package
and is the one that contains the non-exported variables and also the variables
that stats imported from any other package, in this case the graphics package
and some variables from grDevices and utils.



<h2 id="LazyEval"><a name="LazyEval">Lazy Evaluation</a></h2>

## Lazy Evaluation for Default Value of Parameters
When we call a function and R matches the arguments to the parameters,
it does not evaluate the code that gives the values for those arguments.
Instead, it defers computing these until the parameter value is actually used
in the function.
Consider the function
```r
avg = 
function(x, n = length(x))
{
   x = x[!is.na(x)]
   sum(x)/n
}
```
We call this with 
```r
x = rnorm(10)
x[ c(2, 9) ] = NA
avg(x)
```

This removes any missing values from x.
Then it evaluates the sum of the vector.
Since we did not specify a value for n,
we use the default value to compute n,
but only now when it is needed.
So the call length(x) will use the current value of x,
i.e., with the missing values removed.
So the value will be what we want.


Another example of this is 
```r
function(doc, nodes = getNodeSet(doc, "//text"))
{
	if(is.character(doc))
		doc = xmlParse()
		
	sapply(nodes, xmlValue)
}
```

## Lazy Evaluation for Arguments
This is lazy evaluation of the default values of parameters.
Consider lazy evaluation of the argument values



```r
revert =
function(m, b)
{
   if(nrow(m) != ncol(m))
     return(numeric(nrow(m)))
	 
   solve(m)%*% b
}
```

We can call this with 
```r
rot = matrix(c(cos(pi/4), sin(pi/4), -sin(pi/4), cos(pi/4)), 2, 2, byrow = TRUE)
revert(rot, rnorm(2))
```

We'll trace() the calls to rnorm() to see when they are called.
In the call
```r
revert(rot, rnorm(2))
trace: rnorm(2)
           [,1]
[1,]  1.8858897
[2,] -0.2371549
```
we see rnorm() is called.

Now, we call it with a non-square matrix. 
So the function doesn't use the second argument.
```r
revert(rbind(rot, c(10, 5)), rnorm(3))
[1] 0 0 0
```
There is no call to rnorm() which means the code for the second argument is never evaluated.
This is lazy evaluation.



## Assignment and Lazy Evaluation - a Warning.

One very curious example of the perils of lazy evaluation
is 
```r
f =
function(a, b)
{

	if(a < 0)
	  return(FALSE)
	  
    a + b
}
```
and the call
```r
f(-10, sum( x <- rnorm(100)))
```
What is the value of the variable x in the global environment?

And for 
```r
f(10, sum( x <- rnorm(100)))
```






## Code when the Function Returns
There are times we want to ensure code is run just before we
return from a function.
For example, we may want to reset global graphics parameters that we 
set via par(), or arrange to close a connection that we opened within the function.
We can do this before the call to return (i.e. the last expression of the function).
However, there may be multiple places where the function might call return(),
e.g. in different if()-else blocks.
So this gets messy. We don't want to repeat the clean up code.

Furthermore, what if there is an error or the user interrupts the computation
and the R function doesn't get to the cleanup  code.

We can deal with this using the on.exit() function.
At some point in the function (early typically),
we add a call to on.exit() giving it the command we want to run when we return from
the function.
```r
f =
function()
{
  opar = par(no.readonly = TRUE)
  on.exit(par(opar))
  par(mar = c(0, 0, 0, 0), pty = "s")
  plot(1:10)
}
```
Examine the value of par()[c("mar", "pty")] before and after the call.
They should be the same.
However, if we had omitted the on.exit(), the values set in the function f would 
be in effect.

As a second example, consider the function
```r
f =
function()
{
  Sys.sleep(2)
  print("cleanup")
  TRUE
}
```
We use print("cleanup") to illustrate doing something important to cleanup
after the computations.

Run this function and we see cleanup printed on the console after 2 seconds.

Now, run the function again and immediately stop it (via Ctrl-C or the Stop button on the GUI).
We do not see the cleanup printed.

So  let's change this to use on.exit()
```r
f =
function()
{
  on.exit(print("cleanup"))
  Sys.sleep(2)
  TRUE
}
```
Now run this and interrupt it immediately. We do see cleanup printed. However, the function did not
complete.
