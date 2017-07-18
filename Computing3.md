# How does R compute `1 + 2`?

First, let's consider the even simpler command
```r
pi
```

The R [REPL](REPL.html) consists of the following 3 steps done in order and repeated indefinitely:
Read, Eval, Print.

## Step 1: Parse
R parses the text and turns the text into tokens according to R's grammar.
If the tokens do not form a grammatically correct command, R complains with a parsing error, e.g.,
```r
2pi
Error: unexpected symbol in "2pi"
```
This is because R variable/symbol names cannot start with a digit.
So we get a syntax error.
This is different from not being able to find a variable named 2pi.
This error happens before looking for any variable/symbol.


The REPL implicitly parses  the user input
and then passes the result to the Eval step.
We will however explicitly parse the input ourselves
to see what the parser creates
```r
e = parse(text = "pi")
e
expression(pi)
```
This is an expression and its first element is pi.
Specifically, this is an object of class *name* in R.
```r
class(e[[1]])
[1] "name"
```

## Step 2: Eval
The evaluator gets this expression and evaluates 
its elements. In this case, there is one and it is a *name* element.
This is "simple" for R to evaluate. 
It just searches for a variable with that name.
But how and where does it search?

For a top-level command (i.e. at the R prompt),
R searches for a variable by looking first in the global environment.

[See Environments](GlobalEnvironment.html)


Since `pi` is not in the global environment, R searches
the parent environment of the global environment.
This is the second element of R's search path.
We can see the entire search path with the search() function:
```r
search()
[1] ".GlobalEnv"        "package:stats"     "package:graphics" 
[4] "package:grDevices" "package:datasets"  "package:utils"    
[7] "package:methods"   "Autoloads"         "package:base"     
```
The global environment is first, then by default, the stats package,
and so on. At the end, and always at the end, is the base package.


Let's explicitly compute the parent of global environment:
```r
p = parent.env(globalenv())
<environment: package:stats>
attr(,"name")
[1] "package:stats"
attr(,"path")
[1] "/Users/duncan/Projects/R-3.3-devel/library/stats"
```

And the parent of this environment is the graphics package, i.e., 
the next element in the search path.
```r
parent.env(p)
<environment: package:graphics>
attr(,"name")
[1] "package:graphics"
attr(,"path")
[1] "/Users/duncan/Projects/R-3.3-devel/library/graphics"
```

So R looks in each environment on the search path in the order they are in the search path
and stops when it finds the variable it is looking for, i.e. pi in this case.

R will find this in the **base** package.
We can verify this using the find() function
```r
find("pi")
```

So now that R has found the variable `pi`, it evaluates the command `pi`
by returning its current value.
Thus  3.1415 is the result of the command `pi`.


## Step 3: Print
If you don't assign the result of a top-level command (i.e. at the prompt),
R generally prints the result.
So we see
```r
[1] 3.141593
```

If we assigned the result to a variable,
e.g
```r
x = pi
```
R would not print the result.


Note that this automatic printing is used to display plots, e.g. lattice or grid plots.
This can be quite confusing when a plot does not appear, all because it was assigned and not
printed,
e.g.
```r
p = lattice::xyplot(mpg ~ wt, mtcars)
```
But
```r
print(p)
```
shows the plot.


R does not print the result if the function call that generated the result
returns it explicitly within a call to invisible(), e.g.,
```r
invisible(largeDataFrame)
```
This is a good thing to do in your functions if you know the results are typically large
and a caller doesn't want to see it on the screen.


Keyword: invsible()

## Step 4: Loop 
Finally, R then emits a new prompt and waits for another line of input.




# The More Complex Command `1 + 2`

Consider the simple command
```r
1 + 2
```
What does R do when it gets this line?

## Step 1: Parse
R parses the text and turns the text into tokens according to R's grammar.
If the tokens do not form a grammatically correct command, R complains with a parsing error, e.g.,
```r
1 + *2
Error: unexpected '*' in "1 + *"
```

The parsing converts 1 + 2 into a function call of
the form
```r
+(1, 2)
```
Similarly, the command `x[1]` actually turns into a call
```r
[(x, 1)
```
and
```r
x[1] = 10
```
is a call of the form `[<-(x, 1, 10)`.

(Actually, there are `` around the operator + and [ in these calls, but that is a detail at this point.)

In short
> (Almost) every action/operation in R is a function call

For this reason, we'll be talking a lot about function calls.
You need to understand how they work to understand R.
This includes 
+ how arguments are matched to parameters
+ how variables/symbols are found during the evaluation of a function
+ lazy evaluation
+ call frames and scope
+ how values are returned


# Step 2: Eval
R then evaluates this call.
It first attempts to find the function +.
It repeats the same search we saw for `pi` in the first command.
In other words, it searches the global environment,
then its parent which is the second element of the search path, and so on.


## Looking for a Function
R is smarter than to find just any symbol named +.  It knows it is looking
for a function, so if it finds a variable named + that is not a function, it keeps searching.
Suppose we create a variable named log in our global environment
```r
log = 1
```
and then call `log(3)`.
R will parse the command "log(3)" into a call to the log function.
It will search for the function log.
It will find the variable named log we created in the global environment.
But it is not a function, so it keeps searching
```r
find("log")
[1] ".GlobalEnv"   "package:base"
10> find("log", "function")
[1] "package:base"
```

### Function not Available
If R fails to find the function, we get an error, e.g.,
```r
z(1)
Error: could not find function "z"
```
Note that this is not a syntax error. It is a legitimate command syntactically.
It is evaluating the call that causes the error.


## The Function Call
Now that R has found the function +, it can call it.
Note that the + function is a regular function object in R.
We can manipulate it directly in R.
We can print its value with
```r
`+`
function (e1, e2)  .Primitive("+")
```
<div class="aside">
Why did we need bacticks (\`\`) around the +?
Because if we type + and hit return in R,
the parser considers this an incomplete command.
So it emits the continuation prompt, coincidentally also the + character.
So we cannot tell R to evaluate the command +. Instead, we need to say
evaluate the symbol named + and we do this with \`+\`
</div>


We don't have to worry about the .Primitive() call within the 
body of the `+` function.
More importantly, `+`  has two parameters/formal arguments,
named e1 and e2.
The R evaluator passes the arguments to the `+` function
and these map to the variables e1 and e2.
(We'll talk more about how this is done generally.)


When the `+` function needs the value for the parameter
e1, it evaluates the expression associated with e1.
In this case, e1 will contain the **value** 1.
When R evaluates a literal value (a number or a string), it simply returns
that value. 
We chose this example because it uses literal values 1 and 2.
The parser turns these tokens into numeric (not integer)
values.


# Exercise
1. Consider
 ```r
 1 + pi
 ```
 What are the steps involved in R computing this?

1. Consider
 ```r
 1 + 2 * 3
 ```
 What are the steps involved in R computing this? 
 How many function calls are there? To what function?
 
1. And
 ```r
 1 + sin(2)
 ```
 What are the steps involved in R computing this?  


# Step 3: Print
R prints the result of the call to `+`, i.e. 3.

# Step 4: Loop
And we get another prompt, > and R awaits our next command/input.



# Exercise

1. What happens with the command `sum(10, 20, 30 40)`
1. Will the command `10/` produce a syntax error? 

