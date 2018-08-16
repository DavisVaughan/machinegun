#' Query the IP of a machine instance or cluster
#'
#' @param machine \[`character`, `machine`]\cr A `machine`, or `character` vector
#' of machine names.
#'
#' @export
machine_ip <- function(machine) {
  UseMethod("machine_ip")
}

#' @export
machine_ip.character <- function(machine) {

  # Based on how processx outputs stdout/stderr, this is the cleanest user
  # facing interface.
  status <- try(
    expr = {
      machine_command("ip", machine = machine, echo = FALSE)
    },

    silent = TRUE
  )

  if(inherits(status, "try-error")) {
    condition <- attr(status, "condition")
    stop(condition[["stderr"]], call. = FALSE)
  }

  clean_ip(status[["stdout"]])
}

#' @export
machine_ip.machine <- function(machine) {
  machine_ip(get_machine_name(machine))
}

clean_ip <- function(x) {
  unlist(strsplit(x, "\\n"))
}
