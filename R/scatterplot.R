#' Create a two-dimensional scatterplot based on the colours of the image

#'
#' Creates a simple scatterplot using the colours selected from the image,
#' plotting two features from a dataset of the users choosing.
#'
#' @param img_url URL of an image file
#' @param dataset data.frame or tibble
#' @param x unquoted column name to plot on the x-axis from data data.frame or tibble
#' @param y unquoted column name to plot on the y-axis from data data.frame or tibble
#' @param colour unquoted column name to plot as the colour from data data.frame or tibble
#' @param threshold threshold minimum share of all pixels; between 0 and 1
#'
#' @return A geom_point ggplot
#' @export
#'
#' @examples scatterplot(
#'   "https://i.imgur.com/s9egWBB.jpg",
#'   palmerpenguins::penguins,
#'   bill_length_mm, body_mass_g, species, 0
#' )
scatterplot <- function(img_url, dataset, x, y, colour, threshold = 0) {
  if (!startsWith(img_url, "https://")) {
    stop("'img_url' must be a link (not a path).")
  }
  if (!is.numeric(threshold)) {
    stop("'tolerence' must be a numeric value.")
  }

  if (!stringr::str_detect(tolower(img_url), ".jpg|.jpeg|.png|.svg")) {
    stop("'img_url' must be a direct link to an image file")
  }

  if (!dplyr::between(threshold, 0, 1)) {
    stop("'threshold' must be between 0 and 1.")
  }

  # Get colour palatte based on number of colours in dataset
  colour_palatte <- get_color_palette(
    img_url,
    threshold,
    dplyr::n_distinct(dplyr::select(dataset, {{ colour }}))
  )

  # Build scatterplot based off of image colour palatte and dataset
  scatter <- ggplot2::ggplot(
    data = dataset,
    ggplot2::aes(
      x = {{ x }},
      y = {{ y }},
      color = {{ colour }}
    )
  ) +
    ggplot2::scale_color_manual(values = colour_palatte$hex) +
    ggplot2::geom_point()
}
