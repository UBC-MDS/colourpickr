# Create test data frame
test_df <- dplyr::tibble(
  x = c(1.1, 1.3, 2.4, 1.5, 1.9, 2.1, 2.1, 0.9, 3.1),
  y = c(6.8, 7.2, 9.4, 8.3, 5.4, 9.6, 2.9, 6.6, 4.3),
  fill = c("A", "B", "C", "A", "B", "C", "A", "B", "C"))

# create test plot
test_plot <- scatterplot('https://i.imgur.com/s9egWBB.jpg',
                         test_df,
                         x,
                         y,
                         fill)

# test scatter for correct geom
test_that('Output plot should use geom_point', {
  expect_true("GeomPoint" %in% c(class(test_plot$layers[[1]]$geom)))
})

# test scatter for correct mappings
test_that('Output plot should use correct mappings for x, y and color', {
  expect_true("x"  == rlang::get_expr(test_plot$mapping$x))
  expect_true("y" == rlang::get_expr(test_plot$mapping$y))
  expect_true("fill" == rlang::get_expr(test_plot$mapping$colour))
})

# test scatter for correct labels
test_that('Output plot should use correct mappings for x, y and color', {
  expect_true("x"  == rlang::get_expr(test_plot$labels$x))
  expect_true("y" == rlang::get_expr(test_plot$labels$y))
  expect_true("fill" == rlang::get_expr(test_plot$labels$colour))
})

# scatter raises an error where expected
test_that("scatterplot() raises an error where expected", {
  expect_error(scatterplot("https://masterdatascience.ubc.ca/", test_df,
                           x,
                           y,
                           fill))
  expect_error(scatterplot('https://i.imgur.com/s9egWBB.jpg',
               test_df,
               x,
               y,
               fill,
               "15"))
}
)
