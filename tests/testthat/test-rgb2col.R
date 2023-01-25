# Test rgb2col
test_that("rgb2col() converts RGB code to HEX", {
  expect_error(rgb2col(c(12, 34, 54), 5))
})
