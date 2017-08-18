#' Visualize a color palette as swatches of colors, possibly with labels printed on top
#'
#' @param colors Vector of color names or hex codes
#' @param label_size Size of the color labels to be printed
#' @param color_labels Individual bool or vector of bools indicating for which colors the
#'   color names should be printed on top of the color swatch.
#' @examples
#' palette_plot(palette_OkabeIto)
#' palette_plot(c("red", "green", "yellow", "magenta"), color_labels = FALSE)
#' @importFrom ggplot2 ggplot aes geom_rect scale_fill_manual geom_text theme
#' @export
palette_plot <- function(colors, label_size = 6, color_labels = TRUE)
{

  if (length(color_labels)==1)
    color_labels <- rep_len(color_labels, length(colors))


  # find light and dark colors by converting to Lab space
  cols <- t(grDevices::col2rgb(colors))
  m <- grDevices::convertColor(cols, from = "sRGB", to = "Lab", scale.in = 255)
  light <- m[,1]>65

  # data frame of rectangles
  n <- length(colors)
  tiles <- data.frame(xmin=(0:(n-1)+.1)/n,
                      xmax=((1:n)-.1)/n,
                      x=(0:(n-1)+.5)/n,
                      ymin=rep(0, n),
                      ymax=rep(1, n),
                      y=rep(0.5, n),
                      color=factor(colors, levels=colors),
                      light=light)

  # code to appease CRAN check
  x <- xmax <- xmin <- y <- ymax <- ymin <- color <- NULL

  ggplot() +
    geom_rect(data=tiles, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=color)) +
    scale_fill_manual(values=colors) +
    geom_text(data=tiles[tiles$light & color_labels,], aes(x, y, label=color), color="black", size=label_size) +
    geom_text(data=tiles[!tiles$light & color_labels,], aes(x, y, label=color), color="white", size=label_size) +
    cowplot::theme_nothing() + theme(legend.position = "none")
}
