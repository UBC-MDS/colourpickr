
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/UBC-MDS/colourpickr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/UBC-MDS/colourpickr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/UBC-MDS/colourpickr/branch/master/graph/badge.svg)](https://app.codecov.io/gh/UBC-MDS/colourpickr?branch=master)
[![pages-build-deployment](https://github.com/UBC-MDS/colourpickr/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/UBC-MDS/colourpickr/actions/workflows/pages/pages-build-deployment)
[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
<!-- badges: end -->

# colourpickr

A Python package that can be used to extract colours from images for use
in data visualization projects.

## Overview

This package allows users to integrate unique colour palettes into their
graphs for exploratory data analysis. The colours are retrieved from
image data (via URL) and are selected based on their overall prominence
in a picture. While there are existing tools that are used to process
images and create figures independently, we aim to combine both of their
functionalities to help programmers easily design effective and creative
visualizations.

## Where Our Package Fits

There does exist similar functions in R that provide similar
functionality to our package. packages are capable of colour extraction
and data visualization, but none exist that combine the two functions to
our knowledge. Some examples of such packages are as follows:

- [Magick](https://docs.ropensci.org/magick/articles/intro.html): This
  allows you to extract the colours of the image and the quantity of
  each colour in the image. However, this does not convert this into a
  colour palette, nor does this package have data visualization
  capabilities built in.

- [Colorfindr](https://github.com/zumbov2/colorfindr): This again,
  allows you to extract the colours of the image and the quantity of
  each colour in the image. However, this does not convert this into a
  colour palette, nor does this package have data visualization
  capabilities built in.

- [paletteR](https://github.com/AndreaCirilloAC/paletter): This package
  allows you to create a colour palette from an image. However, this
  image must be saved locally, not from a URL, and requires you to call
  GGPlot or anothe package to graph.

- [Imgpalr](https://github.com/leonawicz/imgpalr): This package allows
  you to create qualitative, sequential or divergent color palettes from
  an image. Again, this function does not have data visualization built
  in to it.

## Installation

You can install the development version of colourpickr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/colourpickr")
```

## Functions

`get_color_palette(img_url, limit)`: This function extracts the most
common colors from an image and returns them as a data frame of hex
color codes and RGB values. The user is provided with the ability to set
the number of colors that should be returned.

`donut(img_url, num_clrs, plot_show)`: This function creates a donut
chart with information on the most common colors in the linked image.
The user specifies the image, the number of colors, and specifies
whether to show the plot or not.

`scatterplot(url_img, dataset, x, y, colour)`: This function creates a
simple scatterplot using the colours selected from the image based on a
dataset of the users choosing.

`negative(img_url, num_colours)`: This function extracts the most common
n colours from an image (via URL) and inverts them to retrieve the
negative version of a colour palette, returning the associated HEX codes
and RGB values for each colour.

## Usage

After installing the package, please follow the below instructions :

    # Load packages
    library(colourpickr)

<br>

`get_color_palette`:

    get_color_palette("https://raw.githubusercontent.com/UBC-MDS/colourpycker/add_image/images/UBC_Aerial.jpg", 3)

<br>

`donut`:

    donut("https://i.imgur.com/s9egWBB.jpg", 3, FALSE)

<br>

`scatterplot`:

    plot <- scatterplot(
       "https://raw.githubusercontent.com/UBC-MDS/colourpycker/add_image/images/UBC_Aerial.jpg",
       palmerpenguins::penguins,
       bill_length_mm,
       body_mass_g,
       species
     )
    plot

<br>

`negative`:

    negative("https://raw.githubusercontent.com/UBC-MDS/colourpycker/add_image/images/UBC_Aerial.jpg", 3)

For a detailed list of examples and references, please visit
[here](https://ubc-mds.github.io/colourpickr/) for the full
documentation.

## Contributing

Interested in contributing? Check out the [contributing
guidelines](https://github.com/UBC-MDS/colourpickr/blob/master/.github/CONTRIBUTING.md).
Please note that this project is released with a [Code of
Conduct](https://github.com/UBC-MDS/colourpickr/blob/master/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

## License

`colourpickr` was created by Shaun Hutchinson, Arjun Radhakrishnan, Alex
Taciuk, and Lauren Zung. It is licensed under the terms of the GPLv3
license.
