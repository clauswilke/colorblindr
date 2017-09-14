## ----echo=FALSE, message=FALSE-------------------------------------------
knitr::opts_chunk$set(
  echo = FALSE,
  message = FALSE,
  warning = FALSE,
  fig.align = 'left',
  fig.width = 8,
  fig.asp = 0.15
)
library(ggplot2)
library(colorblindr)

## ------------------------------------------------------------------------
gg_color_swatches(title="ggplot2 default discrete")
gg_color_swatches(title="colorblindr Okabe-Ito") + scale_fill_OkabeIto()
gg_color_swatches(title="colorblindr Okabe-Ito w/ black") + scale_fill_OkabeIto(use_black = TRUE)

## ------------------------------------------------------------------------
gg_color_swatches(title="colorbrewer qualitative: Accent") + scale_fill_brewer(type="qual", palette="Accent")
gg_color_swatches(title="colorbrewer qualitative: Dark2") + scale_fill_brewer(type="qual", palette="Dark2")
gg_color_swatches(title="colorbrewer qualitative: Paired") + scale_fill_brewer(type="qual", palette="Paired")
gg_color_swatches(title="colorbrewer qualitative: Pastel1") + scale_fill_brewer(type="qual", palette="Pastel1")
gg_color_swatches(title="colorbrewer qualitative: Pastel2") + scale_fill_brewer(type="qual", palette="Pastel2")
gg_color_swatches(title="colorbrewer qualitative: Set1") + scale_fill_brewer(type="qual", palette="Set1")
gg_color_swatches(title="colorbrewer qualitative: Set2") + scale_fill_brewer(type="qual", palette="Set2")
gg_color_swatches(title="colorbrewer qualitative: Set3") + scale_fill_brewer(type="qual", palette="Set3")

## ------------------------------------------------------------------------
gg_color_gradient(title="ggplot2 default continuous")
gg_color_swatches(title="ggplot2 discrete gray") + scale_fill_grey()

## ------------------------------------------------------------------------
require(viridis)
gg_color_gradient(title="viridis continuous scale: virids") + scale_fill_viridis(option = "viridis")
gg_color_gradient(title="viridis continuous scale: magma") + scale_fill_viridis(option = "magma")
gg_color_gradient(title="viridis continuous scale: inferno") + scale_fill_viridis(option = "inferno")
gg_color_gradient(title="viridis continuous scale: plasma") + scale_fill_viridis(option = "plasma")

## ------------------------------------------------------------------------
gg_color_swatches(title="viridis discrete scale: virids") + scale_fill_viridis(option = "viridis", discrete = TRUE)
gg_color_swatches(title="viridis discrete scale: magma") + scale_fill_viridis(option = "magma", discrete = TRUE)
gg_color_swatches(title="viridis discrete scale: inferno") + scale_fill_viridis(option = "inferno", discrete = TRUE)
gg_color_swatches(title="viridis discrete scale: plasma") + scale_fill_viridis(option = "plasma", discrete = TRUE)

## ------------------------------------------------------------------------
gg_color_gradient(title="colorbrewer continuous sequential: Blues") + scale_fill_distiller(type="seq", palette="Blues")
gg_color_gradient(title="colorbrewer continuous sequential: BuGn") + scale_fill_distiller(type="seq", palette="BuGn")
gg_color_gradient(title="colorbrewer continuous sequential: BuPu") + scale_fill_distiller(type="seq", palette="BuPu")
gg_color_gradient(title="colorbrewer discrete sequential: GnBu") + scale_fill_distiller(type="seq", palette="GnBu")
gg_color_gradient(title="colorbrewer discrete sequential: Greens") + scale_fill_distiller(type="seq", palette="Greens")
gg_color_gradient(title="colorbrewer discrete sequential: Greys") + scale_fill_distiller(type="seq", palette="Greys")
gg_color_gradient(title="colorbrewer discrete sequential: Oranges") + scale_fill_distiller(type="seq", palette="Oranges")
gg_color_gradient(title="colorbrewer discrete sequential: OrRd") + scale_fill_distiller(type="seq", palette="OrRd")
gg_color_gradient(title="colorbrewer discrete sequential: PuBu") + scale_fill_distiller(type="seq", palette="PuBu")
gg_color_gradient(title="colorbrewer discrete sequential: PuBuGn") + scale_fill_distiller(type="seq", palette="PuBuGn")
gg_color_gradient(title="colorbrewer discrete sequential: PuRd") + scale_fill_distiller(type="seq", palette="PuRd")
gg_color_gradient(title="colorbrewer discrete sequential: Purples") + scale_fill_distiller(type="seq", palette="Purples")
gg_color_gradient(title="colorbrewer discrete sequential: RdPu") + scale_fill_distiller(type="seq", palette="RdPu")
gg_color_gradient(title="colorbrewer discrete sequential: Reds") + scale_fill_distiller(type="seq", palette="Reds")
gg_color_gradient(title="colorbrewer discrete sequential: YlGn") + scale_fill_distiller(type="seq", palette="YlGn")
gg_color_gradient(title="colorbrewer discrete sequential: YlGnBu") + scale_fill_distiller(type="seq", palette="YlGnBu")
gg_color_gradient(title="colorbrewer discrete sequential: YlOrBr") + scale_fill_distiller(type="seq", palette="YlOrBr")
gg_color_gradient(title="colorbrewer discrete sequential: YlOrRd") + scale_fill_distiller(type="seq", palette="YlOrRd")

