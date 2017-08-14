#' Simulate colorblindness for a hex color given a cvd transform matrix
#'
#' Generate a hex color simulating colorblindness.
#' Algorithm from http://www.daltonize.org/.
#' Code from https://github.com/muppetjones/remcolor/blob/master/R/SimulateColorBlind.R
#' @param hex_str The hex color string, e.g., '#FF0000'
#' @param cvd A vector (3x3--9 values) specifying the color vision deficiency transform matrix
#' @keywords colors, palette, colorblind
#' @export
#' @examples
#' simulate_colorblind_hex(
#' #01a203, CVDMatrix[['tritanomaly100']])
#'
simulate_colorblind_hex <- function(hex_str, cvd) {
    # algorithm from http://www.daltonize.org/
    print(hex_str)
    print(cvd)
    # init vars for lintr
    cvd_a <- cvd_b <- cvd_c <- 0
    cvd_d <- cvd_e <- cvd_f <- 0
    cvd_g <- cvd_h <- cvd_i <- 0
    r <- g <- b <- 0

    # break apart the vectors
    list[cvd_a, cvd_b, cvd_c, cvd_d, cvd_e, cvd_f, cvd_g, cvd_h, cvd_i] <- cvd
    list[r, g, b] <- col2rgb(hex_str)

    # RGB to LMS matrix conversion
    L <- (17.8824 * r) + (43.5161 * g) + (4.11935 * b)
    M <- (3.45565 * r) + (27.1554 * g) + (3.86714 * b)
    S <- (0.0299566 * r) + (0.184309 * g) + (1.46709 * b)

    # Simulate color blindness
    l <- (cvd_a * L) + (cvd_b * M) + (cvd_c * S)
    m <- (cvd_d * L) + (cvd_e * M) + (cvd_f * S)
    s <- (cvd_g * L) + (cvd_h * M) + (cvd_i * S)

    # LMS to RGB matrix conversion
    R <- (0.0809444479 * l) + (-0.130504409 * m) + (0.116721066 * s)
    G <- (-0.0102485335 * l) + (0.0540193266 * m) + (-0.113614708 * s)
    B <- (-0.000365296938 * l) + (-0.00412161469 * m) + (0.693511405 * s)

    # Isolate invisible colors to color vision deficiency
    # (calculate error matrix)
    R <- r - R
    G <- g - G
    B <- b - B

    # Shift colors towards visible spectrum (apply error modifications)
    RR <- (0.0 * R) + (0.0 * G) + (0.0 * B)
    GG <- (0.7 * R) + (1.0 * G) + (0.0 * B)
    BB <- (0.7 * R) + (0.0 * G) + (1.0 * B)

    # Add compensation to original values
    R <- RR + r
    G <- GG + g
    B <- BB + b

    # Clamp values
    if (R < 0)  R <- 0
    if (R > 255) R <- 255
    if (G < 0) G <- 0
    if (G > 255) G <- 255
    if (B < 0) B <- 0
    if (B > 255) B <- 255

    R <- as.integer(R)
    G <- as.integer(G)
    B <- as.integer(B)

    return(sprintf("#%02x%02x%02x", R, G, B))
}

#' Apply colorblindness tranformation to a vector of hex values
#'
#' Generate a vector of hex colors color blindness
#' @param col The color vector
#' @keywords colors, palette, colorblind
#' @export
#' @examples
#' colorblindr.simulate_colorblind(
#'  c("#005000","#008600","#00BB00"), tritanomaly['60'])

simulate_colorblind <- function(col, cvd){
    return(as.vector(sapply(col, function(x)
        simulate_colorblind_hex(x, cvd))
    ))
}

