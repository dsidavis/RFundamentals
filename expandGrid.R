# The idea here is to show how we can do a simulation with different
# combinations of settings and then organize the data into "long form"
# so that we can identify the outputs from each by the settings.

# We use two different settings - cond1 and cond2
# These have 2 and 3 possible values respectively.
# We run the simulation on all possible combinations of these two settings, i.e.
# 6 combinations.
# We replicate the simulation for each NumReplicates times.

# The simulation is simple here and just creates a data frame.
#
#

sim =
function(a, b, n = rpois(1, a + b))
{
  x = rnorm(n, a)
  data.frame(x = x, y = x*rexp(n, min(.1, b*x)))
}



cond1 = c("A", "B")
cond2 = c("High", "Medium", "Low")

mu = c(A = 10, B = 20)
rate = c(High = 40, Medium = 30, Low = 24)

NumReplicates = 10
 # Generate the 6 possible combinations of settings
 # This is a data.frame of factors. We could use stringsAsFactors = FALSE
g = expand.grid(cond1, cond2)

# Run the simulations for the 6 different levels.
# We could use apply() since these are character vectors
ans = lapply(1:nrow(g),
              function(i) {
                 settings = g[i,]
                 replicate(NumReplicates, sim(mu[settings[1,1]], rate[settings[1,2]]), simplify = FALSE)
       })


# Now we convert the list of lists() of data frames to a single data frame
tmp = unlist(ans, recursive = FALSE)
length(tmp)
table(sapply(tmp, class))

ans1 = do.call(rbind, tmp)

# Next we'll compute the appropriate values for cond1 and cond2 for each row
n = sapply(ans, function(x) sum(sapply(x, nrow)))
ans1$cond1 = rep(g[,1], n)
ans1$cond2 = ordered(rep(g[,2], n), labels = rev(cond2))

# We also add the simulation/replicate number for each row within each of the 6 combinations of
# settings of cond1 and cond2
ans1$simNumber = unlist(sapply(ans, function(x) rep(seq(along = x), sapply(x, nrow))))
# Just check the results are sensible and correct
q1 = table(ans1$simNumber)
#  1   2   3   4   5   6   7   8   9  10 
#279 263 273 273 259 291 284 297 294 276 
q2 = sapply(ans, function(x) sapply(x, nrow))
#     [,1] [,2] [,3] [,4] [,5] [,6]
# [1,]   46   55   43   57   28   50
# [2,]   41   62   41   49   27   43
# [3,]   50   55   35   53   29   51
# [4,]   50   62   32   41   41   47
# [5,]   53   58   29   54   22   43
# [6,]   60   68   33   49   27   54
# [7,]   46   58   47   49   37   47
# [8,]   53   77   33   50   41   43
# [9,]   49   63   43   52   36   51
#[10,]   49   57   46   40   32   52
q3 = rowSums(sapply(ans, function(x) sapply(x, nrow)))
stopifnot(all(q1 == q3))

# Now we can plot these.
library(lattice)
xyplot(y ~ x | cond1 + cond2, ans1)
