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
				  substitute(f(x), list(f = simFun)
                  replicate(NumReplicates, simFun, simplify = FALSE)
       })
}



A much simpler example is the following.
Suppose we have a sample of observations in the variable x.
Let's assume it has a density
