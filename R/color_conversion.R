#' `deutan` converts colors using the protan model of colorblindness
#'
#' @param colors Vector of R colors to convert
#' @export
deutan <- function(colors) dichromat::dichromat(colors, type = "deutan")

#' `protan` converts colors using the protan model of colorblindness
#'
#' @rdname deutan
#' @export
protan <- function(colors) dichromat::dichromat(colors, type = "protan")

#' `tritan` converts colors using the protan model of colorblindness
#'
#' @rdname deutan
#' @export
tritan <- function(colors) dichromat::dichromat(colors, type = "tritan")
