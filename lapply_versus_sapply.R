x = 1:100 # rnorm(100)
g = sample(c("A", "B", "C", "D"), 100, replace = TRUE)

split(x, g)
