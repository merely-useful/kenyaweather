library(rnoaa)
library(tidyverse)

country_code <- ghcnd_countries() %>%
  filter(name == "Kenya") %>%
  pull(code)

stations <- ghcnd_stations()

stations_collapsed <- stations %>%
  mutate(
    n_years = last_year - first_year,
    country = str_sub(id, 1, 2)) %>%
  group_by(id, name, country) %>%
  summarise(
    n_years = paste(n_years, collapse = ","),
    elements = paste(element, collapse = ",")
  ) %>%
  arrange(desc(n_years))

country_stations <- stations_collapsed %>%
  filter(country == country_code)

type_of_climate <- list("coastal" = "MOMBASA",
                        "desert" = "LODWAR",
                        "temperate" = "KITALE",
                        "arid" = "MANDERA",
                        "savanna" = "MALINDI")


station_ids <- country_stations %>%
  filter(name %in% unlist(type_of_climate)) %>%
  pull(id)


stations_data <- map_df(station_ids, meteo_tidy_ghcnd)

weather_data <- stations_data %>%
  filter(date >= "2000-01-01") %>%
  left_join({
    country_stations %>%
      filter(name %in% unlist(type_of_climate))
    },
    by = "id") %>%
  select(name, date, prcp, tavg, tmax, tmin)

## code to prepare `weather_data` dataset goes above here

usethis::use_data(weather_data, overwrite = TRUE)
