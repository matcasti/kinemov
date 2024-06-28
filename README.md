
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kinemov

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/kinemov)](https://CRAN.R-project.org/package=kinemov)
[![R-CMD-check](https://github.com/matcasti/kinemov/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/matcasti/kinemov/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/matcasti/kinemov/branch/master/graph/badge.svg)](https://app.codecov.io/gh/matcasti/kinemov?branch=master)
<!-- badges: end -->

The goal of kinemov is to provide a simple and easy to use interface to
visualize and analyze 2-dimensional motion capture data.

## Installation

You can install the development version of kinemov like so:

``` r
# install.packages("devtools")
devtools::install_github("matcasti/kinemov")
```

## Example

You can try using the example dataset `gait` this way:

``` r
plot_motion(gait, x_coord, y_coord, frame)
```
