#' Simulate colorblindness for a hex color given a cvd transform matrix
#'
#' Generate a hex color simulating colorblindness.
#' Daltonization algorithm from http://www.daltonize.org/.
#' Aided by https://github.com/muppetjones/remcolor/blob/master/R/SimulateColorBlind.R
#' @param col The hex color string, e.g., '#FF0000'
#' @param cvd A 3x3 matrix specifying the color vision deficiency transform matrix
#' @keywords colors, palette, colorblind
#' @export
#' @examples
#' ## doesn't currently work
#' # simulate_colorblind_hex("#01a203", tritanomaly_cvd['6'][[1]])
#'
#' @importFrom grDevices col2rgb
simulate_colorblind_hex <- function(col, cvd) {
  print(col)
  #From desaturate
  alpha <- ""
  if (is.character(col) && (all(substr(col, 1L, 1L) == "#") &
                            all(nchar(col) %in% c(7L, 9L)))) {
    alpha <- substr(col, 8L, 9L)
    col <- substr(col, 1L, 7L)
    rgb_mat <- col2rgb(col)
  }
  else {
    rgb_mat <- col2rgb(col)
    #col <- col2rgb(col, alpha = TRUE)
    #alpha <- format(as.hexmode(col[4L, ]), width = 2L, upper.case = TRUE)
    #alpha[alpha == "FF"] <- ""
    #rgb_mat <- rgb(t(col[1L:3L, ])/255)
  }


  print(cvd)
  rgb_lms_conv <- matrix(c(17.8824,43.5161,4.11935,
                           3.45565,27.1554,3.86714,
                           0.0299566,0.184309,1.46709),
                         3,3, byrow=TRUE)

  #Convert RGB to LMS
  LMS <- rgb_lms_conv %*% rgb_mat

  # Scale color blindness
  lms <- cvd %*% LMS

  lms_rgb_conv <- matrix(c(0.0809444479,-0.130504409,0.116721066,
                           -0.0102485335,0.0540193266,-0.113614708,
                           -0.000365296938,0.00412161469,0.693511405),
                         3,3, byrow=TRUE)


  #Convert LMS to RGB
  RGB <- lms_rgb_conv %*% lms

  #daltonization algorithm from http://www.daltonize.org/
  #Daltonization portion (Used by colorblind people to make indistinguishable images more distinguishable)
  #  # Isolate invisible colors to color vision deficiency
  #  # (calculate error matrix)
  #  RGB <- rgb_mat - RGB

  #  error_mods <- matrix(c(0.0, 0.0, 0.0,
  #                         0.7, 1.0, 0.0,
  #                         0.7, 0.0, 1.0),
  #                       3,3, byrow=TRUE)

  #  # Apply error modification
  #  RRGGBB <- error_mods %*% RGB

  #  # Add compensation to original values

  #  RGB <- RRGGBB + rgb

  #  # RGB values must be between 0 and 255
  RGB[RGB<0]=0
  RGB[RGB>255]=255

  #
  rgb2hex <- function(RGB) rgb(RGB[1,], RGB[2,], RGB[3,], maxColorValue = 255)

  final_hex <- paste(rgb2hex(RGB), alpha, sep="")
  print(final_hex)
  return(final_hex)
}

#' Apply colorblindness tranformation to a vector of hex values
#'
#' Generate a vector of hex colors color blindness
#' @param col The color vector
#' @param cvd A 3x3 matrix specifying the color vision deficiency transform matrix
#' @keywords colors, palette, colorblind
#' @export
#' @examples
#'
#'  simulate_colorblind(c("#005000","#008600","#00BB00"),
#'  tritanomaly_cvd['6'][[1]])

simulate_colorblind <- function(col, cvd){
  return(as.vector(sapply(col, function(x)
    simulate_colorblind_hex(x, cvd))
  ))
}

