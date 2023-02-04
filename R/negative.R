#' Invert top n colours in an image file.
#'
#' Colours are extracted from an image via URL and reversed,
#' (e.g. red becomes cyan, green becomes magenta, yellow becomes blue)
#' then stored in a table as HEX codes and RGB values.
#'
#' @param img_url URL of an image file
#' @param num_colours number of colours to be extracted
#'
#' @return data.frame (tibble::tibble)
#' @export
#'
#' @examples
#' url <- "https://i.imgur.com/s9egWBB.jpg"
#' negative(url, 3)
negative <- function(img_url, num_colours) {
  # Image file must be a JPEG, PNG, TIFF, SVG or BMP
  if (!stringr::str_detect(tolower(img_url), "\\.jpg|\\.jpeg|\\.png|\\.bmp|\\.tif|\\.svg")) {
    stop("File is not a BMP, JPEG, PNG, TIFF, or SVG.")
  }

  if (!is.numeric(num_colours) || num_colours <= 0) {
    stop("'num_colours' must be a positive numeric value.")
  }

  # Extract colours - exclude black since the inverse would be white
  colors <- colorfindr::get_colors(img_url, exclude_col = "black")

  # Get the colour palette HEX codes by grouping colours into n clusters
  hex <- colorfindr::make_palette(colors, n = num_colours, show = FALSE)

  # Extract inverted RGB codes from HEX codes
  rgb <- abs(255 - grDevices::col2rgb(hex))

  # Convert inverted RGB codes back to HEX code
  inverted_hex <- sapply(1:ncol(rgb), function(x) rgb2col(rgb, x))

  # Transpose RGB matrix
  rgb <- t(rgb)

  # Format as tibble instead of matrix
  hex_rgb <- tibble::as_tibble(rgb)

  # Add HEX codes
  hex_rgb$hex <- inverted_hex

  # Return final tibble
  hex_rgb
}


#' Converts a column of RGB values to a HEX code
#' Based on: https://stackoverflow.com/a/66810164
#'
#' @param mat matrix of RGB color codes
#' @param col index of column containing RGB values; row order is red, green, blue
#'
#' @return character vector of the HEX code
#' @export
#'
#' @examples
#' rgb2col(grDevices::col2rgb(c("#000C1C")))
rgb2col <- function(mat, col) {
  grDevices::rgb(mat[1, col],
    mat[2, col],
    mat[3, col],
    maxColorValue = 255
  )
}
