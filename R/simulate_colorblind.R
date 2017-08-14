#Adapted from muppetjones/remcolor
#Color from https://personal.sron.nl/~pault/colourschemes.pdf

list <- structure(NA, class = "result")
"[<-.result" <- function(x, ..., value) {
    args <- as.list(match.call())
    args <- args[-c(1:2, length(args))]
    length(value) <- length(args)
    for (i in seq(along = args)) {
        a <- args[[i]]
        if (!missing(a)) {
            eval.parent(substitute(a <- v, list(a = a, v = value[[i]])))
        }
    }
    x
}


#Matrices from supplemental data of Machado 2009. http://www.inf.ufrgs.br/~oliveira/pubs_files/CVD_Simulation/CVD_Simulation.html
#Adapted from https://github.com/njsmith/colorspacious/blob/master/colorspacious/cvd.py
CVDMatrix <- list( # Color Vision Deficiency
#    "Protanope" = c( # reds are greatly reduced (1% men)
#        0.0, 2.02344, -2.52581,
#        0.0, 1.0,      0.0,
#        0.0, 0.0,      1.0
#    ),
#    "Deuteranope" = c( # greens are greatly reduced (1% men)
#        1.0,      0.0, 0.0,
#        0.494207, 0.0, 1.24827,
#        0.0,      0.0, 1.0
#    ),
#    "Tritanope" = c( # blues are greatly reduced (0.003% population)
#        1.0,       0.0,      0.0,
#        0.0,       1.0,      0.0,
#        -0.395913, 0.801109, 0.0
#    )
#)
    "protanomaly0" = c( #Low red
           1.000000,  0.000000, -0.000000,
           0.000000,  1.000000,  0.000000,
          -0.000000, -0.000000,  1.000000
       ),
     "protanomaly10" = c(
           0.856167,  0.182038, -0.038205,
           0.029342,  0.955115,  0.015544,
          -0.002880, -0.001563,  1.004443
       ),
     "protanomaly20" = c(
           0.734766,  0.334872, -0.069637,
           0.051840,  0.919198,  0.028963,
          -0.004928, -0.004209,  1.009137
       ),
      "protanomaly30" = c(
           0.630323,  0.465641, -0.095964,
           0.069181,  0.890046,  0.040773,
          -0.006308, -0.007724,  1.014032
       ),
     "protanomaly40" = c(
           0.539009,  0.579343, -0.118352,
           0.082546,  0.866121,  0.051332,
          -0.007136, -0.011959,  1.019095
       ),
     "protanomaly50" = c(
           0.458064,  0.679578, -0.137642,
           0.092785,  0.846313,  0.060902,
          -0.007494, -0.016807,  1.024301
       ),
     "protanomaly60" = c(
           0.385450,  0.769005, -0.154455,
           0.100526,  0.829802,  0.069673,
          -0.007442, -0.022190,  1.029632
       ),
     "protanomaly70" = c(
           0.319627,  0.849633, -0.169261,
           0.106241,  0.815969,  0.077790,
          -0.007025, -0.028051,  1.035076
       ),
     "protanomaly80" = c(
           0.259411,  0.923008, -0.182420,
           0.110296,  0.804340,  0.085364,
          -0.006276, -0.034346,  1.040622
       ),
     "protanomaly90" = c(
           0.203876,  0.990338, -0.194214,
           0.112975,  0.794542,  0.092483,
          -0.005222, -0.041043,  1.046265
       ),
    "protanomaly100" = c(
           0.152286,  1.052583, -0.204868,
           0.114503,  0.786281,  0.099216,
          -0.003882, -0.048116,  1.051998
       ),
      "deuteranomaly0" = c(
           1.000000,  0.000000, -0.000000,
           0.000000,  1.000000,  0.000000,
          -0.000000, -0.000000,  1.000000
       ),
     "deuteranomaly10" = c(
           0.866435,  0.177704, -0.044139,
           0.049567,  0.939063,  0.011370,
          -0.003453,  0.007233,  0.996220
       ),
     "deuteranomaly20" = c(
           0.760729,  0.319078, -0.079807,
           0.090568,  0.889315,  0.020117,
          -0.006027,  0.013325,  0.992702
       ),
     "deuteranomaly30" = c(
           0.675425,  0.433850, -0.109275,
           0.125303,  0.847755,  0.026942,
          -0.007950,  0.018572,  0.989378
       ),
     "deuteranomaly40" = c(
           0.605511,  0.528560, -0.134071,
           0.155318,  0.812366,  0.032316,
          -0.009376,  0.023176,  0.986200
       ),
     "deuteranomaly50" = c(
           0.547494,  0.607765, -0.155259,
           0.181692,  0.781742,  0.036566,
          -0.010410,  0.027275,  0.983136
       ),
     "deuteranomaly60" = c(
           0.498864,  0.674741, -0.173604,
           0.205199,  0.754872,  0.039929,
          -0.011131,  0.030969,  0.980162
       ),
     "deuteranomaly70" = c(
           0.457771,  0.731899, -0.189670,
           0.226409,  0.731012,  0.042579,
          -0.011595,  0.034333,  0.977261
       ),
     "deuteranomaly80" = c(
           0.422823,  0.781057, -0.203881,
           0.245752,  0.709602,  0.044646,
          -0.011843,  0.037423,  0.974421
       ),
     "deuteranomaly90" = c(
           0.392952,  0.823610, -0.216562,
           0.263559,  0.690210,  0.046232,
          -0.011910,  0.040281,  0.971630
       ),
    "deuteranomaly100" = c(
           0.367322,  0.860646, -0.227968,
           0.280085,  0.672501,  0.047413,
          -0.011820,  0.042940,  0.968881
       ),

     "tritanomaly0" = c(
           1.000000,  0.000000, -0.000000,
           0.000000,  1.000000,  0.000000,
          -0.000000, -0.000000,  1.000000
       ),
     "tritanomaly10" = c(
           0.926670,  0.092514, -0.019184,
           0.021191,  0.964503,  0.014306,
           0.008437,  0.054813,  0.936750
       ),
     "tritanomaly20" = c(
           0.895720,  0.133330, -0.029050,
           0.029997,  0.945400,  0.024603,
           0.013027,  0.104707,  0.882266
       ),
     "tritanomaly30" = c(
           0.905871,  0.127791, -0.033662,
           0.026856,  0.941251,  0.031893,
           0.013410,  0.148296,  0.838294
       ),
     "tritanomaly40" = c(
           0.948035,  0.089490, -0.037526,
           0.014364,  0.946792,  0.038844,
           0.010853,  0.193991,  0.795156
       ),
     "tritanomaly50" = c(
           1.017277,  0.027029, -0.044306,
          -0.006113,  0.958479,  0.047634,
           0.006379,  0.248708,  0.744913
       ),
     "tritanomaly60" = c(
           1.104996, -0.046633, -0.058363,
          -0.032137,  0.971635,  0.060503,
           0.001336,  0.317922,  0.680742
       ),
     "tritanomaly70" = c(
           1.193214, -0.109812, -0.083402,
          -0.058496,  0.979410,  0.079086,
          -0.002346,  0.403492,  0.598854
       ),
     "tritanomaly80" = c(
           1.257728, -0.139648, -0.118081,
          -0.078003,  0.975409,  0.102594,
          -0.003316,  0.501214,  0.502102
       ),
     "tritanomaly90" = c(
           1.278864, -0.125333, -0.153531,
          -0.084748,  0.957674,  0.127074,
          -0.000989,  0.601151,  0.399838
       ),
    "tritanomaly100" = c(
           1.255528, -0.076749, -0.178779,
          -0.078411,  0.930809,  0.147602,
           0.004733,  0.691367,  0.303900
       )
     )




#' Simulate colorblindness for a color
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

#' Apply colorblindness tranformation to a vector of hex value
#'
#' Generate a vector of hex colors color blindness
#' @param col The color vector
#' @keywords colors, palette, colorblind
#' @export
#' @examples
#' colorblindr.simulate_colorblind(
#'  c("#005000","#008600","#00BB00"), CVDMatrix[['tritanomaly60']])

simulate_colorblind <- function(col, cvd){
    return(as.vector(sapply(col, function(x)
        simulate_colorblind_hex(x, cvd))
    ))
}

