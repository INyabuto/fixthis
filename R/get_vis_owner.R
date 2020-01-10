#' Get the owner of a visualization
#'
#' This function gets the owner of a visualization. it's used in the
#' \code{dash_builders} to extract a list of dashboard collaborators
#'
#' @param dashboardItem A data frame with visualization ids.
#' @param type A character vector indicating the type of visualization. Example;
#'   maps, charts or reportTables.
#' @param server A character vector specifying the server URL.
#' @param ... Additional parameters passed to get_resources API.
#' @return A list of user names and ids.
#' @export
get_vis_owner <- function(visual, type, server){

  if (has_multiple_ids(visual)){

    query <- paste0("filter=id:in:[", gsub(" ","",toString(vis_ids(visual))), "]&fields=user[name,id]")
    ids <- NULL

    if (type == "maps"){

      d <- get_resources(server, type = "maps", id = ids, query = query)
      user <- unique(d$content$maps$user)


    }

    if (type == "charts"){

      d <- get_resources(server, type = "charts",id = ids, query = query)
      user <- unique(d$content$charts$user)

    }

    if (type == "reportTables"){

      d <- get_resources(server, type = "reportTables", id = ids, query = query)
      user <- unique(d$content$reportTables$user)

    }

  }

  if (!has_multiple_ids(visual)){

    query <- paste0("fields=user[name,id]")
    ids <- vis_ids(visual)

    if (type == "maps"){

      d <- get_resources(server, type = "maps", id = ids, query = query)
      user <- d$content$user

    }

    if (type == "charts"){

      d <- get_resources(server, type = "charts",id = ids, query = query)
      user <- d$content$user

    }

    if (type == "reportTables"){

      d <- get_resources(server, type = "reportTables", id = ids, query = query)
      user <- d$content$user

    }


  }


  as.list(user)


}
