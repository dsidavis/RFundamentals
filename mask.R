par(mar = rep(0, 4))
png("vec.png", 500, 200, bg = "transparent")
plot(0, type = "n", axes = FALSE, xlab = "", ylab = "", xlim = c(0, 1), ylim = c(0, 1))
x = seq(0, 1, length = 10)
rect(x[- length(x)], .25,  x[-1], .75)
text((x[-length(x)] + x[-1])/2, .5, 1:9)
dev.off()


png("logicalMask.png", 500, 200, bg = "transparent")
plot(0, type = "n", axes = FALSE, xlab = "", ylab = "", xlim = c(0, 1), ylim = c(0, 1))
x = seq(0, 1, length = 10)
i = c(FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE)
rect(x[- length(x)], .25,  x[-1], .75, col = c("#FFFFFFFF", "#D3D3D3FF")[i+1])
text((x[-length(x)] + x[-1])/2, .85, i)
dev.off()


png("logicalSubset.png", 500, 200, bg = "transparent")
plot(0, type = "n", axes = FALSE, xlab = "", ylab = "", xlim = c(0, 1), ylim = c(0, 1))
x = seq(0, 1, length = 10)
i = c(FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE)
rect(x[- length(x)], .25,  x[-1], .75, col = c("#FFFFFFFF", "#D3D3D3FF")[i+1])
text(((x[-length(x)] + x[-1])/2)[i], .15, (1:9)[i])
dev.off()

