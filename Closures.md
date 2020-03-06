# Closures

We've seen how to create functions at the top-level prompt and in files that we source() from the
prompt and also from within packages.  When we define a function at the prompt or via source(), its
environment is the global environment.  When we define a function in a package, its environment is
the package's namespace environment.

Next consider the case we saw where we define a function within a function.

doSim =
function(simFun, ..., funNumReplicates = 99, .grid = expand.grid(...))
{
   ans = lapply(seq_len(nrow(.grid)),
                function(i) {
                  settings = .grid[i,]
				  substitute(f(x), list(f = simFun))
                  replicate(NumReplicates, simFun, simplify = FALSE)
       })
}



A much simpler example is the following.
Suppose we have a sample of observations in the variable x.
Let's assume it has a density


Consider maximum likelihood.
We have a sample of values in a variable `x`.
```
x = rnorm(100)
```
We compute the likelihood value for a given assumed distribution
and value of the distribution's parameters. 
For example, we'll assume the
data are normal.
So we'd calculate  likelihood with
```
prod(dnorm(x, mu, sigma))
```
for a given mu and sigma.

We might define a likelhood function for this sample as
```
f = 
function(mu, sigma)
  prod(dnorm(x, mu, sigma))
```
But x is now a global variable. This is not good.
We want to capture x in the function so that it is local and available.
We do this with a function that returns a function
```
mkLikelihood =
function(x)
{
  function(mu, sigma)
     prod(dnorm(x, mu, sigma))
}
```

```
l1 = mkLikelihood(x)
x1 = x
rm(x)
```
```
x2 = rnorm(20, 1, 2)
l2 = mkLikelihood(x2)
```

```
mu = seq(-1, 1, by = .01)
```
```
tmp = sapply(mu, l1, sigma = 1)
```

```
plot(mu, tmp, type = "l")
abline(v = mean(x))
