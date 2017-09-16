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

#' Okabe-Ito color scale
#'
#' This is a color-blind friendly, qualitative scale with eight different colors. See [palette_OkabeIto] for details.
#' @param use_black If `TRUE`, scale includes black, otherwise includes gray.
#' @param order Numeric vector listing the order in which the colors should be used. Default is 1:8.
#' @param ... common discrete scale parameters: `name`, `breaks`, `labels`, `na.value`, `limits` and `guide`. See
#'  [discrete_scale] for more details.
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() + scale_color_OkabeIto()
#' ggplot(iris, aes(Sepal.Length, fill = Species)) +
#'   geom_density(alpha = 0.7) + scale_fill_OkabeIto(order = c(1, 3, 5))
#' @export
#' @usage NULL
scale_OkabeIto <- function(aesthetic, use_black = FALSE, order = 1:8, ...) {
  if (use_black) {
    values <- palette_OkabeIto_black[order]
  }
  else {
    values <- palette_OkabeIto[order]
  }
  pal <- function(n) {
    if (n > length(values)) {
      warning("Insufficient values in manual scale. ", n, " needed but only ",
           length(values), " provided.", call. = FALSE)
    }
    values
  }
  ggplot2::discrete_scale(aesthetic, "manual", pal, ...)
}
