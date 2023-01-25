#' Invert top n colours in an image file.
#'
# Colours are extracted from an image via URL and reversed,
#' (e.g. red becomes cyan, green becomes magenta, yellow becomes blue)
#' then stored in a table as HEX codes and RGB values.
#'
#' @param img_url URL of an image file
#' @param num_colours number of colours to be extracted
#' @param threshold minimum share of all pixels; between 0 and 1; 0 by default
#'
#' @return data.frame (tibble::tibble)
#' @export
#'
#' @examples
#' url <- "https://masterdatascience.ubc.ca/sites/default/files/styles/banner_image_large/public/media-images/fos-datascience-healthineers_1440x512-fina-webl.jpg?itok=rBc6RLF6"
#' negative(url, 3, 0.001)
negative <- function(img_url, num_colours, threshold = 0) {
  # Image file must be a JPEG, PNG, TIFF, SVG or BMP
  if (!stringr::str_detect(tolower(img_url), "\\.jpg|\\.jpeg|\\.png|\\.bmp|\\.tif|\\.svg"))
    stop("File is not a BMP, JPEG, PNG, TIFF, or SVG.")

  if (!is.numeric(num_colours))
    stop("'num_colours' must be a numeric value.")

  if (!is.numeric(threshold))
    stop("'threshold' must be a numeric value.")

  if (!dplyr::between(threshold, 0, 1))
    stop("'threshold' must be between 0 and 1.")

  # Extract colours
  color_tib <- colorfindr::get_colors(img_url, top_n = num_colours, min_share = threshold, exclude_col = "white", get_stats = TRUE)

  if (dim(color_tib)[1] == 0)
    stop("Share of pixels of the most common colour is lower than the threshold; set a lower 'threshold' to extract.")

  # Convert HEX code tibble to vector
  hex <- dplyr::pull(color_tib, col_hex)

  # Extract RGB
  rgb <- col2rgb(hex)

  # Transpose RGB matrix
  rgb <- t(rgb)

  # Format as tibble instead of matrix
  hex_rgb <- tibble::as_tibble(rgb)

  # Add HEX codes
  hex_rgb$hex <- hex

  return(hex_rgb)
}
