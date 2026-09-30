x  <- c(0.5, 2, 4, 8, 12, 16)
y1 <- c(1, 1.3, 1.9, 3.4, 3.9, 4.8)
y2 <- c(4, .8, .5, .45, .4, .3)
par(las = 1, mar = c(4, 4, 2, 4), cex = .7)
plot.new()
plot.window(range(x), c(0, 6))
lines(x, y1)
lines(x, y2)
points(x, y1, pch = 16, cex = 2)
points(x, y2, pch = 21, bg = "white", cex = 2)
?points
par(col = "gray50", fg = "gray50", col.axis = "gray50")
axis(1, at = seq(0, 16, 4))
axis(2, at = seq(0, 6, 2))
axis(4, at = seq(0, 6, 2))
box(bty = "u")
mtext("Travel Time (s)", side = 1, line = 2, cex = 0.8)
mtext("Responses per Travel", side = 2, line = 2, las = 0, cex = 0.8)
mtext("Responses per Second", side = 4, line = 2, las = 0, cex = 0.8)
text(4, 5, "Bird 131")
par(mar = c(5.1, 4.1, 4.1, 2.1), col = "black", fg = "black", col.axis = "black")
## Anscombe (1973) Quartlet

data(anscombe)  # Load Anscombe's data
View(anscombe) # View the data
summary(anscombe)

## Simple version
plot(anscombe$x1,anscombe$y1)
summary(anscombe)
lm1 <- lm(y1 ~ x1, data=anscombe)
summary(lm1)
lm2 <- lm(y2 ~ x2, data=anscombe)
summary(lm2)
lm3 <- lm(y3 ~ x3, data=anscombe)
summary(lm3)
lm4 <- lm(y4 ~ x4, data=anscombe)
summary(lm4)
plot(anscombe$x1,anscombe$y1)
abline(coefficients(lm1))
plot(anscombe$x2,anscombe$y2)
abline(coefficients(lm2))
plot(anscombe$x3,anscombe$y3)
abline(coefficients(lm3))
plot(anscombe$x4,anscombe$y4)
abline(coefficients(lm4))


## Fancy version (per help file)

ff <- y ~ x
mods <- setNames(as.list(1:4), paste0("lm", 1:4))

# Plot using for loop
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  ## or   ff[[2]] <- as.name(paste0("y", i))
  ##      ff[[3]] <- as.name(paste0("x", i))
  mods[[i]] <- lmi <- lm(ff, data = anscombe)
  print(anova(lmi))
}

sapply(mods, coef)  # Note the use of this function
lapply(mods, function(fm) coef(summary(fm)))

# Preparing for the plots
op <- par(mfrow = c(2, 2), mar = 0.1+c(4,4,1,1), oma =  c(0, 0, 2, 0))

# Plot charts using for loop
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  plot(ff, data = anscombe, col = "red", pch = 21, bg = "orange", cex = 1.2,
       xlim = c(3, 19), ylim = c(3, 13))
  abline(mods[[i]], col = "blue")
}
mtext("Anscombe's 4 Regression data sets", outer = TRUE, cex = 1.5)
par(op)

# Four plots on one page: 2 rows, 2 columns.
par(mfrow = c(2, 2))

# Set 1: blue circles, solid line.
plot(anscombe$x1, anscombe$y1, col = "blue", pch = 16,
     xlim = c(3, 19), ylim = c(3, 13), xlab = "x1", ylab = "y1")
abline(lm1, col = "gray40", lty = 1, lwd = 2)

# Set 2: green triangles, dashed line.
plot(anscombe$x2, anscombe$y2, col = "forestgreen", pch = 17,
     xlim = c(3, 19), ylim = c(3, 13), xlab = "x2", ylab = "y2")
abline(lm2, col = "gray40", lty = 2, lwd = 2)

# Set 3: yellow squares, dotted line.
plot(anscombe$x3, anscombe$y3, col = "gold", pch = 15,
     xlim = c(3, 19), ylim = c(3, 13), xlab = "x3", ylab = "y3")
abline(lm3, col = "gray40", lty = 3, lwd = 2)

# Set 4: red diamonds, dot-dash line.
plot(anscombe$x4, anscombe$y4, col = "red", pch = 18,
     xlim = c(3, 19), ylim = c(3, 13), xlab = "x4", ylab = "y4")
abline(lm4, col = "gray40", lty = 4, lwd = 2)

# Back to one plot per page.
par(mfrow = c(1, 1))