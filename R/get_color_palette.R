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
#' color codes and RGB values
#'
#' @param img_url a character string representing the image URL
#' @param tolerance numeric tolerance level between 0 and 1 for color matching
#' @param limit the maximum number of colors to be returned
#' @param force_return_limit forcefully update tolerance until limit number of colors are extracted
#'
#' @return data.frame (tibble::tibble)
#' @export
#'
#' @examples
#' url <- "https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg"
#' get_color_palette(url, 0.001, 3, TRUE)
get_color_palette <- function(img_url, tolerance, limit, force_return_limit = FALSE) {
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

  # check if tolerance is between 0 and 1
  if (!is.numeric(tolerance) || tolerance < 0 || tolerance > 1) {
    return("Error: 'tolerance' must be a numeric value between 0 and 1.")
  }

  # Extract colors
  color_tib <- colorfindr::get_colors(img_url,
                                      top_n = limit,
                                      min_share = tolerance, exclude_col = "white", get_stats = TRUE
  )

  if (!force_return_limit) {
    if (nrow(color_tib) < limit) {
      return("Error: Tolerance too high. Can't return the
            requested numbers of colors with the given tolerence.
            The proportion of pixels for the most common colors
             are less than the specified threshold.")
    }
  } else {
    i <- 0
    while (nrow(color_tib) < limit && i < 10) {
      color_tib <- colorfindr::get_colors(
        img_url,
        top_n = limit, min_share = tolerance,
        exclude_col = "white", get_stats = TRUE
      )
      tolerance <- tolerance / 10
      i <- i + 1
    }
  }

  # Get HEX code column as vector
  hex <- color_tib |> dplyr::pull(col_hex)

  # get RGB codes from HEX codes
  rgb <- grDevices::col2rgb(hex)

  # transpose RGB matrix
  rgb <- t(rgb)

  hex_rgb <- tibble::as_tibble(rgb)

  hex_rgb$hex <- hex

  hex_rgb
}
