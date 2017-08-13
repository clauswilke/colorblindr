
context('utils')

test_that('passthrough works', {
  expect_equal(passthrough(1:10), 1:10)
  expect_equal(passthrough(c("red", "green", "blue")), c("red", "green", "blue"))
  expect_equal(passthrough(3.1415), 3.1415)
})
