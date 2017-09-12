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
    shiny::textInput("hexcolor", "RGB hex color", hex(polarLUV(60, 40, 60))),
    shiny::htmlOutput("colorbox"),
    # script to catch keystrokes
    tags$script('$(document).on("keydown", function (e) {Shiny.onInputChange("lastkeypresscode", e.keyCode);});')
  )
}


color_picker_mainPanel <- function() {
  # Show the caption and plot of the requested variable against mpg
  shiny::mainPanel(
    shiny::plotOutput("plot", click = "plot_click"),
    shiny::plotOutput("Hgrad", click = "Hgrad_click", height = "50px"),
    shiny::plotOutput("Cgrad", click = "Cgrad_click", height = "50px"),
    shiny::plotOutput("Lgrad", click = "Lgrad_click", height = "50px")
  )
}


color_picker_Server <- function() {
  shiny::shinyServer(function(input, output, session) {

    shiny::observeEvent({input$plot_click}, {
      # store the old colors
      coords_old_LUV <- coords(as(polarLUV(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H)), "LUV"))
      U <- input$plot_click$x
      if (is.null(U)) U <- coords_old_LUV[2L]
      V <- input$plot_click$y
      if (is.null(V)) V <- coords_old_LUV[3L]
      L <- input$L
      coords_HCL <- coords(as(LUV(L, U, V), "polarLUV"))
      shiny::updateSliderInput(session, "C", value = round(coords_HCL[2L]))
      shiny::updateSliderInput(session, "H", value = round(coords_HCL[3L]))
    })

    shiny::observeEvent({input$Hgrad_click}, {
      H <- input$Hgrad_click$x
      if (!is.null(H)) {
        shiny::updateSliderInput(session, "H", value = round(H))
      }
    })

    shiny::observeEvent({input$Lgrad_click}, {
      L <- input$Lgrad_click$x
      if (!is.null(L)) {
        shiny::updateSliderInput(session, "L", value = round(L))
      }
    })

    shiny::observeEvent({input$Cgrad_click}, {
      C <- input$Cgrad_click$x
      if (!is.null(C)) {
        shiny::updateSliderInput(session, "C", value = round(C))
      }
    })

    shiny::observeEvent({input$hexcolor}, {
      # only execute after key has been pressed
      if(!is.null(input$lastkeypresscode)) {
        # only execute this on complete color hex codes
        if (grepl("^#[0123456789ABCDEFabcdef]{6}$", input$hexcolor)) {
            col_RGB <- hex2RGB(input$hexcolor)
            coords_HCL <- coords(as(col_RGB, "polarLUV"))
            shiny::updateSliderInput(session, "L", value = round(coords_HCL[1L]))
            shiny::updateSliderInput(session, "C", value = round(coords_HCL[2L]))
            shiny::updateSliderInput(session, "H", value = round(coords_HCL[3L]))
        }
      }
    })

    shiny::observe({
      shiny::updateTextInput(session, "hexcolor", value = hex(polarLUV(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))))
    })

    output$colorbox <- shiny::renderUI({
      shiny::tags$div(style=paste0("width: 100%; height: 40px; border: 1px solid rgba(0, 0, 0, .2); background: ",
                     hex(polarLUV(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))), ";"))
    })

    # generate HCL plot with given inputs
    output$plot <- shiny::renderPlot({
      color_picker_HCL_plot(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    output$Hgrad <- shiny::renderPlot({
      color_picker_H_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    output$Cgrad <- shiny::renderPlot({
      color_picker_C_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    output$Lgrad <- shiny::renderPlot({
      color_picker_L_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

  })
}


color_picker_HCL_plot <- function(L, C = 20, H = 0, n = 100) {
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


color_picker_C_gradient <- function(L, C = 20, H = 0, n = 40) {
  Cseq = seq(0, max(150, C+5), length.out = n)
  col <- hex(polarLUV(L, Cseq, H))
  sel_col <- hex(polarLUV(L, C, H))

  df <- data.frame(C = Cseq,
                   y = 0,
                   col = col,
                   stringsAsFactors = FALSE)

  colors <- df$col
  names(colors) <- df$col

  df_sel <- data.frame(C = C, H = H, L = L, y = 0)

  ggplot2::ggplot(df, ggplot2::aes(C, y, fill = col)) + ggplot2::geom_raster(interpolate = TRUE, na.rm = TRUE) +
    ggplot2::geom_point(data = df_sel, ggplot2::aes(C, y),
                        inherit.aes = FALSE, size = 5, color = "black", fill = sel_col,
                        shape = 21) +
    ggplot2::scale_fill_manual(values = colors, guide = "none") +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::ylab("C") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_text(angle = 0, vjust = 0.5, size = 14),
                   axis.text.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank(),
                   panel.grid.minor.y = ggplot2::element_blank())
}

color_picker_H_gradient <- function(L, C = 20, H = 0, n = 40) {
  Hseq = seq(0, 360, length.out = n)
  col <- hex(polarLUV(L, C, Hseq))
  sel_col <- hex(polarLUV(L, C, H))

  df <- data.frame(H = Hseq,
                   y = 0,
                   col = col,
                   stringsAsFactors = FALSE)

  colors <- df$col
  names(colors) <- df$col

  df_sel <- data.frame(C = C, H = H, L = L, y = 0)

  ggplot2::ggplot(df, ggplot2::aes(H, y, fill = col)) + ggplot2::geom_raster(interpolate = TRUE, na.rm = TRUE) +
    ggplot2::geom_point(data = df_sel, ggplot2::aes(H, y),
                        inherit.aes = FALSE, size = 5, color = "black", fill = sel_col,
                        shape = 21) +
    ggplot2::scale_fill_manual(values = colors, guide = "none") +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::ylab("H") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_text(angle = 0, vjust = 0.5, size = 14),
                   axis.text.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank(),
                   panel.grid.minor.y = ggplot2::element_blank())
}

color_picker_L_gradient <- function(L, C = 20, H = 0, n = 40) {
  Lseq = seq(0, 100, length.out = n)
  col <- hex(polarLUV(Lseq, C, H))
  sel_col <- hex(polarLUV(L, C, H))

  df <- data.frame(L = Lseq,
                   y = 0,
                   col = col,
                   stringsAsFactors = FALSE)

  colors <- df$col
  names(colors) <- df$col

  df_sel <- data.frame(C = C, H = H, L = L, y = 0)

  ggplot2::ggplot(df, ggplot2::aes(L, y, fill = col)) + ggplot2::geom_raster(interpolate = TRUE, na.rm = TRUE) +
    ggplot2::geom_point(data = df_sel, ggplot2::aes(L, y),
                        inherit.aes = FALSE, size = 5, color = "black", fill = sel_col,
                        shape = 21) +
    ggplot2::scale_fill_manual(values = colors, guide = "none") +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::ylab("L") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_text(angle = 0, vjust = 0.5, size = 14),
                   axis.text.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank(),
                   panel.grid.minor.y = ggplot2::element_blank())
}

