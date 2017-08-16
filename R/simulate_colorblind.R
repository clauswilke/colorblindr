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
#'
#'  simulate_colorblind(c("#005000","#008600","#00BB00"),
#'  tritanomaly_cvd['6'])
#'
#' @importFrom grDevices col2rgb
simulate_colorblind <- function(col, cvd) {
    return(as.vector(sapply(col, function(x){

        print(col)
        #Adapted from desaturate
        alpha <- ""

        if (is.character(col) && (all(substr(col, 1L, 1L) == "#") &
                                  all(nchar(col) %in% c(7L, 9L)))) {
          alpha <- substr(col, 8L, 9L)
          col <- substr(col, 1L, 7L)
          col <- grDevices::col2rgb(col)
        }
        else {
          col <- grDevices::col2rgb(col, alpha = TRUE)
          print(col)
          ## extract alpha values (if non-FF)
          alpha <- format(as.hexmode(col[4L, ]), width = 2L, upper.case = TRUE)
          alpha[alpha == "FF"] <- ""
          ## retain only RGB
          col <- col[1L:3L,]

        }

        # Scale color blindness
        RGB <- cvd[[1]] %*% col
        RGB[RGB<0]=0
        RGB[RGB>255]=255

        rgb2hex <- function(RGB) rgb(RGB[1,], RGB[2,], RGB[3,], maxColorValue = 255)

        final_hex <- paste(rgb2hex(RGB), alpha, sep="")
        print(final_hex)
        return(final_hex)


        }

    )))
}


