par(mar = rep(0, 4))
plot(0, xlim = c(0, 1000), ylim = c(0, 1000), axes = FALSE, type = "n", xlab = "", ylab = "")

w = 300
h = 300
xfac = .7
x.offset =  70
rect(x.offset + 0, 700, x.offset + w, 700+h)
text(0, 700 + h, "scatter.smooth()")


rect(x.offset + w*xfac, 420, x.offset + w*xfac + w - 40, 420+h)
text(w*xfac, 420 + h, "xy.coords()")

rect(x.offset + (1+xfac)*xfac*w, 140, x.offset + w*(1+xfac)*xfac + w - 40, 140+h)
text(w*(1+xfac)*xfac, 140 + h, "[()")
