
read.csv() calls read.table()

read.table 
 notice text has no default value. Yet we rarely specify it.
 
 
... and parameters after ... and no partial name matching.

Call frame
Stores
  + symbol/name value bindings
  + parameters and default value expressions
  + matches arguments to parameters
    + name
	+ partial name
	+ position/index
  + local variables created during the evaluation of the function's body.
  
  
