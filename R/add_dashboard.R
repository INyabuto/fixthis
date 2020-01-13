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
