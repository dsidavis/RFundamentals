# Day 4

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

+ [R Session for Day 4](RSession4)

+ Getting the (row,col) values from a logical subsetting of a matrix.
```r
 set.seed(1012)
 m = matrix(rnorm(15), 5, 3)
 m > 0
 which(m > 0)
``` 
 But which row and column pairs
```r
 a = m > 0
 cbind(row(a)[a], col(a)[a])
```

+ example of expand.grid() and apply() over these and long form.

+ tapply(), by(), aggregate()

+ S3 classes and methods
    + Generic function & UseMethod
    + NextMethod
+ [Writing Functions](WritingFunctions.html)
    + Default Values for Parameters
    + Idioms for writing parameters and default values.
    + Warnings and Errors
+ [Debugging](Debugging.html)
+ [Writing R Packages](WritingPackages.html)
    + Directory structure
	+ DESCRIPTION
	+ NAMESPACE
      + Imports and exports


# Maybe Get To (No!)
+ Closures & Environments
   + The computational model
   + <<- 
   + Clean up unnecessary variables

+ S4 classes and methods

+ Formulae & Environments
   + Clean up unnecessary variables
