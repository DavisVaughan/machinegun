#' Kill a machine
#'
#' Killing a machine abruptly stops it. Using [machine_stop()] and
#' [machine_rm()] is advised instead if possible.
#'
#' @inheritParams machine_ip
#'
#' @export
machine_kill <- function(machine) {
  UseMethod("machine_kill")
}

#' @export
machine_kill.character <- function(machine) {
  machine_command("kill", machine = machine)
}

#' @export
machine_kill.machine <- function(machine) {
  machine_kill(get_machine_name(machine))
}
