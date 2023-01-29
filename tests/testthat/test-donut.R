require(ggplot2)  # for first test

# Test 1
test_that("donut() should return a ggplot object",{
  expect_true(is.ggplot(donut("https://i.imgur.com/s9egWBB.jpg", 4, 0.001, FALSE)))
})

# Test 2
test_that("donut() should return the correct colors", {
  expect_equal(ggplot_build(donut("https://i.imgur.com/s9egWBB.jpg", 4, 0.001, FALSE))$data[[1]]["fill"]$fill,
               get_color_palette("https://i.imgur.com/s9egWBB.jpg", 0.001, 4, TRUE)$hex)
})

# Test 3
test_that("donut() should return the correct number of items", {
  expect_equal(nrow(ggplot_build(donut("https://i.imgur.com/s9egWBB.jpg", 4, 0.001, FALSE))$data[[1]]["fill"]), 4)
})