## ------------------------------------------------------------------------
gg_color_swatches(title="colorbrewer discrete sequential: Blues") + scale_fill_brewer(type="seq", palette="Blues")
gg_color_swatches(title="colorbrewer discrete sequential: BuGn") + scale_fill_brewer(type="seq", palette="BuGn")
gg_color_swatches(title="colorbrewer discrete sequential: BuPu") + scale_fill_brewer(type="seq", palette="BuPu")
gg_color_swatches(title="colorbrewer discrete sequential: GnBu") + scale_fill_brewer(type="seq", palette="GnBu")
gg_color_swatches(title="colorbrewer discrete sequential: Greens") + scale_fill_brewer(type="seq", palette="Greens")
gg_color_swatches(title="colorbrewer discrete sequential: Greys") + scale_fill_brewer(type="seq", palette="Greys")
gg_color_swatches(title="colorbrewer discrete sequential: Oranges") + scale_fill_brewer(type="seq", palette="Oranges")
gg_color_swatches(title="colorbrewer discrete sequential: OrRd") + scale_fill_brewer(type="seq", palette="OrRd")
gg_color_swatches(title="colorbrewer discrete sequential: PuBu") + scale_fill_brewer(type="seq", palette="PuBu")
gg_color_swatches(title="colorbrewer discrete sequential: PuBuGn") + scale_fill_brewer(type="seq", palette="PuBuGn")
gg_color_swatches(title="colorbrewer discrete sequential: PuRd") + scale_fill_brewer(type="seq", palette="PuRd")
gg_color_swatches(title="colorbrewer discrete sequential: Purples") + scale_fill_brewer(type="seq", palette="Purples")
gg_color_swatches(title="colorbrewer discrete sequential: RdPu") + scale_fill_brewer(type="seq", palette="RdPu")
gg_color_swatches(title="colorbrewer discrete sequential: Reds") + scale_fill_brewer(type="seq", palette="Reds")
gg_color_swatches(title="colorbrewer discrete sequential: YlGn") + scale_fill_brewer(type="seq", palette="YlGn")
gg_color_swatches(title="colorbrewer discrete sequential: YlGnBu") + scale_fill_brewer(type="seq", palette="YlGnBu")
gg_color_swatches(title="colorbrewer discrete sequential: YlOrBr") + scale_fill_brewer(type="seq", palette="YlOrBr")
gg_color_swatches(title="colorbrewer discrete sequential: YlOrRd") + scale_fill_brewer(type="seq", palette="YlOrRd")

## ------------------------------------------------------------------------
gg_color_gradient(title="ggplot2 gradient2") + scale_fill_gradient2()

## ------------------------------------------------------------------------
gg_color_gradient(title="colorbrewer continuous diverging: BrBG") + scale_fill_distiller(type="div", palette="BrBG")
gg_color_gradient(title="colorbrewer continuous diverging: BrBG") + scale_fill_distiller(type="div", palette="BrBG")
gg_color_gradient(title="colorbrewer continuous diverging: PiYG") + scale_fill_distiller(type="div", palette="PiYG")
gg_color_gradient(title="colorbrewer continuous diverging: PRGn") + scale_fill_distiller(type="div", palette="PRGn")
gg_color_gradient(title="colorbrewer continuous diverging: PuOr") + scale_fill_distiller(type="div", palette="PuOr")
gg_color_gradient(title="colorbrewer continuous diverging: RdGy") + scale_fill_distiller(type="div", palette="RdGy")
gg_color_gradient(title="colorbrewer continuous diverging: RdYlBu") + scale_fill_distiller(type="div", palette="RdYlBu")
gg_color_gradient(title="colorbrewer continuous diverging: RdYlGn") + scale_fill_distiller(type="div", palette="RdYlGn")
gg_color_gradient(title="colorbrewer continuous diverging: Spectral") + scale_fill_distiller(type="div", palette="Spectral")

## ------------------------------------------------------------------------
gg_color_swatches(title="colorbrewer discrete diverging: BrBG") + scale_fill_brewer(type="div", palette="BrBG")
gg_color_swatches(title="colorbrewer discrete diverging: BrBG") + scale_fill_brewer(type="div", palette="BrBG")
gg_color_swatches(title="colorbrewer discrete diverging: PiYG") + scale_fill_brewer(type="div", palette="PiYG")
gg_color_swatches(title="colorbrewer discrete diverging: PRGn") + scale_fill_brewer(type="div", palette="PRGn")
gg_color_swatches(title="colorbrewer discrete diverging: PuOr") + scale_fill_brewer(type="div", palette="PuOr")
gg_color_swatches(title="colorbrewer discrete diverging: RdGy") + scale_fill_brewer(type="div", palette="RdGy")
gg_color_swatches(title="colorbrewer discrete diverging: RdYlBu") + scale_fill_brewer(type="div", palette="RdYlBu")
gg_color_swatches(title="colorbrewer discrete diverging: RdYlGn") + scale_fill_brewer(type="div", palette="RdYlGn")
gg_color_swatches(title="colorbrewer discrete diverging: Spectral") + scale_fill_brewer(type="div", palette="Spectral")

