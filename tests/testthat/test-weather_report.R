test_that("Returns list of plots", {
  expect_type(weather_report("Mombasa"), "list")
})

test_that("Returns a gg object", {
  expect_identical(class(weather_report("Mombasa")), c("gg", "ggplot"))
})

test_that("Faceted plot", {
  expect_true("facet" %in% attributes(weather_report("Mombasa"))$names)
})
