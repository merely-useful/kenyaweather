#' City Filter
#'
#' @description Function to filter by city
#'
#' @param city A string of the name of the city to be reported on
#'
#' @returns A tibble with the data for that city
#'

city_filter <- function(city){
  city_filter <- stringr::str_to_upper(city)

  city_data <- weather_data %>%
    dplyr::filter(name == city_filter)

  return(city_data)
}
