#' Interactively view cvd simulations of a figure or plot
#'
#' @param plot The plot or grid object to view
#' @examples
#' \dontrun{
#' library(ggplot2)
#' plot <- ggplot(iris, aes(Sepal.Length, fill=Species)) +
#'   geom_density(alpha = 0.7)
#' view_cvd(plot)
#' }
#' @export
view_cvd <- function(plot) {
  if (!is.null(grDevices::dev.list())) {
    message("Warning: You have open graphics devices. These will have to be closed before proceeding.")
    response <- readline(prompt="Do you want to close all open graphics devices (y/n)? ")
    if (response == "y" | response == "Y" ) {
      grDevices::graphics.off() # this is needed to get the output redirected to the shiny app
      message("Exiting view_cvd() and closing all graphics devices. Please run view_cvd() again.")
    }
    else {
      message("Exiting view_cvd() and leaving graphics devices open.")
    }
    stop_quietly()
  }
  cvdApp <- shiny::shinyApp(ui = cvdUI(plot), server = cvdServer(plot))
  shiny::runApp(cvdApp)
}

cvdUI <- function(plot) {
  shiny::shinyUI(shiny::pageWithSidebar(

    # application title
    shiny::headerPanel("Color-vision-deficiency simulation"),

    # sidebar panel, defined below
    sidebarPanel(),

    # main panel, defined below
    mainPanel()
  ))
}

sidebarPanel <- function() {
  # sidebar with controls to select the simulation choice
  shiny::sidebarPanel(
    shiny::selectInput("variable", "Simulation type",
                       list("Desaturated",
                            "Deutan (red/green)",
                            "Protan (red/green)",
                            "Tritan (blue/green)",
                            "Original")),
    shiny::sliderInput("sev", "Severity",
                min = 0, max = 1, value = .95)
  )
}


mainPanel <- function() {
  # Show the caption and plot of the requested variable against mpg
  shiny::mainPanel(
    shiny::h3(shiny::textOutput("caption")),

    shiny::plotOutput("plot")
  )
}


cvdServer <- function(plot) {
  shiny::shinyServer(function(input, output) {

    # retrieve the simulation choise in a reactive expression since it is
    # shared by the output$caption and output$plot expressions
    simul_choice <- shiny::reactive({
      input$variable
    })

    # return the simulation option printing as a caption
    output$caption <- shiny::renderText({
      simul_choice()
    })

    # generate plot with modified colors
    output$plot <- shiny::renderPlot({
      # convert simulation choice into function call
      colfun = switch(simul_choice(),
                      `Desaturated` = function(c)
                        desaturate(c, amount = input$sev),

                      # here and below, precalculate matrix for increase
                      # in speed for figures with many colors
                      `Deutan (red/green)` = function(c) {
                        cvd_transform <- deutan_transform(input$sev)
                        simulate_cvd(c, cvd_transform) },

                      `Protan (red/green)`= function(c) {
                        cvd_transform <- protan_transform(input$sev)
                        simulate_cvd(c, cvd_transform) },

                      `Tritan (blue/green)`= function(c) {
                        cvd_transform <- tritan_transform(input$sev)
                        simulate_cvd(c, cvd_transform) },

                      passthrough)

      # draw the modified plot
      grid::grid.draw(edit_colors(plot, colfun = colfun))
    })
  })
}
