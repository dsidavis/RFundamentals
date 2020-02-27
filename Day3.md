# R Fundamentals Day 3

<center>
<div>
<table>
<tr>
<th><a href="Day1.md">Day1</a></th><th><a href="Day2.md">Day2</a></th><th><a
href="Day3.md">Day3</a></th><th><a href="Day4.md">Day4</a></th>
</tr>
</table>
</div>
</center>

+ [R Session for Day 3](RSession3)

+ Recap/Questions
+ Everything is an object in R - including the language objects, functions, if, while, ....
+ lists, data.frames 
    + [, [[ and $
    + Data frames and 2-D subsetting
+ Can't use logical vector in 1-D list subsetting for [[ 
    + x[[  c(TRUE, FALSE, TRUE, ... ) ]]
    + Need to use which().  But need to ensure only one or else hierarchical subsetting.
    + Or `x [ logicalVector ][[1]]`
+ [factors](Factors.html)
    + Subsetting by factors and keeping/dropping levels.
+ [Vectorization in rnorm(), etc.](rnormVec.html)
    + `rnorm(n, mean = vector, sd = vector)`
+ [apply() functions](Apply.html)
    + Passing additional arguments
    + Different apply() functions
+ [try()/tryCatch()](tryCatch.html)
+ [2-D subsetting - matrices](MatrixSubsetting.html)
+ [Writing Functions](WritingFunctions.html)
    + Default values for parameters
    + Idioms
    + warnings and errors
+ [Debugging](Debugging.html)
+ [Writing R Packages](WritingPackages.html)
    + Directory structure
	+ DESCRIPTION
	+ NAMESPACE
+ [Other Topics](Day4.html)

