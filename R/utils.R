#' @importFrom curl has_internet
#' @noRd
check_internet <- function(){
  if (!has_internet()){
    stop("Please check your internet connection", call. = F)
  }

}

#' @importFrom httr http_error status_code
#' @noRd
check_status <- function(resp, parsed){
  if (http_error(resp)) {
    stop(
      sprintf(
        "PSI - MIS API request failed [%s]\n%s\n<%s>",
        status_code(resp),
        parsed$message,
        "https://docs.dhis2.org/master/en/developer/html/dhis2_developer_manual.html"
      ),
      call. = FALSE
    )
  }

}

#' check the api returned json
#' @importFrom httr http_type
check_content <- function(res){
  if (http_type(res) != "application/json"){
    stop("PSI - MIS did not return json", call. = FALSE)
  }
}

#' @noRd
api_version <- function(version = NULL){

  if (!is.null(version)){
    version <- version
  }

  if (is.null(version)){
    version <- 29
  }

  version
}

#' @importFrom httr status_code
is_baseurl <- function(url = NULL){

  check_internet()

  httr::GET(url, .fixthis_ua) -> res

  identical(status_code(res), 200L)

}

#' checks if the visaulization has muiltiple ids
#'
has_multiple_ids <- function(visual){
  # get the visaualization ids
  ifelse(length(vis_ids(visual)) > 1, TRUE,FALSE)
}

# Pop visualisation ids from a visual (df)
vis_ids <- function(visual){

  if (is.data.frame(visual) && identical(names(visual),'id') ){
    ids <- visual[,'id']
    ids[which(!is.na(ids))]
  }

}
