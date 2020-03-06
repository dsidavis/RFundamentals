set.seed(12312)
a = runif(10)
b = 5 + 2.34*a + rnorm(length(a))

b  ~ a
coef(lm(b ~ a))


w1 = rep(1, length(b))
w2 = runif(length(b), 1, 2)


coef(lm(b ~ a, weights = w1))
coef(lm(b ~ a, weights = w2))
# (Intercept)           a 
#    5.097029    2.618424 
# (Intercept)           a 
#    5.305530    2.194265


d = data.frame(a = a, b = b)
coef(lm(b ~ a, d))
# Which b and a did it uses.
# What if we (re)moved a
a1 = a
rm(a)
coef(lm(b ~ a, d))
# So still finding the original a which is a column in d.
coef(lm(b ~ a, d, weights = w2))


e = new.env()
e$a = a
e$b = b1
frm = b ~ a
environment(frm)
environment(frm) = e

coef(lm(frm, weights = w1))
coef(lm(frm, weights = w2))

e$w1 = w2
coef(lm(frm, weights = w1))
# Uses w1 from e, not from w1!


# Get rid of w1 from e and run lm() again
rm(list = "w1", envir = e)
ls(e)

coef(lm(frm, weights = w1))


# Let's put w1 back in e and debug lm
e$w1 = w2
debug(lm)
coef(lm(frm, weights = w1))

# print(weights)
#  all 1's corresponding to w1

# note the sequence  of expressions
#
#  mf <- match.call(expand.dots = FALSE)
#  m <- match(c("formula", "data", "subset", "weights", "na.action", "offset"), names(mf), 0L)
#  mf <- mf[c(1L, m)]
#  mf[[1L]] <- quote(stats::model.frame)
#  mf <- eval(mf, parent.frame())
#which leads to
#    stats::model.frame(formula = frm, weights = w1, drop.unused.levels = TRUE)
# 
# debug(stats::model.frame)
#
# print(data)
# print(formula)  # note the formula.
#
# as we proceed, data is missing() and we get the 'command'
#    data <- environment(formula)
# So it will look in the environment of the formula.

#  extras <- substitute(list(...))
#  extranames <- names(extras[-1L])   # weights
#  extras <- eval(extras, data, env)
# After this, look at extras. Since it was evaluated in data and env (both are the same as each other)
# we find the w1 in env rather than the w1 in the call to our function.
# Compare extras to w1 and w2.
# It is the values of w2, not the w1 we passed in the call to lm()
# See sys.calls()

#######



model.frame(frm)
