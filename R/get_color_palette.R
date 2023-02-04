#' Checks if a URL exists
#'
#' Check if the specified URL returns a valid response (status code 200)
#'
#' @param url URL
#'
#' @return True if exists
#' @export
#'
#' @examples
#' url_exists("https://www.google.com")
url_exists <- function(url) {
  tryCatch(
    {
      res <- httr::HEAD(url)
      return(httr::status_code(res) == 200)
    },
    error = function(e) {
      return(FALSE)
    }
  )
}


#' Gets the color palette of an image as a tibble
#'
#' Extracts the most common colors, configurable through parameters, from
#' an image specified as a URL and returns them as a data frame of hex
#' color codes and RGB values. Includes the share of each color in the image.
#'
#' @param img_url a character string representing the image URL
#' @param limit the maximum number of colors to be returned
#' @param force_return_limit forcefully update tolerance until limit number of colors are extracted
#'
#' @return data.frame (tibble::tibble)
#' @export
#'
#' @examples
#' url <- "https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg"
#' get_color_palette(url, 3, TRUE)
get_color_palette <- function(img_url, limit, force_return_limit = FALSE) {
  # check if image exists
  if (!url_exists(img_url)) {
    return("Error: The specified URL does not exist.")
  }

  # check if the url is valid
  if (!stringr::str_detect(
    img_url, "^https?://.*\\.(jpg|jpeg|png|bmp|tif|svg)$"
  )) {
    return("Error: The provided url is not a valid image URL.")
  }

  # check if limit is a positive integer
  if (!is.numeric(limit) || limit <= 0) {
    return("Error: 'limit' must be a positive integer.")
  }

  # Extract colors
  colors <- colorfindr::get_colors(img_url, exclude_col = "white", get_stats = TRUE)

  # Get the colour palette HEX codes by grouping colours into n clusters
  hex <- colorfindr::make_palette(colors, n = limit, show = FALSE)

  # get RGB codes from HEX codes
  rgb <- grDevices::col2rgb(hex)

  # transpose RGB matrix
  rgb <- t(rgb)

  hex_rgb <- tibble::as_tibble(rgb)

  hex_rgb$hex <- hex

  hex_rgb <- dplyr::left_join(hex_rgb, colors, by = c("hex" = "col_hex"))

  hex_rgb
}
