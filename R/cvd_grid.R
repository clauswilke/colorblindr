#' Create a grid of different color-deficiency simulations of a plot
#'
#' @param plot The plot to modify
#' @param severity The severity of the simulation, applied equally to all four cases
#' @examples
#' cvd_grid(palette_plot(palette_OkabeIto, color_labels = FALSE))
#' @importFrom colorspace deutan protan tritan desaturate
#' @export
cvd_grid <- function(plot, severity = 1)
{
  deut <- function(c) deutan(c, severity)
  p1 <- edit_colors(plot, deut)

  prot <- function(c) protan(c, severity)
  p2 <- edit_colors(plot, prot)

  trit <- function(c) tritan(c, severity)
  p3 <- edit_colors(plot, trit)

  des <- function(c) desaturate(c, severity)
  p4 <- edit_colors(plot, des)

  cowplot::plot_grid(p1, p2, p3, p4, scale = 0.9, hjust = 0, vjust = 1,
                     labels = c("Deutanomaly", "Protanomaly", "Tritanomaly", "Desaturated"),
                     label_x = 0.01, label_y = 0.99, label_size = 12, label_fontface = "bold")
}
