# Fundamentals of R

This brief course focuses on explaining the computational model that underlies R.  I believe that if
you understand this, you can **reason** about the R code and the language and can solve problems
with your code.  This approach is different from learning by examples close to your needs and
adapting existing code.  Both approaches are valuable, but the fundamentals provide the foundation
to grow.

This mini-course will not explore the tidyverse. This is because these packages
use non-standard evaluation and insulate the user from the the core language for basic
data manipulation. We are not saying you shouldn't use these packages. Rather we
are saying that is important to learn the fundamentals and then leverage these when
they improve your programming and productivity.  With a strong foundation in the language,
you can learn anything related to it. If you know only a particular set of packages or particular
functions and idioms, you are limited to those.


# Topics

1. [REPL](REPL.md)
1. [Global environment](GlobalEnvironment.md)
1. [Variables and Assignment (=, <- )](Variables.md)
1. [Basic data types - vectors](BasicTypes.md)
1. [Hierarchy of data types](VectorHierarchy.md) and implicit coercion
1. [Class, typeof](class.md)
1. [length, dim, names](length.md)
1. [Categorical data - factors](Factors.md)
1. [Subsetting rules](Subsetting.md)
    1.  index/position
    1.  logical indexing
    1.  name
    1.  exclusion - negative position	
    1.  empty
1. [Aggregate functions](AggregateFunctions.md) - sum, mean, summary, table, 
1. [Vectorized functions](VectorizedFuns.md)
1. [Subsetting in 2-Dimensions](Subsetting2D.md)
1. [How function calls work](FunctionCalls.md)
1. [Scope of evaluation](Scope.md)
1. [Defining Functions](WritingFunctions.md)
1. [Debugging](Debugging.md)
1. [S3 class system](S3Classes.md)
1. [Using Packages](UsingPackages.md)
1. [Writing Packages](WritingPackages.md)
1. [NAMESPACE files](NamespaceFiles.md)


# Reading Data from Files


# Graphics Systems & EDA




