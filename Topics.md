## REPL
  + why useful to know the different "moving" parts
  + Parsing
  + Partially complete commands
  + Syntax errors
  

## Evaluate
  + literal values
  + finding/resolving symbols - pi
     + variables and assignment
  	 + environments and global environment
     + search path
  + function calls
  + everything is a function call	
  + details of function calls
      + Matching arguments to parameters
	+ Scope within a function
	    + environments/call frames
		+ package environments
	+ Lazy evaluation
	+ pass by value	("everything" is a copy)
	+ return value
	   + last value in a { }
	   + applies to if()
	      + x = if(cond) {...} else {...}
  + finding symbols in a package.


  
## Debugging
  + Proactive and reactive.
  + debug(), browser()
  + options(error = recover),
  + call stack
     + sys.calls()
	 + sys.frames()
	 + sys.frame()
  + try()/tryCatch()
  + options(warn = {0, 1, 2})


## Writing Functions
+ default values
+ idioms for making functions more flexible, reusable, different entry points.
+ on.exit()
+ warning() and stop().
+ closures and scope
   +  `<<-` - non-local assignment
   
## Formulae
+ evaluation
+ environment
+ weights in modeling. Boosting.



## Everything is an object.  
  + class() - how do we think of it.
  + typeof() - how is it built
  + str()
  + names()
  + length()
  + dim()
  
## Attributes  
  + attr()
  + structure(obj, attr = , attr = ...)
  

## Data Types
+ Hierarchy of vector types
+ NA
+ subsetting - 6 types.


## OOP - S3, S4 methods
+ Key concept
  + same function name/verb (e.g. plot, summary), customized behavior based on type.
  + extensiblity
  + Inheritance
+ Method lookup - S3, S4
+ Inheritance mechanism - NextMethod(), callNextMethod()

