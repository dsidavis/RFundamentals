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
Title: Bivariate Plotting Functions
Description: This provides functions adding marginal density plots and histograms
 to scatter plots, using the base graphics system.
Author: Duncan Temple Lang
Maintainer: Duncan Temple Lang <duncan@r-project.org>
License: BSD
Imports: graphics
```

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
```
import(RCurl)
import(RJSONIO)
```

We can be more specific and identify specific functions from a package
```
importFrom(RCurl, getForm, getCurlHandle)
```


# Import versus Depends

