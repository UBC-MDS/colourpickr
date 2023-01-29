# Test rgb2col
white <- col2rgb('#FFFFFF')
colours <- col2rgb(c('#C429C4', '#29C44B', '#C4293E'))

example1 <- matrix(c(255, 255, 255), nrow = 3)
rownames(example1) <- c("red", "green", "blue")

example2 <- matrix(c(185, 40, 210), nrow = 3)
rownames(example2) <- c("red", "green", "blue")

test_that("rgb2col() throws an error when expected", {
  expect_error(rgb2col(c(12, 34, 54), 5))
  expect_error(rgb2col(123456, 6))
  expect_error(rgb2col(white, 2))
  expect_error(rgb2col(colours, 'red'))
})

test_that("rgb2col() converts RGB code to HEX", {
  expect_identical(rgb2col(example1), "#FFFFFF")
  expect_identical(rgb2col(example2), "#B928D2")
})
