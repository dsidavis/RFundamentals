## Finding Global Variables

As we write functions or move code from one function to another,
we cut and paste and put the code in different contexts.
Very often, we will not have the same names for the variables.
Therefore it is very easy to go wrong and 
have code that uses variables that don't actually exist - good as easy to detect -
or worse, use the name of a variable  that has another existing purpose.
We can either use that variable with the wrong value, or overwrite it!

Use codetools::findGlobals(, FALSE)

+ when writing functions
+ when refactoring/reorganizing code

