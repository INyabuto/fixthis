#' Get users developing a dashboard
#'
#' This function provides a list of users working on a dashboard. This includes;
#' collaborators and dashboard owners.
#'
#' @importFrom magrittr %>%
#' @param id character, the id of the dashboard
#' @param baseurl character, baseurl of the string
#' @param ... Additional parameters passed to \code{get_resource}
get_dash_builders <- function(id = NULL, baseurl = "", ...){

  parsed <- get_resources(baseurl, type = "dashboards", id, ...)

  # collaborators
  collab <- list(
    maps = parsed$content$dashboardItems$map %>%
      get_vis_owner(., type = "maps", baseurl),
    charts = parsed$content$dashboardItems$chart %>%
      get_vis_owner(., type = "charts", baseurl),
    tables = parsed$content$dashboardItems$reportTable %>%
      get_vis_owner(., type = "reportTables", baseurl)
  )

  structure(
    list(
      owner = parsed$content$user$id,
      collaborators = collab,
      content = parsed,
      path = parsed$path
    ),
    class = "dash_builders"
  )

}

#' @export
print.dash_builders <- function(x, ...){
  cat("<fixthis dashboard builders: ", x$path, ">\n", sep = "")
  cat("dashboard owner: ", x$owner, "\n", sep = "")
  str(x$collaborators)
  invisible(x)
}

