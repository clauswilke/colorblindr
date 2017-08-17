#' Create a grid of different color-deficiency simulations of a plot
#'
#' @param plot The plot to modify
#' @param severity The severity of the simulation, applied equally to all four cases
#' @examples
#' cvd_grid(palette_plot(palette_OkabeIto, color_labels = FALSE))
#' @export
cvd_grid <- function(plot, severity = 1)
{
  deut <- function(c) simulate_cvd(c, deutan_transform(severity))
  p1 <- edit_colors(plot, deut)

  prot <- function(c) simulate_cvd(c, protan_transform(severity))
  p2 <- edit_colors(plot, prot)

  trit <- function(c) simulate_cvd(c, tritan_transform(severity))
  p3 <- edit_colors(plot, trit)

  des <- function(c) desaturate(c, severity)
  p4 <- edit_colors(plot, des)

  cowplot::plot_grid(p1, p2, p3, p4, scale = 0.9) +
    cowplot::draw_text("Deutanomaly", x = 0.01, y = .99, hjust = 0, vjust = 1, size = 12, fontface = "bold") +
    cowplot::draw_text("Protanomaly", x = 0.51, y = .99, hjust = 0, vjust = 1, size = 12, fontface = "bold") +
    cowplot::draw_text("Tritanomaly", x = 0.01, y = 0.49, hjust = 0, vjust = 1, size = 12, fontface = "bold") +
    cowplot::draw_text("Desaturated", x = 0.51, y = 0.49, hjust = 0, vjust = 1, size = 12, fontface = "bold")
}
