append_symbol <- function(env, x, package) {
  env[[x]] <- get(x, paste0("package:", package))
}

create_safe_environment <- function(dplyr = FALSE, plot = FALSE) {
  safe_env <- new.env(parent = emptyenv())
  append_base_operations(safe_env)
  if (dplyr)
    append_dplyr_operations(safe_env)
  if (plot)
    append_plot(safe_env)
  safe_env
}