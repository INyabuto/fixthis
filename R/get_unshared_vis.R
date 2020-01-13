#' Get a list of unshared visualization
#'
#' Retrieve unshared visualization (maps, charts and tables) by date.
#'
#' @param owner_id character string, user id to dig.
#' @param type character string, type of visualization. (maps, charts, tables).
#' @param baseurl character string, the server url.
#' @param ... additional parameters passed to \code{get_resources}.
#' @return list with unshared visualization.
#' @export
#' @author Isaiah Nyabuto
get_unshared_vis <- function(owner_id = NULL, type = NULL, baseurl = NULL, paging = TRUE,
                             startsWith = NULL, createdLaterThan = NULL, ...){

  if (any(c(is.null(owner_id), is.null(type), is.null(baseurl)))){
    stop("Either one or all required parameters is missing", call. = FALSE)
  }

  query = paste0("fields=id,name,created", "&filter=user.id:eq:", owner_id, "&filter=userGroupAccesses:empty")

  if (!paging) paste0(query,"&paging=false") -> query

  if (!is.null(startsWith)) paste0(query, "&filter=name:$ilike:", startsWith) -> query

  if (!is.null(createdLaterThan)) paste0(query, "&filter=created:ge:", createdLaterThan) -> query


  if (type == "maps") get_resources(baseurl, "maps", query = query) -> parsed

  if (type == "charts") get_resources(baseurl, "charts", query = query) -> parsed

  if (type == "reportTables") get_resources(baseurl, "reportTables", query = query)

  parsed


}
