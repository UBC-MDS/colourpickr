test_that("url_exists function returns TRUE for valid URL", {
  expect_true(url_exists("https://www.google.com"))
})

test_that("url_exists function returns FALSE for invalid URL", {
  expect_false(url_exists("https://invalid_sdksndkj.url"))
})
