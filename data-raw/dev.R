library(devtools)
library(usethis)
library(desc)

# Remove default description
unlink("DESCRIPTION")

# Create and clean desc
my_desc <- description$new("!new")

# Set your package name
my_desc$set("Package", "fixthis")

#Set your name
my_desc$set("Authors@R", "person('Isaiah', 'Nyabuto', email = 'isaiahnyabuto@gmail.com', role = c('cre', 'aut'))")

# Remove some author fields
my_desc$del("Maintainer")

# Set the version
my_desc$set_version("0.0.0.9000")

# The title of your package
my_desc$set(Title = "Fix Common Issues With PSI-MIS")
# The description of your package
my_desc$set(Description = "Use this to fix commonly known issues at PSI freshdesk.")
# The urls
my_desc$set("URL", "http://this")
my_desc$set("BugReports", "http://that")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, and lifecycle badge
use_mit_license(name = "ISAIAH NYABUTO")
use_code_of_conduct()
use_lifecycle_badge("Experimental")
use_news_md()

# Get the dependencies
use_package("httr")
use_package("jsonlite")
use_package("curl")
use_package("purrr")
use_package("magrittr")

# Clean your description
use_tidy_description()


# users
# baseurl <- "https://clone.psi-mis.org/"
# base <- substr(baseurl,9,25)
# usr <- keyringr::get_kc_account(base, "internet")
# pwd <- keyringr::decrypt_kc_pw(base, "internet")
#
# loginDHIS2 <- function(baseurl, username, password){
#   url <- paste0(baseurl, "api/me")
#   r <- GET(url, authenticate(username, password))
#   assertthat::assert_that(r$status_code == 200)
# }

# set up roxygen for documentation
use_roxygen_md()

# top level file for package doc
use_package_doc()

# run documentaion
devtools::document()

# passing the tests
usethis::use_testthat()

usethis::use_test("placeholder")


# set up git
use_git()
git_vaccinate()
usethis::use_readme_md()
