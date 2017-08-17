
<!-- README.md is generated from README.Rmd. Please edit that file -->
colorblindr
===========

[![Build Status](https://travis-ci.org/clauswilke/colorblindr.svg?branch=master)](https://travis-ci.org/clauswilke/colorblindr) [![Coverage Status](https://img.shields.io/codecov/c/github/clauswilke/colorblindr/master.svg)](https://codecov.io/github/clauswilke/colorblindr?branch=master)

Simulate colorblindness in production-ready R figures. Written by Claire D. McWhite and Claus O. Wilke.

Installation
============

This package depends on the development version of **cowplot** and on a patched version of **colorspace**. Please install those packages first:

    devtools::install_github("wilkelab/cowplot")
    devtools::install_github("clauswilke/colorspace")

Then install **colorblindr**:

    devtools::install_github("clauswilke/colorblindr")

Quick start
===========

Make a figure:

``` r
library(ggplot2)
fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
fig
```

![](man/figures/README-iris-figure-1.png)

Now look at it in various color-vision deficiency simulations:

``` r
library(colorblindr)
cvd_grid(fig)
```

![](man/figures/README-iris-cvd-grid-1.png)

Then inspect it in the interactive app:

``` r
view_cvd(p) # starts the interactive app
```
