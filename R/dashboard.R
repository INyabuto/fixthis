#' Add a new dashboard
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom httr POST
#' @param name character string, name of the dashboard to add
#' @param baseurl character string, the server to add the dashboard
#' @return S3 object with content, path and the response of the dashboard
#' @export
add_dashboard <- function(name = NULL, baseurl = NULL){

  if (any(c(is.null(name), is.null(baseurl)))) stop("Either one or all required parameters is missing", call. = F)

  check_internet()

  POST(construct_url(baseurl, type = "dashboards"),
       body = toJSON(list(name = name), auto_unbox = TRUE),
       content_type_json()) -> resp

  check_content(resp)

  parsed <- fromJSON(content(resp, "text"))

  check_status(resp, parsed)

  structure(
    list(content = parsed,
         path = construct_url(baseurl, "dashboards"),
         response = resp),
    class = "add_dashboard")
}

#' @export
print.add_dashboard <- function(x, ...){
  cat("<fixthis ", x$path, ">\n")
  cat("Date: ", format(Sys.time()), "\n")
  str(x$content)
}

#' #' add dashboard item
#' #' @rdname add_dashboard
#' #' @export
#' add_dashboard_item <- function(dashboard_id, parsed = list(), baseurl){
#'
#'
#'   query <- paste0("type=", type(names(parsed$content[2])), "&id=", parsed$content[[2]]$id)
#'   # item_type <- paste0("items", type(names(parsed$content[2])), sep = "/")
#'   # item_id <-
#'
#'   # add chart
#'   url <- sapply(query, function(x) construct_url(baseurl, "dashboards", id = dashboard_id, subtype = "items/content", query = x))
#'
#'   names(url) <- NULL
#'
#'   res <- lapply(url, function(x) httr::POST(x))
#'
#'   res
#'
#'   #url <- paste0(construct_url(baseurl, "dashboards", id = rlang::expr(dashboard_id), subtype = "items/content", query = ""), query)
#'
#' }


#' @export
#' @rdname add_dashboard
#' @param parsed A list, content of the unshared visualization.
add_dashboard_items <- function(dashboard_id = "", parsed = list(), baseurl = NULL){


  dashboard_item <- lapply(parsed$content[[2]]$id, function(.x){
    payload <- list(id = generateUID(),
                    type = toupper(type(names(parsed$content[2]))),
                    height = 10,
                    width = 14,
                    vis(type(names(parsed$content[2])), id = .x)
                    )
    unlist(payload, recursive = F)

  })

  #dashboard_item


  url1 <- construct_url(baseurl, type = "metadata", query = "importStrategy=CREATE")

  httr::POST(url1,
             body = toJSON(list(dashboardItems = list(dashboard_item)), auto_unbox = T),
             content_type_json()) -> res


  check_content(res)


  parsed <- fromJSON(content(res, "text"))

  #structure(list(content = parsed, response = res, dashboard_item = dashboard_item), class = "dashboard")

  # Update dashboard

  r <- httr::GET(construct_url(baseurl, "dashboards", id = dashboard_id))

  check_content(r)

  dashboard <- fromJSON(content(r, "text"))

  #dashboard$dashboardItems <- data.frame(id = sapply(dashboard_item, function(.x) .x$id), stringsAsFactors = F)
  dashboard$dashboardItems <- dashboard_item


  httr::POST(construct_url(baseurl, "metadata", query = "importStrategy=CREATE_AND_UPDATE"),
             body = toJSON(list(dashboards = list(dashboard)), auto_unbox = T),
             content_type_json()) -> res2

  check_content(res2)

  parsed <- fromJSON(content(res2, "text"))


  structure(list(content = parsed, `dashboard items` = dashboard_item, response = res2), class = "dashboard")

}

#' @export
print.dashboard <- function(x, ...){
  cat("<fixthis: Add Items to a dashabord\n")
  cat("dashboardItems: ", length(x$dashboard_item), " \n")
  str(x$content)
}



