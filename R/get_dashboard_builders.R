#' Get users developing a dashboard
#'
#' This function provides a list of users working on a common dashboard. This includes;
#' collaborators and dashboard owners.
#'
#' @param id character, the id of the dashboard
#' @param baseurl character, baseurl of the string
#' @param ... Additional parameters passed to \code{get_resource}
get_dash_builders <- function(id = NULL, baseurl = "", ...){

  parsed <- get_resources(baseurl, type = "dashboards", id, ...)

  # collaborators
  collab <- list(
    maps = get_vis_owner(parsed$content$dashboardItems$map, type = "maps", baseurl),
    charts = get_vis_owner(parsed$content$dashboardItems$chart, type = "charts", baseurl),
    tables =  get_vis_owner(parsed$content$dashboardItems$reportTable, type = "reportTables", baseurl)
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

