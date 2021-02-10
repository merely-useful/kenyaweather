#' Weather Summary
#'
#' @description Function to create a weather table yearly summary for a given city
#' @param city A string of the name of the city to be reported on
#' @returns A knitr::kable table showcasing the yearly summaries of 4 different variables;
#' precipitation, average temperature, maximum temperature, minimum temperature.
weather_summary <- function(city){
  city_filter <- stringr::str_to_upper(city)

  city_data <- weather_data %>%
    dplyr::filter(name == city_filter) %>%
    tidyr::pivot_longer(cols = prcp:tmin,
                        names_to = "variable",
                        values_to = "value")

  yearly_stats <- city_data %>%
    dplyr::mutate(year = lubridate::year(date)) %>%
    dplyr::group_by(year, variable) %>%
    dplyr::summarise(avg = mean(value, na.rm = T)) %>%
    tidyr::pivot_wider(id_cols = "year", names_from = "variable", values_from = "avg") %>%
    dplyr::ungroup()

  #### The code enclosed by these comments needs improvement ####
  max_prcp <- dplyr::filter(yearly_stats, prcp == max(prcp))$year
  max_tavg <- dplyr::filter(yearly_stats, tavg == max(tavg))$year
  max_tmax <- dplyr::filter(yearly_stats, tmax == max(tmax))$year
  max_tmin <- dplyr::filter(yearly_stats, tmin == max(tmin))$year

  min_prcp <- dplyr::filter(yearly_stats, prcp == min(prcp))$year
  min_tavg <- dplyr::filter(yearly_stats, tavg == min(tavg))$year
  min_tmax <- dplyr::filter(yearly_stats, tmax == min(tmax))$year
  min_tmin <- dplyr::filter(yearly_stats, tmin == min(tmin))$year

  avg_prcp <- dplyr::summarize(yearly_stats, variable = mean(prcp))$variable
  avg_tavg <- dplyr::summarize(yearly_stats, variable = mean(tavg))$variable
  avg_tmax <- dplyr::summarize(yearly_stats, variable = mean(tmin))$variable
  avg_tmin <- dplyr::summarize(yearly_stats, variable = mean(tmax))$variable

  sd_prcp <- dplyr::summarize(yearly_stats, variable = sd(prcp))$variable
  sd_tavg <- dplyr::summarize(yearly_stats, variable = sd(tavg))$variable
  sd_tmax <- dplyr::summarize(yearly_stats, variable = sd(tmin))$variable
  sd_tmin <- dplyr::summarize(yearly_stats, variable = sd(tmax))$variable

  #### The code enclosed by these comments needs improvement ####

  summary_table <- tibble::tribble(
    ~variable, ~precipitation, ~average_temp, ~max_temp, ~min_tmp,
    "Maximum Year", max_prcp, max_tavg, max_tmax, max_tmin,
    "Minimum Year", min_prcp, min_tavg, min_tmax, min_tmin,
    "Average across Years", avg_prcp, avg_tavg, avg_tmax, avg_tmin,
    "Standard Deviation across Years", sd_prcp, sd_tavg, sd_tmax, sd_tmin,
  )

  knitr::kable(summary_table, "simple")

}

