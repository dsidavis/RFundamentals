scatter.smooth(mtcars[, c("mpg", "wt")], , , ,
               "gaussian", "Weight of car", "Miles per Gallon",
               lpars = list(lwd = 2, col = "red"),
               main = "Motor Trends Data")

scatter.smooth(mtcars[, c("mpg", "wt")], fam = "gaussian",
               xl = "Weight of car", yla = "Miles per Gallon",
               lpars = list(lwd = 2, col = "red"),
               main = "Motor Trends Data")

n = 10
scatter.smooth(rnorm(n), rpois(n, lambda), fam = "gaussian",
               xl = "Weight of car", yla = "Miles per Gallon",
               lpars = list(lwd = 2, col = "red"),
               main = "Motor Trends Data")

    xlabel <- if (!missing(x)) 
        deparse(substitute(x))
    ylabel <- if (!missing(y)) 
        deparse(substitute(y))
    xy <- xy.coords(x, y, xlabel, ylabel)
    x <- xy$x
    y <- xy$y
    xlab <- if (is.null(xlab)) 
        xy$xlab
    else xlab
    ylab <- if (is.null(ylab)) 
        xy$ylab
    else ylab
    pred <- loess.smooth(x, y, span, degree, family, evaluation)
    plot(x, y, ylim = ylim, xlab = xlab, ylab = ylab, ...)
    do.call(lines, c(list(pred), lpars))
    invisible()
}



function (x, y = NULL, span = 2/3, degree = 1, family = c("symmetric", 
    "gaussian"), xlab = NULL, ylab = NULL, ylim = range(y, pred$y, 
    na.rm = TRUE), evaluation = 50, ..., lpars = list()) 
