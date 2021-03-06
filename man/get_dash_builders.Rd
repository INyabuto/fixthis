% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dashboard_builders.R
\name{get_dash_builders}
\alias{get_dash_builders}
\title{Get users developing a dashboard}
\usage{
get_dash_builders(id = NULL, baseurl = "", ...)
}
\arguments{
\item{id}{character, the id of the dashboard}

\item{baseurl}{character, baseurl of the string}

\item{...}{Additional parameters passed to \code{get_resource}}
}
\description{
This function provides a list of users working on a common dashboard. This includes;
collaborators and dashboard owners.
}
