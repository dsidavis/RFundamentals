foo = function(a, b = a+1, c = 1:10, ...){}
# error
match.call(foo, foo(1, c = 2, 3, x = 1))

match.call(foo, quote(foo(1, c = 2, 3, x = 1)))
foo(a = 1, b = 3, c = 2, x = 1)
