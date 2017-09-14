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
    cowplot::theme_nothing()
}


#' Generate a set of color swatches to be colored via ggplot2's `scale_fill_*` mechanism
#'
#' This function is similar to [palette_plot], with two main differences: First, unlike
#' [palette_plot], `gg_color_swatches` cannot label the colors with their hex code. Second, the colors don't
#' need to be provided as an argument, the resulting plot can be directly styled by adding
#' a `scale_fill_*` expression. Thus, this function is particularly useful to visualize
#' existing ggplot2 color scales.
#' @param n Number of color swatches to generate
#' @param xmargin Fraction of each swatch to be used as margin in the x direction
#' @param ymargin Fraction of each swatch to be used as margin in the y direction
#' @param title Optional title to print above the color swatches. Can also be provided via [ggtitle].
#' @param title_size Font size of the title
#' @param title_face Font face of the title
#' @param plot_margin Margin around the plot, specified via the ggplot2 function [margin]
#' @examples
#' gg_color_swatches(8) + scale_fill_OkabeIto()
#' gg_color_swatches(10) + ggtitle("Default ggplot2 discrete color scale")
#' @importFrom ggplot2 ggplot aes geom_rect theme element_text scale_x_continuous scale_y_continuous ggtitle margin
#' @export
gg_color_swatches <- function(n, xmargin = 0.2, ymargin = 0,
                              title = NULL, title_size = 14, title_face = "plain",
                              plot_margin = margin(title_size/2, title_size/2, title_size/2, title_size/2))
{
  tiles <- data.frame(xmin=(0:(n-1)+xmargin/2)/n,
                      xmax=((1:n)-xmargin/2)/n,
                      ymin=rep(0, n)+ymargin/2,
                      ymax=rep(1, n)-ymargin/2,
                      fill=factor(1:n))

  # code to appease CRAN check
  xmax <- xmin <- ymax <- ymin <- fill <- NULL

  ggplot() +
    geom_rect(data=tiles, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=fill)) +
    scale_x_continuous(limits = c(xmargin/(2*n), 1-xmargin/(2*n)), expand = c(0, 0)) +
    scale_y_continuous(limits = c(0, 1), expand = c(0, 0)) +
    ggtitle(title) +
    cowplot::theme_nothing() +
    theme(plot.margin = plot_margin,
          plot.title = element_text(face = title_face,
                                    size = title_size,
                                    margin = margin(b = title_size/2),
                                    hjust = 0, vjust = 0.5))
}
