lm1 <- lm(y1 ~ x1, data = anscombe)

plot(anscombe$x1, anscombe$y1, xlab = "x1", ylab = "y1",
     main = "Anscombe's Set 1")
abline(lm1)

par(mfrow = c(1, 1), family = "serif")

plot(anscombe$x1, anscombe$y1, xlab = "x1", ylab = "y1",
     main = "Anscombe's Set 1")
abline(lm1)

windowsFonts(Garamond = windowsFont("Garamond"))
par(mfrow = c(1, 1), family = "Garamond")

plot(anscombe$x1, anscombe$y1, xlab = "x1", ylab = "y1",
     main = "Anscombe's Set 1",
     col = "darkblue",
     col.main = "darkblue", col.lab = "gray30", col.axis = "gray30")
abline(lm1, col = "firebrick", lwd = 2)

windowsFonts(Garamond = windowsFont("Garamond"))
par(mfrow = c(1, 1), family = "Garamond")

plot(anscombe$x1, anscombe$y1, xlab = "x1", ylab = "y1",
     main = "Anscombe's Set 1",
     col = "darkblue", pch = "E", cex = 1.3,
     col.main = "darkblue", col.lab = "gray30", col.axis = "gray30")
abline(lm1, col = "firebrick", lwd = 2)