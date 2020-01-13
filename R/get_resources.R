#' Retrieve a resource
#'
#' This is function pulls a resource at PSI - MIS web API. It returns a list the
#' content, path, and the response.
#'
#' @param url a character string (or more extended vector, e.g., for the
#'   "libcurl." method) naming the base URL of the server.
#' @param type a character string with the name of a resource to pull. e.g data
#'   elements, maps, charts. By default it will retrieves all the resource end
#'   points available at PSI - MIS.
#' @param id a character string, the id of a specific resource to pull.
#' @param ... allow additional arguments to be passed. Example a filter, or a
#'   query.
#' @return an S3 type object with the content of the resource, path and the
#'   response
#' @export
get_resources <- function(url = "", type = NULL, id = NULL, ...){

  if (is_baseurl(url)){
    url <- modify_url(construct_url(url, type, id), ...)
    httr::GET(url,
              .fixthis_ua) -> res
  }

  # returned a json?
  check_content(res)

  jsonlite::fromJSON(
    content(res,'text')
    ) -> parsed


  # evaluate the status returned
  check_status(res, parsed)

  structure(
    list(content = parsed,
         path = url,
         response = res),
    class = "get_resources"
  )

}

#' @export
print.get_resources <- function(x, ...){
  cat("<fixthis ", x$path, ">\n", sep = "")
 # cat("response: ", response, "\n", sep = "")
  str(x$content)
  invisible(x)
}


#' construct url
#' @importFrom httr modify_url
#' @export
construct_url <- function(url = "", type = NULL, id = NULL, ...){

  if (nchar(url) == 0){
    stop("Please specify the base or a server URL", call. = FALSE)
  }

  if (is.null(type) && is.null(id)){
    type <- "resources"
    url <- paste0(url,"api/", type)
  } else if (!is.null(type) && !is.null(id)){
    url <- paste0(url,"api/", api_version(), "/", type, "/", id)
  } else if (!is.null(type) && is.null(id)){
    url <- paste0(url,"api/", api_version(), "/", type)
  } else{
    stop("resource type must not be null")
  }

  url <- URLencode(modify_url(url, ...))

  url
}
