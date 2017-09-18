#' Shiny app to pick colors in HCL space
#'
#' @examples
#' \dontrun{
#' HCL_color_picker()
#' }
#' @export
#' @importFrom colorspace polarLUV LUV hex coords hex2RGB
#' @importFrom methods as
#' @author Claus O. Wilke wilke@austin.utexas.edu
#' @author Douglas C. Wu @wckdouglas (color-palette feature)
HCL_color_picker <- function() {
  app <- shiny::shinyApp(ui = color_picker_UI(), server = color_picker_Server())
  shiny::runApp(app)
}

color_picker_UI <- function() {
  shiny::fluidPage(

    # application title
    shiny::titlePanel("HCL color picker"),

    shiny::sidebarLayout(
      # sidebar panel, defined below
      color_picker_sidebarPanel(),

      # main panel, defined below
      color_picker_mainPanel()
    )
  )
}

color_picker_sidebarPanel <- function() {
  # sidebar with controls to select the color
  shiny::sidebarPanel(
    shiny::sliderInput("H", "Hue",
                       min = 0, max = 360, value = 60),
    shiny::sliderInput("C", "Chroma",
                       min = 0, max = 180, value = 40),
    shiny::sliderInput("L", "Luminance",
                       min = 0, max = 100, value = 60),
    shiny::splitLayout(
      shiny::textInput("hexcolor", "RGB hex color", hex(polarLUV(60, 40, 60))),
      shiny::div(class = 'form-group shiny-input-container',
        shiny::actionButton("set_hexcolor", "Set")
      ),
      cellWidths = c("70%", "30%"),
      cellArgs = list(style = "vertical-align: bottom;")
    ),
    shiny::htmlOutput("colorbox"),
    shiny::actionButton("color_picker", "Pick"),
    shiny::actionButton("color_unpicker", "Unpick"),
    shiny::actionButton("clear_color_picker", "Clear palette")
  )
}


color_picker_mainPanel <- function() {
  shiny::mainPanel(
    shiny::tabsetPanel(type = "tabs",
      shiny::tabPanel("Luminance-Chroma plane",
        shiny::plotOutput("LC_plot", click = "LC_plot_click"),
        shiny::plotOutput("Hgrad", click = "Hgrad_click", height = "50px"),
        shiny::plotOutput("Cgrad", click = "Cgrad_click", height = "50px"),
        shiny::plotOutput("Lgrad", click = "Lgrad_click", height = "50px")
      ),
      shiny::tabPanel("Hue-Chroma plane",
        shiny::plotOutput("HC_plot", click = "HC_plot_click"),
        shiny::plotOutput("Hgrad2", click = "Hgrad_click", height = "50px"),
        shiny::plotOutput("Cgrad2", click = "Cgrad_click", height = "50px"),
        shiny::plotOutput("Lgrad2", click = "Lgrad_click", height = "50px")
      )
    ),
    shiny::br(),
    shiny::h3("Color palette"),
    shiny::plotOutput("palette_plot", click = "palette_click", height = "50px"),
    shiny::textOutput("palette_line")
  )
}


