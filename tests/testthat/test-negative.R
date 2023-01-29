# Test negative
url <- "https://i.imgur.com/s9egWBB.jpg"
example <- dplyr::tibble(
  red = c(255, 252, 243, 243, 254),
  green = c(243, 243, 240, 239, 250),
  blue = c(227, 228, 225, 227, 238),
  hex = c("#FFF3E3", "#FCF3E4", "#F3F0E1", "#F3EFE3", "#FEFAEE")
)

test_that("negative() throws an error when expected", {
  expect_error(negative(url, "a", 0.4))
  expect_error(negative(url, 5, "0.001"))
  expect_error(negative(url, 4, 8))
  expect_error(negative(url, 10, -3.9))
  expect_error(negative("image.png", 5, 0.001))
})

test_that("negative() produces accurate output", {
  expect_true(tibble::is_tibble(negative(url, 5)))
  expect_identical(colnames(negative(url, 5)), c("red", "green", "blue", "hex"))
  expect_identical(negative(url, 5), example)
})

test_that("negative() inverts the colours correctly", {
  test_colour <- negative(url, 1)
  expect_false(any(test_colour$red == 0))
  expect_false(any(test_colour$green == 1))
  expect_false(any(test_colour$blue == 0))
  expect_false(any(test_colour$hex == "#000100"))
})
