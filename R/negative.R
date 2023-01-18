#' Invert top n colours in an image file.
#'
# Colours are extracted from an image via URL and reversed,
#' (e.g. red becomes cyan, green becomes magenta, yellow becomes blue)
#' then stored in a table as HEX codes and RGB values.
#'
#' @import tidyverse
#' @import colorfindr
#'
#' @param img_url URL of an image file
#' @param num_colours number of colours to be extracted
#' @param threshold minimum share of all pixels; between 0 and 1
#'
#' @return data.frame (tibble::tibble)
#' @export
#'
#' @examples
#' url <- "https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg"
#' negative(url, 3, 0.2)
negative <- function(img_url, num_colours, threshold) {
}
