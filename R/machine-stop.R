#' Stop a machine
#'
#' Gracefully stop a machine.
#'
#' @inheritParams machine_ip
#'
#' @export
machine_stop <- function(machine) {
  UseMethod("machine_stop")
}

#' @export
machine_stop.character <- function(machine) {
  machine_command("stop", machine = machine)
}

#' @export
machine_stop.machine <- function(machine) {
  machine_stop(get_machine_name(machine))
}
