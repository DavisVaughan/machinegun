#' List all docker-machine instances
#'
#' @export
machine_ls <- function(...) {
  machine_command("ls", ...)
}
