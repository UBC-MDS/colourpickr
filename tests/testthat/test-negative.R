# Test negative
url <- "https://i.imgur.com/s9egWBB.jpg"
# Example
example <- dplyr::tibble(red = c(148, 171, 115, 246, 202),
                         green = c(96, 151, 78, 237, 201),
                         blue = c(74, 118, 72, 242, 197),
                         hex = c("#94604A", "#AB9776", "#734E48", "#F6EDF2", "#CAC9C5"))

test_that("negative() throws an error when expected", {
  expect_error(negative(url, 'a'))
  expect_error(negative(url, -10))
  expect_error(negative("image.png", 5))
})

test_that("negative() produces accurate output", {
  expect_true(tibble::is_tibble(negative(url, 5)))
  expect_identical(colnames(negative(url, 5)), c("red", "green", "blue", "hex"))
  expect_identical(negative(url, 5), example)
})

test_that("negative() inverts the colours correctly", {
  test_colour <- negative(url, 1)
  expect_false(any(test_colour$red == 107))
  expect_false(any(test_colour$green == 159))
  expect_false(any(test_colour$blue == 181))
  expect_false(any(test_colour$hex == "#6B9FB5"))
})
