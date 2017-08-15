#' `deutan` converts colors using the deutan model of colorblindness
#'
#' @param colors Vector of R colors to convert
#' @export
deutan <- function(colors) dichromat::dichromat(colors, type = "deutan")

#' `protan` converts colors using the protan model of colorblindness
#'
#' @rdname deutan
#' @export
protan <- function(colors) dichromat::dichromat(colors, type = "protan")

#' `tritan` converts colors using the tritan model of colorblindness
#'
#' @rdname deutan
#' @export
tritan <- function(colors) dichromat::dichromat(colors, type = "tritan")

#' `deutanomaly` converts colors using the deutanomaly model of colorblindness
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect
#' @export
deutanomaly <- function(colors, sev='30') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])


#' `desaturate` turns colors into their gray values
#' @param col Vector of colors to convert
#' @export
desaturate <- colorspace::desaturate
