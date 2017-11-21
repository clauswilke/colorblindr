#' @rdname scale_OkabeIto
#' @export
#' @usage NULL
scale_colour_OkabeIto <- function(aesthetics = "colour", ...) {
  scale_OkabeIto(aesthetics, ...)
}

#' @rdname scale_OkabeIto
#' @export
#' @usage NULL
scale_color_OkabeIto <- scale_colour_OkabeIto

#' @rdname scale_OkabeIto
#' @export
#' @usage NULL
scale_fill_OkabeIto <- function(aesthetics = "fill", ...) {
  scale_OkabeIto(aesthetics, ...)
}

#' Okabe-Ito color scale
#'
#' This is a color-blind friendly, qualitative scale with eight different colors. See [palette_OkabeIto] for details.
#' @param use_black If `TRUE`, scale includes black, otherwise includes gray.
#' @param order Numeric vector listing the order in which the colors should be used. Default is 1:8.
#' @param darken Relative amount by which the scale should be darkened (for positive values) or lightened (for negatice
#'   values).
#' @param ... common discrete scale parameters: `name`, `breaks`, `labels`, `na.value`, `limits`, `guide`, and `aesthetics`.
#'  See [discrete_scale] for more details.
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() + scale_color_OkabeIto()
#' ggplot(iris, aes(Sepal.Length, fill = Species)) +
#'   geom_density(alpha = 0.7) + scale_fill_OkabeIto(order = c(1, 3, 5))
#' @export
#' @usage NULL
scale_OkabeIto <- function(aesthetics, use_black = FALSE, order = 1:8, darken = 0, ...) {
  if (use_black) {
    values <- palette_OkabeIto_black[order]
  }
  else {
    values <- palette_OkabeIto[order]
  }

  if (darken != 0) {
    values <- colorspace::darken(values, amount = darken)
  }

  pal <- function(n) {
    if (n > length(values)) {
      warning("Insufficient values in manual scale. ", n, " needed but only ",
           length(values), " provided.", call. = FALSE)
    }
    values
  }
  ggplot2::discrete_scale(aesthetics, "manual", pal, ...)
}
