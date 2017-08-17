#' Visualize a color palette as swatches of colors, possibly with labels printed on top
#'
#' @param colors Vector of color names or hex codes
#' @param label_size Size of the color labels to be printed
#' @param color_labels Individual bool or vector of bools indicating for which colors the
#'   color names should be printed on top of the color swatch.
#' @examples
#' palette_plot(palette_OkabeIto)
#' palette_plot(c("red", "green", "yellow", "magenta"), color_labels = FALSE)
#' @export
palette_plot <- function(colors, label_size = 6, color_labels = TRUE)
{

  if (length(color_labels)==1)
    color_labels <- rep_len(color_labels, length(colors))


  # find light and dark colors by converting to Lab space
  cols <- t(col2rgb(colors))
  m <- convertColor(cols, from = "sRGB", to = "Lab", scale.in = 255)
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

  ggplot2::ggplot() +
    ggplot2::geom_rect(data=tiles, ggplot2::aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=color)) +
    ggplot2::scale_fill_manual(values=colors) +
    ggplot2::geom_text(data=tiles[tiles$light & color_labels,], ggplot2::aes(x, y, label=color), color="black", size=label_size) +
    ggplot2::geom_text(data=tiles[!tiles$light & color_labels,], ggplot2::aes(x, y, label=color), color="white", size=label_size) +
    cowplot::theme_nothing() + ggplot2::theme(legend.position = "none")
}
