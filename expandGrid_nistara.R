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
  data.frame(x = rnorm(n, a), y = rexp(n, b))

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
ans = lapply(seq_len(nrow(g)),
              function(i) {
                 settings = g[i,]
                 replicate(NumReplicates, sim(mu[settings[1,1]], rate[settings[1,2]]),
                           simplify = FALSE)
              })

# note start--------------------------------------------------------------------
#  wouldn't g, mu and rate above be from the global environment? If we were to
# avoid using global variables, would the following be a decent approach?
ans = lapply(seq_len(nrow(g)),
              function(i, g, mu, rate) {
                 settings = g[i,]
                 replicate(NumReplicates,
                           sim(mu[settings[1,1]], rate[settings[1,2]]),
                           simplify = FALSE)
              }, g, mu, rate)

# breakdown of the above simulations for a single combination:
settings = g[1,] # combination of 'A' and 'High'
settings[1,1] # gives 'A'
mu[settings[1,1]] # gives 10, the value of mu for 'A' 
settings[1,2] # gives 'High'
rate[settings[1,2]] # gives 40, value of rate for 'High'
sim(mu[settings[1,1]], rate[settings[1,2]]) # single simulation set
# repeat simulation NumReplicates times
replicate(NumReplicates, sim(mu[settings[1,1]], rate[settings[1,2]]),
          simplify = FALSE)

# difference in results with and without simplify = FALSE
set.seed(0)
str(replicate(NumReplicates, sim(mu[settings[1,1]], rate[settings[1,2]]),
                 simplify = FALSE))

set.seed(0)
str(replicate(NumReplicates, sim(mu[settings[1,1]], rate[settings[1,2]])))

# ans is basically a nested list.
# First, it has 6 component lists corresponding to the 6 combinations of the conditions
# (cond1 and cond2)
# Each of the 6 components contain 10 replicates of the simulation.
# The simulation results themselves are dataframes.
# note end----------------------------------------------------------------------


# Now we convert the list of lists() of data frames to a single data frame
tmp = unlist(ans, recursive = FALSE)
length(tmp)
table(sapply(tmp, class))

ans1 = do.call(rbind, tmp)


# note start--------------------------------------------------------------------
# compare
str(tmp)
# with
str(unlist(ans))
# to appreciate why we use recursive = FALSE

# unlist() above removes the outtermost layer of condition
# 6 condition combinations * 10 replicates = 60 simulation dataframes

# We now have just a list of all the replicate dataframes, which are finally
# collapsed together with do.call and rbind
# note end----------------------------------------------------------------------


# Next we'll compute the appropriate values for cond1 and cond2 for each row
n = sapply(ans, function(x) sum(sapply(x, nrow)))
ans1$cond1 = rep(g[,1], n)
ans1$cond2 = ordered(rep(g[,2], n), labels = rev(cond2))


# note start--------------------------------------------------------------------
# n = sapply(ans, function(x) sum(sapply(x, nrow)))
# eg. for the first cond1 cond2 combination
x = ans[[1]]
# length of simulation dataframes for each replicate
sapply(x, nrow)
# hence total no. of rows corresponding to first cond1 cond2 combination
sum(sapply(x, nrow))
# which is the same as
n[1]

# the above is repeated for each combination using another sapply
# finally the correct values of cond1 and cond2 are added to the approriate
# rows in ans1, the single dataframe containing all the sim results

# to understand the rep part:
g[,1] 

# say 
n2 = c(2, 3, 1, 6, 4, 8)
# then
c1 = rep(g[,1], n2)
# similarly
c2 = ordered(rep(g[,2], n2), labels = rev(cond2))
data.frame(c1,c2)
# which doesn't correspond to the combination sequence seen in g
g

# not using rev seems to work though
c2 = ordered(rep(g[,2], n2), labels = cond2)
data.frame(c1,c2)

# note end----------------------------------------------------------------------


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
