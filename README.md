
<!-- README.md is generated from README.Rmd. Please edit that file -->
colorblindr
===========

[![Build Status](https://travis-ci.org/clauswilke/colorblindr.svg?branch=master)](https://travis-ci.org/clauswilke/colorblindr) [![Coverage Status](https://img.shields.io/codecov/c/github/clauswilke/colorblindr/master.svg)](https://codecov.io/github/clauswilke/colorblindr?branch=master)

Simulate colorblindness in production-ready R figures. Written by Claire D. McWhite and Claus O. Wilke.

This is an experimental package in early development. Don't expect anything to work.

Installation
============

This package depends on the development version of **cowplot** and on a patched version of **colorspace**. Please install those packages first:

    devtools::install_github("wilkelab/cowplot")
    devtools::install_github("clauswilke/colorspace")

Then install **colorblindr**:

    devtools::install_github("clauswilke/colorblindr")
