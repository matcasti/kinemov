test_that("calculate_angles_for_track works correctly", {
  # Create sample data
  track_data <- data.frame(
    x = c(1, 2, 3, 4, 5),
    y = c(1, 2, 1, 2, 1)
  )

  # Calculate angles
  angles <- calculate_angles_for_track(track_data, "x", "y")

  # Expected results
  expected_angles <- c(NA, -90, 90, -90, NA)

  # Check if the angles are as expected (within a tolerance)
  expect_equal(angles, expected_angles, tolerance = 1e-6)

  # Test with insufficient points
  track_data_insufficient <- data.frame(
    x = c(1, 2),
    y = c(1, 2)
  )
  angles_insufficient <- calculate_angles_for_track(track_data_insufficient, "x", "y")
  expect_equal(angles_insufficient, c(NA, NA))

  # Test with missing column names
  expect_error(calculate_angles_for_track(track_data, "a", "b"), "x and y must be valid column names in track_data")

  # Test with incorrect data type
  expect_error(calculate_angles_for_track(list(a = 1, b = 2), "x", "y"), "track_data must be a data frame")
})
