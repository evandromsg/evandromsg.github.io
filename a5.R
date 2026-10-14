windowsFonts(Garamond = windowsFont("Garamond"))

cores <- c("steelblue", "forestgreen", "firebrick")

fonte <- "Data source: Motor Trend (1974), R dataset mtcars."

meu_estilo <- function() {
  par(family = "Garamond", las = 1, bty = "l", mar = c(6, 5, 4, 2),
      col.main = "darkblue", col.lab = "gray30", col.axis = "gray30",
      cex.main = 1.3, lwd = 2)
}
op <- meu_estilo()
hist(mtcars$mpg, col = "steelblue", border = "white",
     main = "Fuel consumption of 32 cars",
     xlab = "Miles per gallon (mpg)", ylab = "Number of cars")
mtext(fonte, side = 1, line = 4.5, adj = 0, cex = 0.8, col = "gray40")
par(op)
op <- meu_estilo()
contagem <- table(mtcars$cyl)
barras <- barplot(contagem, col = cores, border = NA, ylim = c(0, 20),
                  main = "Cars by number of cylinders",
                  xlab = "Number of cylinders", ylab = "Number of cars")
text(barras, contagem, labels = contagem, pos = 3, col = "gray30")
legend("topleft", legend = c("4 cylinders", "6 cylinders", "8 cylinders"),
       fill = cores, border = NA, bty = "n")
mtext(fonte, side = 1, line = 4.5, adj = 0, cex = 0.8, col = "gray40")
par(op)
op <- meu_estilo()

contagem <- table(mtcars$cyl)
barras <- barplot(contagem, horiz = TRUE, col = cores, border = NA, xlim = c(0, 20),
                  main = "Cars by number of cylinders",
                  xlab = "Number of cars", ylab = "Number of cylinders")
text(contagem, barras, labels = contagem, pos = 4, col = "gray30")
legend("topright", legend = c("4 cylinders", "6 cylinders", "8 cylinders"),
       fill = cores, border = NA, bty = "n")
mtext(fonte, side = 1, line = 4.5, adj = 0, cex = 0.8, col = "gray40")
par(op)
op <- meu_estilo()
contagem <- table(mtcars$cyl)
rotulos <- paste0(round(100 * contagem / sum(contagem)), "%")
pie(contagem, labels = rotulos, col = cores, border = "white",
    main = "Share of cars by number of cylinders")
legend("topright", legend = c("4 cylinders", "6 cylinders", "8 cylinders"),
       fill = cores, border = NA, bty = "n")
mtext(fonte, side = 1, line = 4.5, adj = 0, cex = 0.8, col = "gray40")
par(op)

op <- meu_estilo()
boxplot(mpg ~ cyl, data = mtcars, col = cores, border = "gray30",
        main = "Fuel consumption by number of cylinders",
        xlab = "Number of cylinders", ylab = "Miles per gallon (mpg)")
abline(h = mean(mtcars$mpg), lty = 2, col = "gray40")
text(3, mean(mtcars$mpg) + 1, "Average of all cars", col = "gray40", cex = 0.8)
legend("topright", legend = c("4 cylinders", "6 cylinders", "8 cylinders"),
       fill = cores, border = NA, bty = "n")
mtext(fonte, side = 1, line = 4.5, adj = 0, cex = 0.8, col = "gray40")
par(op)

op <- meu_estilo()
grupo <- as.factor(mtcars$cyl)
plot(mtcars$wt, mtcars$mpg, col = cores[grupo], pch = c(16, 17, 15)[grupo], cex = 1.4,
     main = "Heavier cars use more fuel",
     xlab = "Weight (1,000 lbs)", ylab = "Miles per gallon (mpg)")
abline(lm(mpg ~ wt, data = mtcars), lty = 2, col = "gray40")
legend("topright", legend = c("4 cylinders", "6 cylinders", "8 cylinders"),
       col = cores, pch = c(16, 17, 15), bty = "n")
mtext(fonte, side = 1, line = 4.5, adj = 0, cex = 0.8, col = "gray40")
par(op)

grafico_base <- function() {
  op <- meu_estilo()
  grupo <- as.factor(mtcars$cyl)
  plot(mtcars$wt, mtcars$mpg, col = cores[grupo], pch = c(16, 17, 15)[grupo], cex = 1.4,
       main = "Heavier cars use more fuel",
       xlab = "Weight (1,000 lbs)", ylab = "Miles per gallon (mpg)")
  abline(lm(mpg ~ wt, data = mtcars), lty = 2, col = "gray40")
  legend("topright", legend = c("4 cylinders", "6 cylinders", "8 cylinders"),
         col = cores, pch = c(16, 17, 15), bty = "n")
  mtext(fonte, side = 1, line = 4.5, adj = 0, cex = 0.8, col = "gray40")
  par(op)
}

dir.create("a5_exports")

cairo_pdf("a5_exports/base.pdf", width = 6.5, height = 4); grafico_base(); dev.off()
svg("a5_exports/base.svg", width = 6.5, height = 4); grafico_base(); dev.off()
png("a5_exports/base.png", width = 6.5, height = 4, units = "in", res = 300); grafico_base(); dev.off()
jpeg("a5_exports/base.jpg", width = 6.5, height = 4, units = "in", res = 300); grafico_base(); dev.off()
tiff("a5_exports/base.tiff", width = 6.5, height = 4, units = "in", res = 300); grafico_base(); dev.off()
bmp("a5_exports/base.bmp", width = 6.5, height = 4, units = "in", res = 300); grafico_base(); dev.off()



reta <- lm(mpg ~ wt, data = mtcars)
nomes <- c("4 cylinders", "6 cylinders", "8 cylinders")

g <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(cyl), shape = factor(cyl))) +
  geom_point(size = 3) +
  geom_abline(intercept = coef(reta)[1], slope = coef(reta)[2],
              linetype = "dashed", colour = "gray40") +
  scale_colour_manual(values = cores, labels = nomes, name = NULL) +
  scale_shape_manual(values = c(16, 17, 15), labels = nomes, name = NULL) +
  labs(title = "Heavier cars use more fuel", x = "Weight (1,000 lbs)",
       y = "Miles per gallon (mpg)", caption = fonte) +
  theme_mine()

ggsave("a5_exports/gg.pdf", g, width = 6.5, height = 4, device = cairo_pdf)
ggsave("a5_exports/gg.svg", g, width = 6.5, height = 4, device = svg)
ggsave("a5_exports/gg.png", g, width = 6.5, height = 4, dpi = 300)
ggsave("a5_exports/gg.jpg", g, width = 6.5, height = 4, dpi = 300)
ggsave("a5_exports/gg.tiff", g, width = 6.5, height = 4, dpi = 300)
ggsave("a5_exports/gg.bmp", g, width = 6.5, height = 4, dpi = 300)



formato <- c("pdf", "svg", "png", "jpg", "tiff", "bmp")

tabela_formatos <- data.frame(
  Format = formato,
  Type = c("Vector", "Vector", "Raster", "Raster", "Raster", "Raster"),
  Base_KB = round(file.size(paste0("a5_exports/base.", formato)) / 1024, 1),
  ggplot2_KB = round(file.size(paste0("a5_exports/gg.", formato)) / 1024, 1),
  Compression = c("Lossless", "Lossless", "Lossless", "Lossy", "Lossless", "Lossless"),
  Transparency = c("Yes", "Yes", "Yes", "No", "Yes", "No"))

knitr::kable(tabela_formatos)