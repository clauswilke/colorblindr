#' Edit colors in existing plot or grid object
#'
#' @param grob The grid graphics object to edit.
#' @param colfun The function used to edit colors (`col` in `gpar` objects).
#' @param fillfun The function used to edit fill colors (`fill` in `gpar` objects).
#'   By default the same as `colfun`.
#' @examples
#' library(ggplot2)
#' p <- ggplot(iris, aes(Sepal.Width, fill=Species)) +
#'   geom_density(alpha = 0.7)
#' g <- ggplotGrob(p)
#'
#' g2 <- edit_colors(g, deutan)
#' g3 <- edit_colors(g, protan)
#' g4 <- edit_colors(g, tritan)
#' cowplot::plot_grid(g, g2, g3, g4)
#' @export
edit_colors <- function(grob, colfun = passthrough, fillfun = colfun)
{
  if (!is.null(grob$gp)) {
    if (!is.null(grob$gp$col)) {
      grob$gp$col <- colfun(grob$gp$col)
    }
    if (!is.null(grob$gp$fill)) {
      grob$gp$fill <- colfun(grob$gp$fill)
    }
  }

  if (!is.null(grob$grobs)) {
    grob$grobs <- lapply(grob$grobs, edit_colors, colfun, fillfun)
  }

  if (!is.null(grob$children)) {
    grob$children <- lapply(grob$children, edit_colors, colfun, fillfun)
  }

  grob
}
