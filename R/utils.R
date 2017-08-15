# a function that simply returns its argument
passthrough <- function(x) x

# a function that stops without creating an error message
stop_quietly <- function() {
  opt <- options(show.error.messages = FALSE)
  on.exit(options(opt))
  stop()
}
