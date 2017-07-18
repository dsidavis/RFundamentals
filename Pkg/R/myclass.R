MyClass =
function(x, ...)
{
  structure(list(x, ...), class = "MyClass")
}

plot.MyClass =
function(x, y, ...)
{
    plot(1:10, main = "MyClass")
}

