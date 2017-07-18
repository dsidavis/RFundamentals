sim =
function(a, b, n = rpois(1, a + b))
  data.frame(x = rnorm(n, a), y = rexp(n, b))


cond1 = c("A", "B")
cond2 = c("High", "Medium", "Low")

mu = c(A = 10, B = 20)
rate = c(High = 40, Medium = 30, Low = 24)

NumReplicates = 10
g = expand.grid(cond1, cond2)

ans = lapply(seq_len(nrow(g)),
              function(i) {
                 settings = g[i,]
                 replicate(NumReplicates, sim(mu[settings[1,1]], rate[settings[1,2]]), simplify = FALSE)
       })

tmp = unlist(ans, recursive = FALSE)
length(tmp)
table(sapply(tmp, class))

ans1 = do.call(rbind, tmp)

n = sapply(ans, function(x) sum(sapply(x, nrow)))
ans1$cond1 = rep(g[,1], n)
ans1$cond2 = ordered(rep(g[,2], n), labels = rev(cond2))

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

library(lattice)
xyplot(y ~ x | cond1 + cond2, ans1)
