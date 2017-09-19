#' Simulate color vision deficiency given a cvd transform matrix
#'
#' This function takes valid R colors and transforms them according to a cvd transform matrix.
#' @param col A color or vector of colors e.g., "#FFA801" or "blue"
#' @param cvd_transform A 3x3 matrix specifying the color vision deficiency transform matrix
#' @keywords colors, cvd, colorblind
#' @export
#' @examples
#'
#'  simulate_cvd(c("#005000","blue","#00BB00"),
#'  tritanomaly_cvd['6'][[1]])
#'
#' @importFrom grDevices col2rgb
#' @author Claire D. McWhite @clairemcwhite
simulate_cvd <- function(col, cvd_transform) {
  #Adapted from desaturate

  #If all hex
  if (is.character(col) && (all(substr(col, 1L, 1L) == "#") &
                            all(nchar(col) %in% c(7L, 9L)))) {
    #Save transparency value for later
    alpha <- substr(col, 8L, 9L)
    col <- substr(col, 1L, 7L)
    col <- grDevices::col2rgb(col)
  }
  #If contains built in color..,
  else {
    col <- grDevices::col2rgb(col, alpha = TRUE)
    ## extract alpha values (if non-FF)
    alpha <- format(as.hexmode(col[4L, ]), width = 2L, upper.case = TRUE)
    alpha[alpha == "FF"] <- ""
    ## retain only RGB
    col <- col[1L:3L,]

  }

  # Transform color
  RGB <- cvd_transform %*% col

  # Bound RGB values
  RGB[RGB<0]=0
  RGB[RGB>255]=255

  # Convert back to hex
  rgb2hex <- function(RGB) grDevices::rgb(RGB[1,], RGB[2,], RGB[3,], maxColorValue = 255)

  final_hex <- paste(rgb2hex(RGB), alpha, sep="")
  return(final_hex)
}


