#' Edit colors in existing plot or grid object
#'
#' The function `edit_colors()` can modify colors in existing ggplot2 plots, grid objects,
#' or R base plots provided as recorded plots.
#'
#' @param plot The plot or grid graphics object to edit. The function `edit_colors()` can
#'   accept any object that can be handled by [`cowplot::plot_to_gtable()`].
#' @param colfun The function used to edit colors (`col` in `gpar` objects).
#' @param fillfun The function used to edit fill colors (`fill` in `gpar` objects).
#'   By default the same as `colfun`.
#' @param ... Other parameters to be given to functions colfun and fillfun.
#' @examples
#' library(ggplot2)
#' library(colorspace) # for desaturate
#' p <- ggplot(iris, aes(Sepal.Width, fill=Species)) +
#'   geom_density(alpha = 0.7)
#'
#' p2 <- edit_colors(p, deutan)
#' p3 <- edit_colors(p, tritan, sev = 7)
#' p4 <- edit_colors(p, desaturate)
#' cowplot::plot_grid(p, p2, p3, p4)
#' @export
edit_colors <- function(plot, colfun = passthrough, fillfun = NULL, ...)
{
  # convert to grob if necessary
  if (!methods::is(plot, "grob")) {
    plot <- cowplot::plot_to_gtable(plot)
  }

  if (is.null(fillfun)) {
    fillfun = colfun
  }
  edit_grob_colors(plot, colfun, fillfun, ...)
}


#' The function `edit_grob_colors()` is identical to `edit_colors()` except it works only with objects of
#' class `grob` and doesn't check its input.
#'
#' @param grob The grid graphics object to edit.
#' @rdname edit_colors
#' @export
edit_grob_colors <- function(grob, colfun, fillfun, ...)
{
  if (!is.null(grob$gp)) {
    if (!is.null(grob$gp$col)) {
      grob$gp$col <- colfun(grob$gp$col, ...)
    }
    if (!is.null(grob$gp$fill)) {
      grob$gp$fill <- fillfun(grob$gp$fill, ...)
    }
  }

  if (!is.null(grob$grobs)) {
    grob$grobs <- lapply(grob$grobs, edit_grob_colors, colfun, fillfun, ...)
  }

  if (!is.null(grob$children)) {
    grob$children <- lapply(grob$children, edit_grob_colors, colfun, fillfun, ...)
  }

  if (methods::is(grob, "rastergrob")) {
    grob <- edit_rastergrob_colors(grob, colfun, ...)
  }

  grob
}


# internal function that can adjust rastergrobs
# important: it only changes the raster data, not
# any of the other gp data.
edit_rastergrob_colors <- function(grob, colfun, ...)
{
  rasternew <- colfun(c(grob$raster), ...)
  dim(rasternew) <- dim(grob$raster)
  class(rasternew) <- class(grob$raster)
  grid::editGrob(grob, raster = rasternew)
}

