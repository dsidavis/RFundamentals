# R Fundamentals - Day 2

<!-- 
1. Everything is a copy (and copy on write).
-->

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

+ [R Session for Day 2](RSession2)

## Questions & Review 

+ attach() - NOT UNDER ANY CIRCUMSTANCES (unless *never* change)

## Data Types/Structures

1. [Basic data types - vectors]   <!-- (BasicTypes.html) -->
    + [Hierarchy of data types](VectorHierarchy.html) and implicit coercion
    + [Class, typeof, length](Attributes.html)
    + [dim, names](Attributes.html)
	+ [Sequences](Sequences.html)
	+ [NAs and is.na()](NA.html)
1. [Vectorized/Element-wise Functions & the Recycling Rule](RecyclingRule.html)
    + The family of apply functions.	
1. [Subsetting rules](Subsetting.html)
    1.  index/position – `x[ c(10, 2) ]`
		1.  Subset with 0
    1.  logical indexing – `x[ c(FALSE, FALSE, TRUE, TRUE, FALSE) ]`
    1.  name – `x[ c("a", "xyz") ]`
    1.  exclusion via negative position/index – `x[ - c(1, 3, 9) ]`
    1.  empty – `x[]`
	1.  Subsetting outside the length of a vector		
	1.  drop = TRUE/FALSE - factors and 	
	1.  2-dimensional subsetting
	1.  by two column matrix
	1.  by matrix
1. [Categorical data - factors](Factors.html)	
1. [Lists](Lists.html)
1. [Making Lists - c() and list()](ListAndC.html)
1. [Subsetting Lists -\[, \[\[, $](Subsetting.html)
    1. \[ verus \[\[
    1. partial name matching with $ and not with \[\[
    1. hierarchical indexing
1. [Data Frames](DataFrames.html)	
1. [Subsetting in 2-Dimensions](Subsetting2D.html)

1. [Matrices](Matrices.html)
    + [Subsetting a matrix by matrix](MatrixSubsetting.html)

1. [Attributes Generally](Attributes2.html)
