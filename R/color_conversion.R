<<<<<<< HEAD
#' `desaturate` turns colors into their gray values
#' @param col Vector of colors to convert
#' @param rel_chroma Degree of desaturation. 0=complete, 1=none.
#' @importFrom colorspace desaturate
#' @export
desaturate <- colorspace::desaturate

#' `deutan1` converts colors using the deutan model of colorblindness (low severity)
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect
#' @export
deutan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])

#' `deutan2` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan2 <- function(colors, sev='2') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])

#' `deutan3` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan3 <- function(colors, sev='3') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])

#' `deutan4` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan4 <- function(colors, sev='4') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])

#' `deutan5` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan5 <- function(colors, sev='5') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])

#' `deutan6` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan6 <- function(colors, sev='6') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])

#' `deutan7` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan7 <- function(colors, sev='7') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])

#' `deutan8` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan9 <- function(colors, sev='9') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])


#' `deutan10` converts colors using the deutan model of colorblindness (high severity)
#'
#' @rdname deutan1
#' @export
deutan10 <- function(colors, sev='10') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev][[1]])


#' `protan1` converts colors using the protan model of colorblindness (low severity)
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect
#' @export
protan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])

#' `protan2` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan2 <- function(colors, sev='2') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])


#' `protan3` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan3 <- function(colors, sev='3') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])

#' `protan4` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan4 <- function(colors, sev='4') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])

#' `protan5` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan5 <- function(colors, sev='5') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])

#' `protan6` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan6 <- function(colors, sev='6') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])

#' `protan7` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan7 <- function(colors, sev='7') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])

#' `protan8` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan9 <- function(colors, sev='9') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])


#' `protan10` converts colors using the protan model of colorblindness (high severity)
#'
#' @rdname protan1
#' @export
protan10 <- function(colors, sev='10') simulate_colorblind(colors, cvd=protanomaly_cvd[sev][[1]])


#' `tritan1` converts colors using the tritan model of colorblindness (low severity)
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect
#' @export
tritan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])


#' `tritan1` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])

#' `tritan2` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan2 <- function(colors, sev='2') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])


#' `tritan3` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan3 <- function(colors, sev='3') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])

#' `tritan4` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan4 <- function(colors, sev='4') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])

#' `tritan5` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan5 <- function(colors, sev='5') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])

#' `tritan6` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan6 <- function(colors, sev='6') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])

#' `tritan7` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan7 <- function(colors, sev='7') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])

#' `tritan8` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan9 <- function(colors, sev='9') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])


#' `tritan10` converts colors using the tritan model of colorblindness (high severity)
#'
#' @rdname tritan1
#' @export
tritan10 <- function(colors, sev='10') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev][[1]])

=======
#' `desaturate` turns colors into their gray values
#' @param col Vector of colors to convert
#' @param rel_chroma Degree of desaturation. 0=complete, 1=none.
#' @importFrom colorspace desaturate
#' @export
desaturate <- colorspace::desaturate

#' `deutan` converts colors using the deutan model of colorblindness
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect, a number between 0 and 1
#' @export
deutan <- function(colors, sev=1){
  if (sev <= 0) {
    cvd <- deutanomaly_cvd[[1]]
  } else if (sev >= 1) {
    cvd <- deutanomaly_cvd[[11]]
  } else {
    s <- 10*sev
    i1 <- floor(s)
    i2 <- ceiling(s)
    if (i1 == i2) {
      cvd <- deutanomaly_cvd[[i1]]
    }
    else {
      cvd <- (i2-s)*deutanomaly_cvd[[i1+1]] + (s-i1)*deutanomaly_cvd[[i2+1]]
    }
  }

  simulate_colorblind(colors, cvd=list(cvd))
}

#' `deutan1` converts colors using the deutan model of colorblindness (low severity)
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect
#' @export
deutan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])

#' `deutan2` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan2 <- function(colors, sev='2') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])

#' `deutan3` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan3 <- function(colors, sev='3') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])

#' `deutan4` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan4 <- function(colors, sev='4') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])

#' `deutan5` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan5 <- function(colors, sev='5') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])

#' `deutan6` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan6 <- function(colors, sev='6') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])

#' `deutan7` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan7 <- function(colors, sev='7') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])

#' `deutan8` converts colors using the deutan model of colorblindness
#'
#' @rdname deutan1
#' @export
deutan9 <- function(colors, sev='9') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])


#' `deutan10` converts colors using the deutan model of colorblindness (high severity)
#'
#' @rdname deutan1
#' @export
deutan10 <- function(colors, sev='10') simulate_colorblind(colors, cvd=deutanomaly_cvd[sev])


#' `protan1` converts colors using the protan model of colorblindness (low severity)
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect
#' @export
protan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])

#' `protan2` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan2 <- function(colors, sev='2') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])


#' `protan3` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan3 <- function(colors, sev='3') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])

#' `protan4` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan4 <- function(colors, sev='4') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])

#' `protan5` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan5 <- function(colors, sev='5') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])

#' `protan6` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan6 <- function(colors, sev='6') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])

#' `protan7` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan7 <- function(colors, sev='7') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])

#' `protan8` converts colors using the protan model of colorblindness
#'
#' @rdname protan1
#' @export
protan9 <- function(colors, sev='9') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])


#' `protan10` converts colors using the protan model of colorblindness (high severity)
#'
#' @rdname protan1
#' @export
protan10 <- function(colors, sev='10') simulate_colorblind(colors, cvd=protanomaly_cvd[sev])


#' `tritan1` converts colors using the tritan model of colorblindness (low severity)
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect
#' @export
tritan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])


#' `tritan1` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan1 <- function(colors, sev='1') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])

#' `tritan2` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan2 <- function(colors, sev='2') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])


#' `tritan3` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan3 <- function(colors, sev='3') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])

#' `tritan4` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan4 <- function(colors, sev='4') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])

#' `tritan5` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan5 <- function(colors, sev='5') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])

#' `tritan6` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan6 <- function(colors, sev='6') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])

#' `tritan7` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan7 <- function(colors, sev='7') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])

#' `tritan8` converts colors using the tritan model of colorblindness
#'
#' @rdname tritan1
#' @export
tritan9 <- function(colors, sev='9') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])


#' `tritan10` converts colors using the tritan model of colorblindness (high severity)
#'
#' @rdname tritan1
#' @export
tritan10 <- function(colors, sev='10') simulate_colorblind(colors, cvd=tritanomaly_cvd[sev])

>>>>>>> e5a1b7d61716a3ac1571d7ef8a76f0be8a6c88a2
