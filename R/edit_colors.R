#' Edit colors in existing plot or grid object
#'
#' @param colfun The function used to edit colors (`col` in `gpar` objects).
#' @param fillfun The function used to edit fill colors (`fill` in `gpar` objects).
#'   By default the same as `colfun`.
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
    grob$grobs <- lapply(grob$grobs, modify_color, colfun, fillfun)
  }

  if (!is.null(grob$children)) {
    grob$children <- lapply(grob$children, modify_color, colfun, fillfun)
  }

  grob
}
