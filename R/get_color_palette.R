#' Gets the color palette of an image
#'
#' Extracts the most common colors, configurable through parameters, from
#' an image specified as a URL and returns them as a data frame of hex
#' color codes and RGB values
#'
#' @param img_url a character string representing the image URL
#' @param tolerance numeric tolerance level between 0 and 1 for color matching
#' @param limit the maximum number of colors to be returned
#'
#' @return data.frame (tibble::tibble)
#' @export
#'
#' @examples
#' url <- "https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg"
#' get_color_palette(url, 20, 5)
get_color_palette <- function(img_url, tolerance, limit) {

}
