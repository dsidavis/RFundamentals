# Fundamentals of R

This brief mini-course focuses on explaining the computational model that underlies R.  I believe
that if you understand this, you can **reason** about the R code and the language and can more
rapidly solve (and avoid) problems with your code.  This approach is different from learning by
examples close to your needs and adapting existing code.  Both approaches are valuable, but the
fundamentals provide the foundation to grow.

This mini-course does not attempt to teach you lots of functions and packages that you
use on a daily basis. Instead, it is focused on R's language and computational model.

This mini-course will not explore the tidyverse. This is because these packages
use non-standard evaluation and insulate the user from the the core language for basic
data manipulation. We are not saying you shouldn't use these packages. Rather we
are saying that is important to learn the fundamentals and then leverage these when
they improve your programming and productivity.  With a strong foundation in the language,
you can learn anything related to it. If you know only a particular set of packages or particular
functions and idioms, you are limited to those.


# Topics

1. <a href="Computing3.html">How is 1 + 2 computed?</a> 
    + [REPL](REPL.html)
	    + [Exercise 1](Excercise1.html)
    + [Global environment](GlobalEnvironment.html)
    + [Search Path](SearchPath.html)
    + [Variables and Assignment (=, <-, ->)](Variables.html)	
    + ["Everything" is a Function Call](EverythingIsACall.html)
	    + [Exercise 2](Excercise2.html)
		
1. [How function calls work](FunctionCalls.html)	
    + Matching arguments to parameters
	    
	+ Lazy evaluation
    + [Scope of evaluation](Scope.html)
	+ [Pass by Value](PassByValue.html)
	+ return value
	+ on.exit()
	
	
<!--	
1. [Basic data types - vectors](BasicTypes.md)
    + [Hierarchy of data types](VectorHierarchy.md) and implicit coercion
    + [Class, typeof](class.md)
    + [length, dim, names](length.md)
    + [Attributes Generally](Attributes.md)
1. [Categorical data - factors](Factors.md)
1. Everything is a copy (and copy on write).
1. [Vectorized/Element-wise Functions & the Recycling Rule](RecyclingRule.md)
1. [Subsetting rules](Subsetting.md)
    1.  index/position
    1.  logical indexing
    1.  name
    1.  exclusion - negative position	
    1.  empty
	1.  by two column matrix
	1.  by matrix
	1.  drop = TRUE/FALSE
1. [Lists](Lists.md)
1. [Subsetting Lists -\[, \[\[, $](SubsettingLists.md)
1. [Data Frames](DataFrames.md)	
1. [Subsetting in 2-Dimensions](Subsetting2D.md)
1. [Matrices](Matrices.md)
    + [Subsetting a matrix by matrix](MatrixSubsetting.md)

1. [try() and tryCatch()](tryCatch.md)
1. [Defining Functions](WritingFunctions.md)

1. [Closures](closures.md)
1. [formulas](formulas.md)

1. [Debugging](Debugging.md)

1. [S3 class system](S3Classes.md)
1. [Using Packages](UsingPackages.md)
1. [Writing Packages](WritingPackages.md)
1. [NAMESPACE files](NamespaceFiles.md)

-->

<!--
# Reading Data from Files


# Graphics Systems & EDA

?[Aggregate functions](AggregateFunctions.md) - sum, mean, summary, table, 
-->


