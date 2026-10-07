## EPPS 6356 - Prepare for Class 5, item 4: deconstruct a plot
## Evandro M. S. Gomes
## Each line of the plot is one component of the grammar of graphics.

library(readxl)
library(ggplot2)

## Data: HPI 2026 data file, year 2025 (same file as Assignment 2).
## The columns get the names used in the course code.
hpi <- read_excel("Data/HPI_public_dataset.xlsx",
                  sheet = "1. All countries", skip = 8)
hpi <- hpi[, 1:12]
names(hpi) <- c("rank", "country", "iso", "blank", "continent", "population",
                "life_expectancy", "life_satisfaction", "footprint", "hpi",
                "threshold", "gdp_per_capita")
hpi <- hpi[!is.na(hpi$country) & !is.na(hpi$hpi), ]
hpi$continent <- factor(hpi$continent, levels = 1:8,
                        labels = c("Latin America", "N. America & Oceania",
                                   "Western Europe", "Middle East & N. Africa",
                                   "Sub-Saharan Africa", "South Asia",
                                   "E. Europe & Central Asia", "East Asia"))

## ---- Build the plot one layer at a time -----------------------------------

## 1. DATA + AESTHETICS: which table, and which variable goes on each axis.
##    Result: empty axes, no points yet.
p1 <- ggplot(hpi, aes(x = gdp_per_capita, y = life_expectancy))
p1

## 2. GEOM + AESTHETICS: draw points; size = population, colour = continent.
##    alpha = 0.6 is a fixed setting (transparency), not a mapping.
p2 <- p1 + geom_point(aes(size = population, colour = continent), alpha = 0.6)
p2

## 3. STAT: a smoother (loess) computed from the data and drawn as a line.
p3 <- p2 + geom_smooth(method = "loess", se = FALSE)
p3

## 4. SCALE: x axis on a log scale, labelled in dollars.
p4 <- p3 + scale_x_log10(labels = scales::label_dollar())
p4

## 5. LABELS: title, axis titles and caption.
p5 <- p4 + labs(title = "Richer countries live longer, up to a point",
                x = "GDP per capita (log scale)",
                y = "Life expectancy (years)",
                caption = "Source: Happy Planet Index")
p5

## 6. THEME: overall look (background, grid, fonts). Does not touch the data.
p6 <- p5 + theme_minimal()
p6

## ---- Change ONE component at a time ---------------------------------------

## COORDINATE SYSTEM: swap the axes.
p6 + coord_flip()

## FACETS: one small panel per continent.
p6 + facet_wrap(~ continent)

## SCALE (colour): a different palette for the same continents.
p6 + scale_colour_brewer(palette = "Dark2")

