% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/donut.R
\name{donut}
\alias{donut}
\title{Create a donut chart of the top n colors in the image (number of colors specified by the user)}
\usage{
donut(img_url, num_clrs, img_size)
}
\arguments{
\item{img_url}{string of the url of the image that you want to pull colors from}

\item{num_clrs}{int of the number of colors you want to pull from the image}

\item{img_size}{int of the pixel width and height of the resulting chart. Note that it will return a square}
}
\value{
a ggplot donut chart of the n most common colors in the image (user specified)
}
\description{
Create a donut chart of the top n colors in the image (number of colors specified by the user)
}
\examples{
donut('https://visit.ubc.ca/wp-content/uploads/2019/04/plantrip_header-2800x1000_2x.jpg', 5, 400)
}