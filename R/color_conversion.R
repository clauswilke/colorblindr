#' Turn colors into their gray values
#'
#' @param col Vector of colors to convert
#' @param amount Degree of desaturation. 1=complete, 0=none.
#' @importFrom colorspace desaturate
#' @export
desaturate <- colorspace::desaturate

#' Generate color transformation matrices using the deutan model of colorblindness
#'
#' @param sev Severity of the color vision defect, a number between 0 and 1
#' @export
deutan_transform <- function(sev = 1) {
  if (sev <= 0) {
    deutanomaly_cvd[[1]]
  } else if (sev >= 1) {
    deutanomaly_cvd[[11]]
  } else {
    s <- 10*sev
    i1 <- floor(s)
    i2 <- ceiling(s)
    if (i1 == i2) {
      deutanomaly_cvd[[i1]]
    }
    else {
      (i2-s)*deutanomaly_cvd[[i1+1]] + (s-i1)*deutanomaly_cvd[[i2+1]]
    }
  }
}

#' Convert colors using the deutan model of colorblindness
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect, a number between 0 and 1
#' @export
deutan <- function(colors, sev = 1) {
  simulate_cvd(colors, cvd_transform=deutan_transform(sev))
}

#' Generate color transformation matrices using the protan model of colorblindness
#'
#' @param sev Severity of the color vision defect, a number between 0 and 1
#' @export
protan_transform <- function(sev = 1) {
  if (sev <= 0) {
    protanomaly_cvd[[1]]
  } else if (sev >= 1) {
    protanomaly_cvd[[11]]
  } else {
    s <- 10*sev
    i1 <- floor(s)
    i2 <- ceiling(s)
    if (i1 == i2) {
      protanomaly_cvd[[i1]]
    }
    else {
      (i2-s)*protanomaly_cvd[[i1+1]] + (s-i1)*protanomaly_cvd[[i2+1]]
    }
  }
}

#' Convert colors using the protan model of colorblindness
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect, a number between 0 and 1
#' @export
protan <- function(colors, sev = 1) {
  simulate_cvd(colors, cvd_transform = protan_transform(sev))
}

#' Generate color transformation matrices using the tritan model of colorblindness
#'
#' @param sev Severity of the color vision defect, a number between 0 and 1
#' @export
tritan_transform <- function(sev = 1) {
  if (sev <= 0) {
    tritanomaly_cvd[[1]]
  } else if (sev >= 1) {
    tritanomaly_cvd[[11]]
  } else {
    s <- 10*sev
    i1 <- floor(s)
    i2 <- ceiling(s)
    if (i1 == i2) {
      tritanomaly_cvd[[i1]]
    }
    else {
      (i2-s)*tritanomaly_cvd[[i1+1]] + (s-i1)*tritanomaly_cvd[[i2+1]]
    }
  }
}

#' Convert colors using the tritan model of colorblindness
#'
#' @param colors Vector of colors to convert
#' @param sev Severity of the color vision defect, a number between 0 and 1
#' @export
tritan <- function(colors, sev = 1){
  simulate_cvd(colors, cvd_transform=tritan_transform(sev))
}
