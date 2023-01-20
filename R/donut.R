#' Create a donut chart of the top n colors in the image (number of colors specified by the user)
#'
#' @param img_url string of the url of the image that you want to pull colors from
#' @param num_clrs int of the number of colors you want to pull from the image
#' @param img_size int of the pixel width and height of the resulting chart. Note that it will return a square
#'
#' @return a ggplot donut chart of the n most common colors in the image (user specified)
#' @export
#'
#' @examples
#' donut('https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg', 5, 400)
donut <- function(img_url, num_clrs, img_size) {
}
