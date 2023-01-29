test_that("get_color_palette returns error message for non-existent URL", {
  expect_equal(get_color_palette("http://nonexistentsjldjfkdl.com", 0.001, 3, TRUE), "Error: The specified URL does not exist.")
})

test_that("get_color_palette returns error message for url that is not an image", {
  expect_equal(get_color_palette("http://google.com", 0.001, 3, TRUE), "Error: The provided url is not a valid image URL.")
})

test_that("get_color_palette returns error message for negative limit", {
  expect_equal(get_color_palette("https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg", 0.001, -3, TRUE), "Error: 'limit' must be a positive integer.")
})

test_that("get_color_palette returns error message for tolerance outside of range", {
  expect_equal(get_color_palette("https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg", 1.1, 3, TRUE), "Error: 'tolerance' must be a numeric value between 0 and 1.")
})

test_that("get_color_palette returns a data frame when run with valid inputs", {
  expect_true(is.data.frame(get_color_palette("https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg", 0.001, 3, TRUE)))
})

test_that("get_color_palette returns error message for high tolerance when force_return_limit is false", {
  result <- get_color_palette("https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg", 1, 3, FALSE)
  expect_true(stringr::str_detect(result, "Error: Tolerance too high."))
  })






