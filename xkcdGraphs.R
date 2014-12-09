
##----------------------------------------------------------------------------
## Title: xkcd comic style plots
## Author: Armando Enriquez Z.
## Date: December 9th, 2014
## Purpose: Create plots in a xkcd style
##----------------------------------------------------------------------------


## R libraries required
## Probably you haven't got the packages yet: type "install.packages("package")"
library(xkcd)
library(ggplot2)
library(extrafont) ## Loading extra fonts
fonts()
loadfonts(device = "win")

## Let us make our first graphic
data(mtcars) ## the dataset (cars!)
head(mtcars)

names(mtcars)[1] <- "MPG"
names(mtcars)[6] <- "WT"

## A preparatory graphic! (to make sure we've the fonts)
ggplot() + geom_point(aes(x = MPG, y = WT), data = mtcars) +
        theme_xkcd()

xrange <- range(mtcars$MPG)
yrange <- range(mtcars$WT)

## The graphic itself
g <- ggplot() + geom_point(aes(x = MPG, y = WT), data = mtcars) + 
        labs(list(title = "CARS", x = "MILES PER GALLON", 
                  y = "WEIGHT IN POUNDS")) + 
        xkcdaxis(xrange, yrange)

## Printing in PDF
library(showtext)
library(sysfonts)

font.add("xkcd", "xkcd.ttf") ## Loading the fonts

## PDF device
pdf("xkcdGraphic4.pdf")
showtext.begin()
print(g)
showtext.end()
dev.off()

## Now a barchart
data <- data.frame(year = c(2007:2011),
                   number = c(470, 998, 686, 1783, 251))

data$xmin <- data$year - 0.1
data$xmax <- data$year + 0.1
data$ymin <- 0
data$ymax <- data$number

xrange <- range(min(data$xmin) - 0.1, max(data$xmax) + 0.1)
yrange <- range(min(data$ymin), max(data$ymax))

mapping <- aes(xmin = xmin, ymin = ymin, 
               xmax = xmax, ymax = ymax)

g2 <- ggplot() + xkcdrect(mapping, data) +
        xkcdaxis(xrange, yrange) +
        xlab("YEAR") + ylab("NUMBER OF WORKERS")


## PDF device
pdf("xkcdGraphic5.pdf")
showtext.begin()
print(g2)
showtext.end()
dev.off()

