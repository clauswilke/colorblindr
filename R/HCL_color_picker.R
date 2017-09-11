#' Shiny app to pick colors in HCL space
#'
#' @examples
#' \dontrun{
#' HCL_color_picker()
#' }
#' @export
#' @importFrom colorspace polarLUV LUV hex coords
#' @importFrom methods as
HCL_color_picker <- function() {
  app <- shiny::shinyApp(ui = color_picker_UI(), server = color_picker_Server())
  shiny::runApp(app)
}

color_picker_UI <- function() {
  shiny::shinyUI(shiny::pageWithSidebar(

    # application title
    shiny::headerPanel("HCL color picker"),

    # sidebar panel, defined below
    color_picker_sidebarPanel(),

    # main panel, defined below
    color_picker_mainPanel()
  ))
}

color_picker_sidebarPanel <- function() {
  # sidebar with controls to select the color
  shiny::sidebarPanel(
    shiny::sliderInput("H", "Hue",
                       min = 0, max = 360, value = 60),
    shiny::sliderInput("C", "Chroma",
                       min = 0, max = 180, value = 40),
    shiny::sliderInput("L", "Lightness",
                       min = 0, max = 100, value = 60),
    shiny::textInput("hexcolor", "R color", hex(polarLUV(60, 40, 60)))
  )
}


color_picker_mainPanel <- function() {
  # Show the caption and plot of the requested variable against mpg
  shiny::mainPanel(
    shiny::plotOutput("plot", click = "plot_click")
  )
}


color_picker_Server <- function() {
  shiny::shinyServer(function(input, output, session) {

    shiny::observe({
      # store the old colors
      coords_old_LUV <- coords(as(polarLUV(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H)), "LUV"))
      U <- input$plot_click$x
      if (is.null(U)) U <- coords_old_LUV[2L]
      V <- input$plot_click$y
      if (is.null(V)) V <- coords_old_LUV[3L]
      L <- input$L
      col_LUV <- LUV(L, U, V)
      coords_HCL <- coords(as(col_LUV, "polarLUV"))
      shiny::updateSliderInput(session, "C", value = coords_HCL[2L])
      shiny::updateSliderInput(session, "H", value = coords_HCL[3L])
      shiny::updateTextInput(session, "hexcolor", value = hex(col_LUV))
    })

    shiny::observe({
      # only execute this on complete color hex codes
      if (grepl("^#[0123456789ABCDEFabcdef]{6}$", input$hexcolor)) {
        col_RGB <- hex2RGB(input$hexcolor)
        coords_HCL <- coords(as(col_RGB, "polarLUV"))
        shiny::updateSliderInput(session, "L", value = coords_HCL[1L])
        shiny::updateSliderInput(session, "C", value = coords_HCL[2L])
        shiny::updateSliderInput(session, "H", value = coords_HCL[3L])
      }
    })


    # generate HCL plot with given L
    output$plot <- shiny::renderPlot({
      color_picker_HCL_plot(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

  })
}


color_picker_HCL_plot <- function(L, C = 20, H = 0, n = 40) {
  U <- seq(-150, 150, length.out = n)
  V <- seq(-150, 150, length.out = n)
  grid <- expand.grid(U = U, V = V)

  luv <- LUV(L, grid$U, grid$V)

  df <- data.frame(U = grid$U,
                   V = grid$V,
                   col = hex(luv),
                   stringsAsFactors = FALSE)

  colors <- df$col
  names(colors) <- df$col

  sel_col <- polarLUV(L, C, H) # selected color in polar LUV
  sel_pt <- coords(as(sel_col, "LUV")) # coordinates of selected point in LUV
  df_sel <- data.frame(U = sel_pt[2L], V = sel_pt[3L])

  ggplot2::ggplot(df, ggplot2::aes(U, V, fill = col)) + ggplot2::geom_raster(interpolate = TRUE, na.rm = TRUE) +
    ggplot2::geom_point(data = df_sel, ggplot2::aes(U, V),
               inherit.aes = FALSE, size = 5, color = "black", fill = hex(sel_col),
               shape = 21) +
    ggplot2::annotate("path",
             x=C*cos(seq(0, 2*pi, length.out=100)),
             y=C*sin(seq(0, 2*pi, length.out=100)), color = "black", size = 0.2, alpha = 0.5) +
    ggplot2::scale_fill_manual(values = colors, guide = "none") +
    ggplot2::coord_fixed(xlim = c(-150, 150), ylim = c(-150, 150), expand = FALSE) +
    ggplot2::theme_minimal()
}

