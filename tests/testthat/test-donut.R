require(ggplot2)  # for first test

# Test 1
test_that("donut() should return a ggplot object",{
  expect_true(is.ggplot(donut("https://i.imgur.com/s9egWBB.jpg", 4)))
})

# Test 2
test_that("donut() should return the correct colors", {
  expect_equal(ggplot_build(donut("https://i.imgur.com/s9egWBB.jpg", 4))$data[[1]]["fill"]$fill,
               c("#6B9FB5", "#8AA59C", "#8B8A8F", "#647D9C"))
})

# Test 3
test_that("donut() should return the correct number of items", {
  expect_equal(nrow(ggplot_build(donut("https://i.imgur.com/s9egWBB.jpg", 4))$data[[1]]["fill"]), 4)
})
