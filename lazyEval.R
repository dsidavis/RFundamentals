f =
function(x, y, )
{
  na = is.na(x)
  if(any(na)) {
     x = x[!na]
     y = y[!na]
  }

  plot()
}
