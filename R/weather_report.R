#' Weather Report
#'
#' @description Function to create a weather report for a given city
#'
#' @param city A string of the name of the city to be reported on
#'
#' @returns A gg object with 4 plots showcasing the 4 different variables;
#' precipitation, average temperature, maximum temperature, minimum temperature.
#'
#' @export
#'
weather_report <- function(city){
  city_data <- city_filter(city) %>%
    tidyr::pivot_longer(cols = prcp:tmin,
                        names_to = "variable",
                        values_to = "value")

  city_name <- stringr::str_to_title(city)

  city_data %>%
    ggplot2::ggplot(ggplot2::aes(x = date, y = value)) +
    ggplot2::geom_line() +
    ggplot2::geom_smooth() +
    ggplot2::facet_wrap(~ variable, scales = "free") +
    ggplot2::labs(x = "Date",
                  title = glue::glue("Weather data for {city_name}"))
}
