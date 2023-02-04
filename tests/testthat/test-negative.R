# Test negative
url <- "https://masterdatascience.ubc.ca/sites/default/files/styles/banner_image_large/public/media-images/fos-datascience-healthineers_1440x512-fina-webl.jpg?itok=rBc6RLF6"
example <- dplyr::tibble(red = c(255, 251, 254, 86, 169),
                  green = c(243, 225, 185, 76, 165),
                  blue = c(227, 200, 156, 64, 156),
                  hex = c("#FFF3E3", "#FBE1C8", "#FEB99C", "#564C40", "#A9A59C"))

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
  expect_false(any(test_colour$red == 0))
  expect_false(any(test_colour$green == 1))
  expect_false(any(test_colour$blue == 0))
  expect_false(any(test_colour$hex == "#000100"))
})