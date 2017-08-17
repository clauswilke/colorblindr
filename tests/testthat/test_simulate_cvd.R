context('simulate_cvd.R')

test_that('convert a hex color', {
  sim <- simulate_cvd(c("#33ab20"), tritanomaly_cvd['6'][[1]])
  expect_equal(sim, "#2EA64C")
})


test_that('convert a built in color', {
  sim <- simulate_cvd("red", deutanomaly_cvd['8'][[1]])
  expect_equal(sim, "#6B3E00")
})

test_that('convert a mixed vector (hex and built in)', {
  sim <- simulate_cvd(c("green", "#ffc0cb"), protanomaly_cvd['8'][[1]])
  expect_equal(sim, c("#EBCD00", "#CEC7CB"))
})


test_that('white and blank unchanged', {
    sim <- simulate_cvd(c("white", "black"), deutanomaly_cvd['2'][[1]])
    expect_equal(sim, c("#FFFFFF", "#000000"))
})
