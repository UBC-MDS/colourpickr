url <- "https://masterdatascience.ubc.ca/sites/default/files/styles/banner_image_large/public/media-images/fos-datascience-healthineers_1440x512-fina-webl.jpg?itok=rBc6RLF6"

# Test negative
test_that("negative() throws an error when expected", {
  expect_error(negative(url, 'a', 0.4))
  expect_error(negative(url, 5, '0.001'))
  expect_error(negative(url, 4, 8))
  expect_error(negative(url, 10, -3.9))
})
