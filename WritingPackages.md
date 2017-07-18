# Creating an R Package

Creating a package is pretty simple.
You can have a package 
+ for your own use
+ to share with people in your lab
+ make available to anyone via github or your Web site
+ put on CRAN for general use.

When you put a package on CRAN, it has to successfully
pass all the tests run by the shell command
```
R CMD check --as-cran myPkg.tar.gz
```
This includes documentation, examples, tests and more.
But all the tests are almost always easily dealt with,
just tedious.

For any of the other audiences, a package doesn't have to pass
all the tests, but it is a good idea.

Putting your own functions that you use often is a good thing.
It makes it easy to access the functions - you don't have to source()
individual files, remembering where they are.
It is also easy to use a package on multiple machines,
which is convenient when a) you prototype on your laptop and
then do the actual computations on a compute server,
b) use several machines in parallel computing.


# Structure of a Package

There are helper functions for creating a package.
However, it is a good idea to know how to do it manually
as a) it is so simple, and b) if anything goes wrong, you want
to be able to reason about it rather than just be stuck.

Every package is it in its own director/folder, say **myPkg**.
Within this folder, you need a file named DESCRIPTION and another
named NAMESPACE.  The R code goes into a directory named R.
That's enough to have a functioning package.

The DESCRIPTION file contains the metadata describing the package.
There are several name: value pairs that have to be specified.
These include Package, Title, Version, Description, Author,
License.
If the package uses functions from other packages, it should list
that package in the Imports field.


```
Package: myPkg
Version: 0.1-0
Title: Bivariate Plotting Functions
Description: This provides functions adding marginal density plots and histograms
 to scatter plots, using the base graphics system.
Author: Duncan Temple Lang
Maintainer: Duncan Temple Lang <duncan@r-project.org>
License: BSD
Imports: graphics
```

The version value is typically formatted as major.minor-patch.
The major number starts as 0.
When you make a significant change with either a lot of new functionality
or a backward incompatible change in one or more functions, you increment
the major number.

When you create a new release with new functionality, you increment the minor
number.

When you fix a bug, you increment the patch number.


## License
The choice of license is important.
BSD and GPL 2.0 or 3.0  are all good.
Creative Commons is also good.
But each has implications

## The NAMESPACE File
This file lists what other packages or functions within other packages
your code uses - **imports**, 
and what functions and variables (symbols) you want users of the package
to be able to access directly - **exports**.
The export mechanism allows you to hide helper functions in your package
that are used by functions but are not intended to be called directly by
a user.

The simplest way to get started is to export everything in your package.
You can do this with the following single line in the NAMESPACE file:
```
exportPattern(".*")
```
The pattern is a regular expression and is used to filter
the names in the package. It amounts to 
```
ls(pkg)[grepl(pattern, ls(pkg))]
```

To export specific functions, just list them with
```
export(getAuthorID)
export(getAuthorDocs)
```
or we can put several functions in a single call to `export()`, e.g.,
```r
export(getAuthorID, getAuthorDocs)
```


### Imports
The purposes of importing functions from other package are
+ a) to ensure that the functions are found regardless of what is
on the search path and in what order, and 
+ b)  to avoid adding packages to the search path.

When a package refers to many functions/variables in a package, we should import
that package.
Alternatively, if we reference only a few variables from another package, 
we can import just those via the importFrom() directive.


We can import  an entire package's contents (specificall what it exports to us) using
```
import(RCurl)
import(RJSONIO)
```

We can be more specific and identify specific functions from a package
```
importFrom(RCurl, getForm, getCurlHandle)
```


# Import versus Depends

Dependencies are added to the search path.  Imports are not.

It is almost always better to use import() or importFrom() rather than a Dependency.  This keeps the
search path under the control of the user.  If she wants to load a package, she can; if she doesn't,
she doesn't have to.

If a package requires the user to use functions from a package to create
inputs for its own functions, then it may make sense to have that dependency package
on the search path. But again, the user should chose this, not the package authors.
The user can always use
```r
 x = dep::fun(a, b)
 fun2(x)
```
where fun is in the dependency and fun2 is in our package.


# S3 methods

If your package provides S3 methods that the user can invoke indirectly via the generic, you need to
import the generic, (re)export the generic (eventhough you didn't write it) and then declare each S3
method. We do this all in the NAMESPACE file.

```r
importFrom(graphics, plot)
export(plot)
S3method(plot, "MyClass")
```


