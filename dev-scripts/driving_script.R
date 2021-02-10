if (interactive()){
  stop("Dont't run this script, it will break the package")
}
## Create and document weather data

usethis::use_data_raw(name = "weather_data")
usethis::use_r("weather_data")
devtools::document(".")

## Set up pipe
usethis::use_pipe()

## Add weather_summary function
usethis::use_r("weather_summary")
devtools::document(".")

## Add weather_report function
usethis::use_r("weather_report")
devtools::document(".")

## Add weather_weekly_pattern function
usethis::use_r("weather_weekly_pattern")

## Add packages to the DESCRIPTION file
usethis::use_package("tibble")
usethis::use_package("knitr")
usethis::use_package("lubridate")
