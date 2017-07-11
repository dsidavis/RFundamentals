
f =
function(x, y)
{
   cat("Starting f\n")
   x + 1
   cat("Evaluated x, now y\n")
   y + 2

   TRUE
}


f(1:10, 2:20)

f(1:10, {cat("This is y\n"); 2:20})

