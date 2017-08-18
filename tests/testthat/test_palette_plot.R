context('palette_plot.R')

test_that('basic functionality', {
  p <- palette_plot(palette_OkabeIto)
  df <- layer_data(p)

  # all colors make it into the first layer
  expect_equal(df$fill, palette_OkabeIto)

  # black labels
  df2 <- layer_data(p, 2L)
  expect_equal(as.character(df2$label), palette_OkabeIto[c(1, 2, 4)])

  # white labels
  df3 <- layer_data(p, 3L)
  expect_equal(as.character(df3$label), palette_OkabeIto[c(3, 5:8)])

  # label size can be changed
  p <- palette_plot(palette_OkabeIto, label_size = 4)
  df <- layer_data(p, 2L)
  df2 <- layer_data(p, 3L)
  expect_equal(unique(df$size), 4)
  expect_equal(unique(df2$size), 4)

  # labels can be switched off globally
  p <- palette_plot(palette_OkabeIto, color_labels = FALSE)
  expect_equal(layer_data(p, 2L), data.frame())

  # labels can be switched off selectively
  p <- palette_plot(palette_OkabeIto, color_labels = c(FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE))
  df <- layer_data(p)

  # all colors make it into the first layer
  expect_equal(df$fill, palette_OkabeIto)

  # black labels
  df2 <- layer_data(p, 2L)
  expect_equal(as.character(df2$label), palette_OkabeIto[c(2, 4)])

  # white labels
  df3 <- layer_data(p, 3L)
  expect_equal(as.character(df3$label), palette_OkabeIto[c(6, 8)])
})
