test_that("Returns knitr_kable", {
  expect_equal(class(weather_summary("Mombasa")), "knitr_kable")
})

test_that("Fails for city not in dataset", {
  expect_error(weather_summary("San Juan"))
})
