
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
library(kinemov)

plot_motion(gait, x_coord, y_coord, frame) 
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

You can also plot the degrees between joints in this way:

``` r
fig <- plot_degrees(gait, x_coord, y_coord, joint, frame)
fig
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

As it is a ggplot object, you can further customize the output object:

``` r
library(ggplot2)
library(scales)

fig + 
  labs(title = "Gait Arthrokinematics",
       subtitle = "Assessed through manual motion capture with ImageJ",
       caption = "Source: Own elaboration") +
  scale_color_viridis_c(option = "C") + 
  scale_x_continuous(labels = label_percent()) + 
  theme(plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = "black"),
        strip.background = element_rect(fill = "black"),
        legend.background = element_rect(fill = "black"),
        panel.grid = element_blank(),
        text = element_text(colour = "white"),
        axis.text = element_text(colour = "white"))
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

And from the `plot_degrees()` function, you can also only extract the
degrees by specifying `plot = FALSE`:

``` r
out <- plot_degrees(gait, x_coord, y_coord, joint, frame, plot = FALSE)

subset(out, !is.na(angle)) |> head()
#>    joint frame x_coord y_coord    angle
#> 29     2     1   123.0   340.0 125.0958
#> 30     2     2   123.0   339.0 133.8656
#> 31     2     3   122.5   338.0 136.2633
#> 32     2     4   123.5   337.0 126.2360
#> 33     2     5   123.5   337.5 121.2637
#> 34     2     6   124.0   336.0 119.3529
```

One can further process the output data.frame to better describe the
angles for each joint and for each frame:

``` r
library(data.table)

out <- as.data.table(out)
out[i = !is.na(angle), 
    j = list(min = min(angle), 
             mean = mean(angle),
             median = median(angle),
             max = max(angle)) |> 
      lapply(round),
    by = joint]
#>    joint   min  mean median   max
#>    <int> <num> <num>  <num> <num>
#> 1:     2   119   130    129   144
#> 2:     3    15    39     38    56
#> 3:     4     6    28     19    74
#> 4:     5     1    18     17    40
```
