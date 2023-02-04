#' Create a donut chart of the top n colors in the image (number of colors specified by the user)
#'
#' @param img_url string of the url of the image that you want to pull colors from
#' @param num_clrs int of the number of colors you want to pull from the image
#' @param plot_show if TRUE will print the plot, default TRUE
#'
#' @return a ggplot donut chart of the n most common colors in the image (user specified)
#' @export
#'
#' @examples
#' donut("https://i.imgur.com/s9egWBB.jpg", 5)
donut <- function(img_url, num_clrs, plot_show = TRUE) {
  # download the dataframe of colors
  df <- get_color_palette(img_url, 100, TRUE)

  # select and rename the needed columns
  df <- df[c("hex", "col_share")] |>
    dplyr::rename(prop = col_share, colors = hex)

  # add the category column and truncate df to num_clrs
  df$category <- df$colors
  df <- head(df, num_clrs)
  df <- df |> dplyr::mutate(prop = prop / sum(df$prop))

  # code for the labels
  df$ymax <- cumsum(df$prop)
  df$ymin <- c(0, head(df$ymax, n = -1))
  df$labelPosition <- (df$ymax + df$ymin) / 2
  df$label <- paste0(df$category, ": \n", round(df$prop * 100, 1), "%")
  col <- as.character(df$colors)
  names(col) <- as.character(df$category)

  # create the ggplot object with labels
  donut_plot <- ggplot2::ggplot(df, ggplot2::aes(ymax = ymax, ymin = ymin, xmax = 3, xmin = 2, fill = colors)) +
    ggplot2::geom_rect() +
    ggplot2::geom_text(x = 4, ggplot2::aes(y = labelPosition, label = label, color = colors), size = 3, hjust = 0.5) + # x here controls label position (inner / outer)
    ggplot2::scale_fill_manual(values = col) +
    ggplot2::scale_color_manual(values = col) +
    ggplot2::coord_polar(theta = "y", clip = "off") +
    ggplot2::xlim(c(-1, 4)) +
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "none")

  # have option to not print the ggplot for testing
  if (plot_show) {
    print(donut_plot)
  }
  return(donut_plot)
}
