# This shows how R looks for a function
# and not just the variable named sin.

# We create a variable in the global environment
sin = 1
sin
# Now if we call a function with this name, R knows
# to look for a function and not just the first variable
# with this name.
sin(0)

# One might think that in the following  call to sapply
# R would evaluate the second argument - sin - in the
# same way it would normaly evaluate the symbol sin.
# However, sapply knows this second argument should be a function.
# This is NSE - non-standard evaluation.

sapply(c(0, pi/2), sin) # works. Magic/NSE!

# The following gets the value of `sin` without
# the context of looking for a function. So
# this results in an error as get("sin") returns the value
# 1 and  1(0) doesn't make sense.
get("sin")(0)
