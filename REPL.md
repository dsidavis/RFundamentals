#

# REPL - Read, Evaluate, Print, Loop.

A REPL is a  loop (the L part) that 
+ Reads input and parses it into an R command(s) 
+ Evaluates the command(s)
+ Prints the result 
and starts over again.

Why do we care? Partially because it helps to understand the nature of an error
which might be a syntax error (at parse time) or run/evaluation-time semantic errors
(e.g. no such variable, wrong input to a function).


We start an interpreter (R, python, MATLAB, etc.)
and it gives us a prompt, waiting for our command.
It is awaiting and reading our input.
When we enter a character, it processes it potentially doing something such as suggesting
auto-completion.
The R part in the REPL comes in when we hit the **return** key.
The REPL attempts to **parse** the text.
There are three possibilities: 
1) the line makes complete sense as a command, 2) contains a syntax error, or 
3) forms an incomplete command that makes partial sense and that needs to be completed.

There are two steps in an R command - checking it is syntactically correct,
and then if it makes sense - evaluating it.

R **parses** the text of the command to see if it is syntactically correct.
If it is not, we get a syntax error.
There are so many ways to write a command that is not syntactically correct.
For example,
```r
lapply(x mean)
2pi = 1
x[[2][1]
lapply(x mean na.rm = TRUE)
```


If the command is syntatically complete and legitimate, i.e., makes sense syntactically, R tries to
evaluate the **expression**.
The rules for evaluation are somewhat involved, but 
basically we find variables along the [search path](SearchPath.html),
and we make function calls.
That's pretty much all there is to the R language.

It may seem that there is a lot more to the language, e.g.  math operators, logic operators,
sequence operator (a:b), subsetting
([, [[, $), assignments, for and while loops, if statements.  But in fact, these are all function calls.  That is one of the elegant aspects of the R language. Master function calls and you master the language. However, function calls are rich.





