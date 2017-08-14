context('edit_colors')

test_that('basic editing', {
  g <- grid::circleGrob(r = .3, gp = grid::gpar(col = '#FF0000', fill = '#0000FF'))

  to_white <- function(c) {"#FFFFFF"} # convert everything to white
  g2 <- edit_colors(g, colfun = to_white)
  expect_equal(g2$gp$col, "#FFFFFF")
  expect_equal(g2$gp$fill, "#FFFFFF")
})

test_that('different color and fill functions', {
  g <- grid::circleGrob(r = .3, gp = grid::gpar(col = '#FF0000', fill = '#0000FF'))

  to_white <- function(c) {"#FFFFFF"} # convert everything to white
  to_black <- function(c) {"#000000"} # convert everything to black
  g2 <- edit_colors(g, colfun = to_white, fillfun = to_black)
  expect_equal(g2$gp$col, "#FFFFFF")
  expect_equal(g2$gp$fill, "#000000")
})

test_that('raster grobs', {
  colors = c("#FF0000", "#00FF00", "#0000FF", "#0F0F0F")
  g <- grid::rasterGrob(image = colors)
  g2 <- edit_colors(g, colorspace::desaturate)
  expect_equal(c(g2$raster), colorspace::desaturate(colors))
})


test_that('grob trees', {
  g <- grid::circleGrob(r = .3, gp = grid::gpar(col = '#FF0000', fill = '#0000FF'))
  gt <- grid::grobTree(g, g)

  to_white <- function(c) {"#FFFFFF"} # convert everything to white
  g2 <- edit_colors(gt, colfun = to_white)
  expect_equal(g2$children[[1]]$gp$col, "#FFFFFF")
  expect_equal(g2$children[[2]]$gp$fill, "#FFFFFF")
})
