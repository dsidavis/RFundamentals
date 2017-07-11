
# The Search Path

We saw that the search path is an ordered collection of environments.
Importantly, the parent of one of these environments is the next
element of the search path.

## Order Matters
When we load a package (using library() or require())
R adds this to the search path.
By default, R adds it in the second position.
We can control this  via the `pos` parameter.

Importantly, if we have two packages that both provide a variable named, say, foo.  Then which one
we will find depends on which package is first in the search path.
This is one reason for explicitly specifying the variable you want by prefixing
it with the package name, e.g.,
```
codetools::findGlobals
RCIndex::findGlobals
```
Code that just used findGlobals() could give an error if it finds the wrong one.
Even worse, it may silently give the wrong results.


## Short Search Paths

Recall how we find symbols such as +.
As the search path gets longer, we have to seach more environments.
This is a reason to keep the search path to what you actually need.
You can refer to variables in packages withou having  the package on
the search path. You can use, e.g.,
```r
codetools::findGlobals(plot)
```

## Packages 
Later we'll talk about code in packages and how R finds variables to which these functions
refer. We typically try not to use the search path within packages to avoid the
possibility of the user ordering the search path in a way we did not intend/anticipate.
We need to be more robust than this and so we import packages and (some of)  their variables.



## The attach() function. Never use!

> Instead of using the attach function, use with(), within(), subset()
> or explicitly qualify the names of the elements in a data.frame/list with 
> the variable name identifying the data.frame/list.

R has the function attach() and some people use this to 
insert a data frame into the search path.
This ostensibly makes it "easier" to refer to the names
of columns/elements, e.g.,
```r
mtcars$mpg
attach(mtcars)
mpg
```


Let's see what happens
```
search()
[1] ".GlobalEnv"        "package:stats"     "package:graphics" 
[4] "package:grDevices" "package:datasets"  "package:utils"    
[7] "package:methods"   "Autoloads"         "package:base"     
```
Now we attach `mtcars`
```r
attach(mtcars)
```

The data frame is now in the second position of search path 
```r
search()
 [1] ".GlobalEnv"        "mtcars"            "package:stats"    
 [4] "package:graphics"  "package:grDevices" "package:datasets" 
 [7] "package:utils"     "package:methods"   "Autoloads"        
[10] "package:base"     
```

We can walk the search path by environnments, and we see that 
the parent of the global environment is a new enviroment
for the mtcars data:
```r
parent.env(globalenv())
<environment: 0x7ff242c97260>
attr(,"name")
[1] "mtcars"
```

We can see what variables/symbols it contains with ls()
```r
ls(2) # or ls("mtcars")
 [1] "am"   "carb" "cyl"  "disp" "drat" "gear" "hp"   "mpg"  "qsec"
[10] "vs"   "wt"  
```

And the command `cyl` works just a `pi` did.
R looks in each element of the search path until it finds the symbol `cyl`
and it does so in the second element.

`mtcars` was originally a data.frame.
We now have an environment that contains the columns/elements of the data frame.
As with almost all computations in R, these variables in the environment on the search path
are **copies** of the original values in the data frame.
The elements in the environment in the search path are not aliases or linked to the data frame.
Importantly, if we modify a value in the data frame, it is not reflected in the
corresponding variable in search path.
```
mtcars$cyl[1] = 100
mtcars$cyl[1]
[1] 100
cyl[1]
[1] 6
```

Worse still. Let's modify cyl[1] to be 8.
```r
cyl[1] = 8
```
Somewhat curiously, this created a new variable cyl in our global environment.
It did not change the one in the second element of the search path.
How do we know? We can get that with 
```r
get("cyl", 2)
 [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
```
and this shows the original value.

So now we have 3 variables named `cyl` - two on the search path and one in the mtcars data.frame.
```
ls()
```
Let's get rid of the one in the global environment for now
```
rm(cyl)
```

If we had used a global assignment, i.e.,
```r
cyl[1] <<- 8
```
that would have replaced the first element in the second element of the search path.

Check that no new variable named cyl has been created in the global environment.
