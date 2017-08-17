#' @rdname scale_OkabeIto
#' @export
#' @usage NULL
scale_colour_OkabeIto <- function(...) {
  scale_OkabeIto("colour", ...)
}

#' @rdname scale_OkabeIto
#' @export
#' @usage NULL
scale_color_OkabeIto <- scale_colour_OkabeIto

#' @rdname scale_OkabeIto
#' @export
#' @usage NULL
scale_fill_OkabeIto <- function(...) {
  scale_OkabeIto("fill", ...)
}

#' Okabe Ito color scale
#'
#' See [palette_OkabeIto] for details on the color palette used.
#' @param use_black If `TRUE`, scale includes black, otherwise includes gray.
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() + scale_color_OkabeIto()
#' ggplot(iris, aes(Sepal.Length, fill = Species)) +
#'   geom_density(alpha = 0.7) + scale_fill_OkabeIto()
#' @export
#' @usage NULL
scale_OkabeIto <- function(aesthetic, use_black = FALSE, ...) {
  if (use_black) {
    values <- palette_OkabeIto_black
  }
  else {
    values <- palette_OkabeIto
  }
  pal <- function(n) {
    if (n > length(values)) {
      stop("Insufficient values in manual scale. ", n, " needed but only ",
           length(values), " provided.", call. = FALSE)
    }
    values
  }
  ggplot2::discrete_scale(aesthetic, "manual", pal, ...)
}
