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
#' @param tolerance threshold minimum share of all pixels; between 0 and 1
#'
#' @return A geom_point ggplot
#' @export
#'
#' @examples scatterplot('https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg', penguins, bill_length_mm, body_mass_g, species, 50)
scatterplot <- function(url, dataset, x, y, colour, tolerance) {

}
