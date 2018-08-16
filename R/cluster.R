get_machine_name <- function(machine) {
  UseMethod("get_machine_name")
}

get_machine_name.machine <- function(machine) {
  machine[["name"]]
}

get_machine_name.machine_cluster <- function(machine) {
  vapply(machine, get_machine_name, character(1))
}
