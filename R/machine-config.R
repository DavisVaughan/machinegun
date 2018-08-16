#' Print the connection configuration for a machine
#'
#' @inheritParams machine_ip
#' @inheritParams machine_command
#'
#' @export
machine_config <- function(machine, ...) {
  UseMethod("machine_config")
}

#' @export
machine_config.character <- function(machine, ...) {
  configs <- lapply(machine, function(x) {
    cat(paste0(x, "\n"))
    config <- machine_command("config", ..., machine = x)
    cat("\n")
    config
  })

  invisible(configs)
}

#' @export
machine_config.machine <- function(machine, ...) {
  machine_config(get_machine_name(machine), ...)
}
