#' Create a donut chart of the top n colors in the image (number of colors specified by the user)
#'
#' @param img_url string of the url of the image that you want to pull colors from
#' @param num_clrs int of the number of colors you want to pull from the image
#' @param tolerance float of tolerance between 0 and 1 for color matching, default 0.001
#' @param plot_show if TRUE will print the plot, default TRUE
#'
#' @return a ggplot donut chart of the n most common colors in the image (user specified)
#' @export
#'
#' @examples
#' donut('https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg', 5, 0.001)
donut <- function(img_url, num_clrs, tolerance=0.001, plot_show=TRUE) {
  #download the dataframe of colors
  df <- get_color_palette(img_url, tolerance=tolerance, 100, TRUE)

  #select and rename the needed columns
  df <- df[c("hex", "col_share")] |>
    dplyr::rename(prop = col_share, colors = hex)

  #add the category column and truncate df to num_clrs
  df$category <- df$colors
  df <- head(df, num_clrs)
  df <- df |> dplyr::mutate(prop = prop/sum(df$prop))

  #code for the labels
  df$ymax = cumsum(df$prop)
  df$ymin = c(0, head(df$ymax, n = -1))
  df$labelPosition <- (df$ymax + df$ymin) / 2
  df$label <- paste0(df$category, ": \n", round(df$prop * 100, 1), "%")
  col <- as.character(df$colors)
  names(col) <- as.character(df$category)

  #create the ggplot object with labels
  donut_plot <- ggplot(df, aes(ymax = ymax, ymin = ymin, xmax = 3, xmin = 2, fill = colors)) +
    geom_rect() +
    geom_text(x = 4, aes(y = labelPosition, label = label, color = colors), size = 3, hjust = 0.5) + # x here controls label position (inner / outer)
    scale_fill_manual(values = col) +
    scale_color_manual(values = col) +
    coord_polar(theta = "y", clip = "off") +
    xlim(c(-1, 4)) +
    theme_void() +
    theme(legend.position = "none")

  #have option to not print the ggplot for testing
  if (plot_show){
    print(donut_plot)
  }
  return(donut_plot)
}
