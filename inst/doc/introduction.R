## ----basic, warning=FALSE, message=FALSE---------------------------------
library(colorblindr)

p <- ggplot(iris, aes(Sepal.Width, fill=Species)) +
  geom_density(alpha = 0.7)

cvd_grid(p)

## ------------------------------------------------------------------------
cvd_grid(p, sev = 0.5)

## ----eval=FALSE----------------------------------------------------------
#  view_cvd(p)

## ----echo=FALSE, out.width=800-------------------------------------------
knitr::include_graphics("shiny_screenshot_view_cvd.PNG")

## ----fig.height=3, warning = FALSE, message = FALSE----------------------
library(cowplot) #For plot_grid

swatch <- ggplot(data= data.frame(color_id = c(1,2,3,4,5,6,7, 8)), aes(x=color_id, y=1, value=color_id, fill=as.character(color_id))) +
      geom_tile() +
      geom_text(aes(label=color_id), color="white", size=5) +
      theme_nothing() +
      theme(legend.position = "none")

okabe_ito <- swatch + scale_fill_OkabeIto()
with_black <- swatch + scale_fill_OkabeIto(use_black = TRUE) 
darker <- swatch + scale_fill_OkabeIto(darken = 0.4)
lighter <- swatch + scale_fill_OkabeIto(darken = -0.2)

plot_grid(okabe_ito, with_black, darker, lighter, ncol = 1)

## ----fig.height=3, warning = FALSE, message = FALSE----------------------
p2 <- p + scale_fill_OkabeIto()
p3 <- p + scale_fill_OkabeIto(order = c(6, 4, 2))
plot_grid(p2, p3, nrow = 1)

## ----fig.height = 3------------------------------------------------------
p2 <- edit_colors(p, tritan, sev=0.8)
plot_grid(p, p2)

## ------------------------------------------------------------------------
p2 <- edit_colors(p, desaturate, amount = .3)
p3 <- edit_colors(p, desaturate, amount = .6)
p4 <- edit_colors(p, desaturate, amount = 1)

plot_grid(p, p2, p3, p4)

## ----fig.height = 3------------------------------------------------------

to_white <- function(c) {"#FFFFFF"} # convert everything to white
to_black <- function(c) {"#000000"} # convert everything to black

p2 <- edit_colors(p, colfun = to_white, fillfun = to_black)
p3 <- edit_colors(p, colfun = to_black, fillfun = to_white)

plot_grid(p2,p3, nrow=1)

## ----fig.height = 3, message = FALSE, warning = FALSE--------------------
library(magick)
p <- ggdraw() + draw_image("HSV-color-wheel.png") # turn png into ggplot object
p2 <- edit_colors(p, deutan, severity = .3)
p3 <- edit_colors(p, deutan, severity = .7)
p4 <- edit_colors(p, deutan, severity = 1)

plot_grid(p, p2, p3, p4, nrow=1)

## ------------------------------------------------------------------------

p <- ggdraw() + draw_image("FluorescentCells.jpg") # turn jpg into ggplot object

to_red <- function(c){simulate_cvd(c, matrix(c(
    1, 0, 0,
    0,  0,  0,
    0,  0, 0 )
 ,3,3,byrow=TRUE))}

to_green <- function(c){simulate_cvd(c, matrix(c(
    0, 0, 0,
    0,  1,  0,
    0,  0, 0 )
 ,3,3,byrow=TRUE))} 

to_blue <- function(c){simulate_cvd(c, matrix(c(
    0, 0, 0,
    0,  0,  0,
    0,  0, 1 )
 ,3,3,byrow=TRUE))} 

p2 <-  edit_colors(p, to_red )
p3 <-  edit_colors(p, to_green )
p4 <-  edit_colors(p, to_blue )
plot_grid(p,p2,p3,p4)