color_picker_Server <- function() {
  shiny::shinyServer(function(input, output, session) {

    picked_color_list <- shiny::reactiveValues(cl=c())
    shiny::observeEvent({input$HC_plot_click}, {
      # store the old colors
      coords_old_LUV <- coords(as(polarLUV(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H)), "LUV"))
      U <- input$HC_plot_click$x
      if (is.null(U)) U <- coords_old_LUV[2L]
      V <- input$HC_plot_click$y
      if (is.null(V)) V <- coords_old_LUV[3L]
      L <- input$L
      coords_HCL <- coords(as(LUV(L, U, V), "polarLUV"))
      shiny::updateSliderInput(session, "C", value = round(coords_HCL[2L]))
      shiny::updateSliderInput(session, "H", value = round(coords_HCL[3L]))
    })

    shiny::observeEvent({input$LC_plot_click}, {
      # store the old colors
      Lold <- as.numeric(input$L)
      Cold <- as.numeric(input$C)
      C <- input$LC_plot_click$x
      if (is.null(C)) C <- Cold
      L <- input$LC_plot_click$y
      if (is.null(L)) L <- Lold
      shiny::updateSliderInput(session, "C", value = round(C))
      shiny::updateSliderInput(session, "L", value = round(L))
    })

    shiny::observeEvent({input$palette_click}, {
      x <- input$palette_click$x
      if (is.null(x)) return()
      i <- ceiling(x*length(picked_color_list$cl))
      col_RGB <- hex2RGB(picked_color_list$cl[i])
      coords_HCL <- coords(as(col_RGB, "polarLUV"))
      shiny::updateSliderInput(session, "L", value = round(coords_HCL[1L]))
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

    shiny::observeEvent({input$set_hexcolor}, {
      # only execute this on complete color hex codes
      if (grepl("^#[0123456789ABCDEFabcdef]{6}$", input$hexcolor)) {
          col_RGB <- hex2RGB(input$hexcolor)
          coords_HCL <- coords(as(col_RGB, "polarLUV"))
          shiny::updateSliderInput(session, "L", value = round(coords_HCL[1L]))
          shiny::updateSliderInput(session, "C", value = round(coords_HCL[2L]))
          shiny::updateSliderInput(session, "H", value = round(coords_HCL[3L]))
      }
    })

    # save color code
    observeEvent(input$color_picker, {
      shiny::validate(
        shiny::need(match(input$hexcolor,
                          picked_color_list$cl,
                          nomatch = 0) == 0 ,
                    'Hex color already in color list')
      )
      picked_color_list$cl <- c(picked_color_list$cl, input$hexcolor)
    })

    # undo pick color
    observeEvent(input$color_unpicker, {
      if (input$hexcolor %in% picked_color_list$cl){
        picked_color_list$cl <- picked_color_list$cl[picked_color_list$cl != input$hexcolor]
      }else{
        # It's a better user interface to leave the list alone if the color is not in the list
        # picked_color_list$cl <- head(picked_color_list$cl,-1)
      }
    })

    # clear saved color code
    observeEvent(input$clear_color_picker, {
      picked_color_list$cl <- c()
    })

    shiny::observe({
      shiny::updateTextInput(session, "hexcolor", value = hex(polarLUV(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))))
    })

    output$colorbox <- shiny::renderUI({
      shiny::tags$div(style=paste0("width: 100%; height: 40px; border: 1px solid rgba(0, 0, 0, .2); background: ",
                     hex(polarLUV(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))), ";"))
    })

    # generate HC plot with given inputs
    output$HC_plot <- shiny::renderPlot({
      color_picker_hue_chroma_plot(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    # generate LC plot with given inputs
    output$LC_plot <- shiny::renderPlot({
      color_picker_luminance_chroma_plot(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })


    output$Hgrad <- shiny::renderPlot({
      color_picker_H_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    output$Hgrad2 <- shiny::renderPlot({
      color_picker_H_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    output$Cgrad <- shiny::renderPlot({
      color_picker_C_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    output$Cgrad2 <- shiny::renderPlot({
      color_picker_C_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })


    output$Lgrad <- shiny::renderPlot({
      color_picker_L_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    output$Lgrad2 <- shiny::renderPlot({
      color_picker_L_gradient(as.numeric(input$L), as.numeric(input$C), as.numeric(input$H))
    })

    # generate palette plot with given hex code
    output$palette_plot <- shiny::renderPlot({
      if (length(picked_color_list$cl) != 0){
        palette_plot(picked_color_list$cl)
      }
    })

    # add R color code line
    output$palette_line <- shiny::renderText({
      if (length(picked_color_list$cl) != 0){
        color_list <- picked_color_list$cl
        color_list <- paste(color_list, collapse = "', '")
        color_string <- paste("Color list: c('", color_list, "')", sep = '')
        color_string
      }else{
        'Color list: N/A'
      }
    })
  })
}


color_picker_hue_chroma_plot <- function(L = 75, C = 20, H = 0, n = 200) {
  Cmax <- max(colorspace::max_chroma(0:360, L))
  Vmax <- Cmax
  Umax <- Cmax
  U <- seq(-Umax, Umax, length.out = n)
  V <- seq(Vmax, -Vmax, length.out = n)
  grid <- expand.grid(U = U, V = V)
  image <- matrix(hex(LUV(L, grid$U, grid$V)), nrow = n, byrow = TRUE)
  grob <- grid::rasterGrob(image)

  sel_col <- polarLUV(L, C, H) # selected color in polar LUV
  sel_pt <- coords(as(sel_col, "LUV")) # coordinates of selected point in LUV
  df_sel <- data.frame(U = sel_pt[2L], V = sel_pt[3L])

  ggplot2::ggplot(df_sel, ggplot2::aes(U, V)) + ggplot2::annotation_custom(grob) +
    ggplot2::geom_point(size = 5, color = cursor_color(L), fill = hex(sel_col), shape = 21) +
    ggplot2::annotate("path",
                      x=C*cos(seq(0, 2*pi, length.out=100)),
                      y=C*sin(seq(0, 2*pi, length.out=100)), color = cursor_color(L), size = 0.2, alpha = 0.5) +
    ggplot2::coord_fixed(xlim = c(-Umax, Umax), ylim = c(-Vmax, Vmax), expand = FALSE) +
    ggplot2::theme_minimal()
}

color_picker_luminance_chroma_plot <- function(L = 75, C = 20, H = 0, n = 200) {
  Cmax <- max(C + 5, 150)
  Cseq <- seq(0, Cmax, length.out = n)
  Lseq <- seq(100, 0, length.out = n)
  grid <- expand.grid(C = Cseq, L = Lseq)
  image <- matrix(hex(polarLUV(grid$L, grid$C, H)), nrow = n, byrow = TRUE)
  grob <- grid::rasterGrob(image, width = 1, height = 1)

  sel_col <- polarLUV(L, C, H) # selected color in polar LUV
  df_sel <- data.frame(C = C, L = L)

  ggplot2::ggplot(df_sel, ggplot2::aes(C, L)) + ggplot2::annotation_custom(grob) +
    ggplot2::geom_point(size = 5, color = cursor_color(L), fill = hex(sel_col), shape = 21) +
    ggplot2::coord_fixed(xlim = c(0, Cmax), ylim = c(0, 100), expand = FALSE) +
    ggplot2::theme_minimal()
}



color_picker_C_gradient <- function(L = 75, C = 20, H = 0, n = 100) {
  Cmax <- max(C + 5, 150)
  Cseq <- seq(0, Cmax, length.out = n)
  image <- matrix(hex(polarLUV(L, Cseq, H)), nrow = 1, byrow = TRUE)
  grob <- grid::rasterGrob(image, width = 1, height = 1)

  sel_col <- hex(polarLUV(L, C, H))
  df_sel <- data.frame(C = C, H = H, L = L, y = 0)

  y <- 0 # dummy assignment to make CRAN check happy
  ggplot2::ggplot(df_sel, ggplot2::aes(C, y)) + ggplot2::annotation_custom(grob) +
    ggplot2::geom_point(size = 5, color = cursor_color(L), fill = sel_col, shape = 21) +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::scale_x_continuous(limits = c(0, Cmax), expand = c(0, 0)) +
    ggplot2::ylab("C") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_text(angle = 0, vjust = 0.5, size = 14),
                   axis.text.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank(),
                   panel.grid.minor.y = ggplot2::element_blank(),
                   plot.margin = ggplot2::margin(3, 20, 3, 0))
}

color_picker_H_gradient <- function(L = 75, C = 20, H = 0, n = 100) {
  Hseq = seq(0, 360, length.out = n)
  image <- matrix(hex(polarLUV(L, C, Hseq)), nrow = 1, byrow = TRUE)
  grob <- grid::rasterGrob(image, width = 1, height = 1)

  sel_col <- hex(polarLUV(L, C, H))
  df_sel <- data.frame(C = C, H = H, L = L, y = 0)

  y <- 0 # dummy assignment to make CRAN check happy
  ggplot2::ggplot(df_sel, ggplot2::aes(H, y)) + ggplot2::annotation_custom(grob) +
    ggplot2::geom_point(size = 5, color = cursor_color(L), fill = sel_col, shape = 21) +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::scale_x_continuous(limits = c(0, 360), expand = c(0, 0)) +
    ggplot2::ylab("H") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_text(angle = 0, vjust = 0.5, size = 14),
                   axis.text.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank(),
                   panel.grid.minor.y = ggplot2::element_blank(),
                   plot.margin = ggplot2::margin(3, 20, 3, 0))
}

color_picker_L_gradient <- function(L = 75, C = 20, H = 0, n = 100) {
  Lseq = seq(0, 100, length.out = n)
  image <- matrix(hex(polarLUV(Lseq, C, H)), nrow = 1, byrow = TRUE)
  grob <- grid::rasterGrob(image, width = 1, height = 1)

  sel_col <- hex(polarLUV(L, C, H))
  df_sel <- data.frame(C = C, H = H, L = L, y = 0)

  y <- 0 # dummy assignment to make CRAN check happy
  ggplot2::ggplot(df_sel, ggplot2::aes(L, y)) + ggplot2::annotation_custom(grob) +
    ggplot2::geom_point(size = 5, color = cursor_color(L), fill = sel_col, shape = 21) +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::scale_x_continuous(limits = c(0, 100), expand = c(0, 0)) +
    ggplot2::ylab("L") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_text(angle = 0, vjust = 0.5, size = 14),
                   axis.text.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank(),
                   panel.grid.minor.y = ggplot2::element_blank(),
                   plot.margin = ggplot2::margin(3, 20, 3, 0))
}

cursor_color <- function(L) {
  ifelse(L >= 50, "#000000", "#FFFFFF")
}

