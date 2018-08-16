#' Remove a machine
#'
#' This removes the local reference and deletes it on the cloud provider or
#' virtualization management platform.
#'
#' @inheritParams machine_ip
#' @param force \[`logical(1)`]\cr Remove local configuration even if
#' cloud/virtual machine cannot be removed.
#'
#' @export
machine_rm <- function(machine, force = FALSE) {
  UseMethod("machine_rm")
}

#' @export
machine_rm.character <- function(machine, force = FALSE) {

  # The y flag assumes automatic yes to proceed with remove,
  # without prompting further user confirmation

  if(force) {
    machine_command("rm", machine = machine, y = "", force = "")
  } else {
    machine_command("rm", machine = machine, y = "")
  }

}

#' @export
machine_rm.machine <- function(machine, force = FALSE) {
  machine_rm(get_machine_name(machine), force = force)
}
