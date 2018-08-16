#' Run arbitrary docker-machine commands.
#'
#' @param cmd \[`character(1)`]\cr A docker-machine CLI command to run
#' @param ... `[name=value pairs`]\cr Name value pairs of extra options
#' to pass to `cmd`. All option names will be prefixed with `--` before being
#' passed to docker-machine.
#' @param machine `[character: NULL`]\cr The name of the docker-machine
#' to run the command on, if applicable.
#'
#' @export
#' @importFrom processx run
machine_command <- function(cmd, ..., machine = NULL, echo = TRUE) {

  dm <- "docker-machine"

  # Start with `--name value` options
  dots_args <- dots2machineargs(...)

  # Append the command name `cmd --name value`
  cmd_args <- c(cmd, dots_args)

  # Append machine name if applicable `cmd --name value machine`
  if(!is.null(machine)) {
    cmd_args <- c(cmd_args, machine)
  }

  # Debug print
  machine_debug <- getOption("machine_debug", FALSE)
  if(machine_debug) {
    return(paste(shQuote(c(dm, cmd_args)), collapse = " "))
  }

  # The command is technically "docker-machine"
  # run() shQuote's for us, but we need name-value pairs for args
  # to all remain separate elements in the character vector
  status <- run(command = dm, args = cmd_args, echo = echo)

  invisible(status)
}

dots2machineargs <- function(...) {

  dots <- list(...)

  if(length(dots) == 0L) {
    return(character(0))
  }

  dot_names <- paste0("--", names(dots))

  dot_values <- vapply(
    X = dots,
    FUN = as.character,
    FUN.VALUE = character(1)
  )

  if(length(dot_names) != length(dot_values)) {
    stop("All ... arguments must be named.", call. = FALSE)
  }

  # Combine, but each element is kept separate to it can be shQuote'd individually
  # Important for, for example, ls --format "{{.Name}}"
  Reduce("c", Map("c", dot_names, dot_values))
}
