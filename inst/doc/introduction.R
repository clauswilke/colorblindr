## ----basic, warning=FALSE, message=FALSE---------------------------------
library(cowplot) # also loads ggplot2
library(colorspace) # for desaturate
library(colorblindr)

p <- ggplot(iris, aes(Sepal.Width, fill=Species)) +
  geom_density(alpha = 0.7)

p2 <- edit_colors(p, deutan, sev = 1)
p3 <- edit_colors(p, protan, sev = 1)
p4 <- edit_colors(p, tritan, sev = 1)
plot_grid(p, p2, p3, p4, labels = c("Original", "Deutan10", "Protan10", "Tritan10"))

## ------------------------------------------------------------------------


p <- ggplot(iris, aes(Sepal.Width, fill=Species)) +
  geom_density(alpha = 0.7)

p2 <- edit_colors(p, deutan, sev = .5)
p3 <- edit_colors(p, protan, sev = .5)
p4 <- edit_colors(p, tritan, sev = .5)
plot_grid(p, p2, p3, p4, labels = c("Original", "Deutan5", "Protan5", "Tritan5"))

## ------------------------------------------------------------------------
p2 <- p + scale_fill_OkabeIto()
plot_grid(p, p2)


## ------------------------------------------------------------------------

p2 <- edit_colors(p, desaturate, amount = .3)
p3 <- edit_colors(p, desaturate, amount = .6)
p4 <- edit_colors(p, desaturate, amount = 1)

plot_grid(p, p2, p3, p4)

## ------------------------------------------------------------------------

edit_colors(p, colfun = function(c) {"#111111"}, fillfun =  function(c){"#FFFFFF"})

to_white <- function(c) {"#FFFFFF"} # convert everything to white
to_black <- function(c) {"#000000"} # convert everything to black

p2 <- edit_colors(p, colfun = to_white, fillfun = to_black)
p3 <- edit_colors(p, colfun = to_black, fillfun = to_white)

plot_grid(p,p2,p3, nrow=1)

## ------------------------------------------------------------------------
library(magick)
p <- ggdraw() + draw_image("HSV-color-wheel.png") # turn png into ggplot object
p2 <- edit_colors(p, deutan, sev = .3)
p3 <- edit_colors(p, deutan, sev = .7)
p4 <- edit_colors(p, deutan, sev = 1)

plot_grid(p, p2, p3, p4, nrow=1)


