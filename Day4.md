# Day 4

<center>
<div>
<table>
<tr>
<th>[Day1](Day1.md)</th><th>[Day2](Day2.md)</th><th>[Day3](Day3.md)</th><th>[Day4](Day4.md)</th>
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
