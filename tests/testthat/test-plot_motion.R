test_that("plot_motion generates a ggplot object", {
  # Create sample data
  sample_data <- data.frame(
    x = c(1, 2, 3, 4, 5, 1+1, 2+2, 3+3, 4+4, 5+5),
    y = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2),
    frames = rep(1:5, 2)
  )

  # Generate the plot
  plot <- plot_motion(sample_data, x, y, frames)

  # Check if the output is a ggplot object
  expect_s3_class(plot, "ggplot")
})

test_that("plot_degrees generates a ggplot object and calculates angles correctly", {
  # Create sample data
  sample_data <- data.frame(
    x = c(1, 2, 3, 4, 5, 1+1, 2+2, 3+3, 4+4, 5+5, 1, 2, 3, 4, 5),
    y = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3),
    joint_ids = rep(1:3, each = 5),
    frames = rep(1:5, 3)
  )

  # Generate the plot
  plot <- plot_degrees(sample_data, x, y, joint_ids, frames, inv_joint_angles = c("1", "3"), smooth = "loess", span = 1)

  # Check if the output is a ggplot object
  expect_s3_class(plot, "ggplot")

  # Check if the angles are calculated correctly
  angle_data <- plot_degrees(sample_data, x, y, joint_ids, frames, plot = FALSE)
  expect_true("angle" %in% names(angle_data))

  # Check the angle values
  expected_angles <- c(NA, NA, NA, NA, NA, 90, 126.8, 143.1,
                       151.9, 157.3, NA, NA, NA, NA, NA)
  expect_equal(angle_data$angle, expected_angles, tolerance = 1e-3)
})

test_that("plot_degrees returns data with angle measurements when plot is FALSE", {
  # Create sample data
  sample_data <- data.frame(
    x = c(1, 2, 3, 4, 5, 1+1, 2+2, 3+3, 4+4, 5+5, 1, 2, 3, 4, 5),
    y = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3),
    joint_ids = rep(1:3, each = 5),
    frames = rep(1:5, 3)
  )

  # Get the angle data
  angle_data <- plot_degrees(sample_data, x, y, joint_ids, frames, plot = FALSE)

  # Check if the output is a data frame
  expect_s3_class(angle_data, "data.frame")

  # Check if the angle column exists
  expect_true("angle" %in% names(angle_data))
})

test_that("plot_degrees fails when inv_joint_angles are not in data", {
  # Create sample data
  sample_data <- data.frame(
    x = c(1, 2, 3, 4, 5, 1+1, 2+2, 3+3, 4+4, 5+5, 1, 2, 3, 4, 5),
    y = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3),
    joint_ids = rep(1:3, each = 5),
    frames = rep(1:5, 3)
  )

  # Get the angle data
  expect_error(plot_degrees(sample_data, x, y, joint_ids, frames, inv_joint_angles = c("1", "4")), 'One or more "inv_joint_angles" ids are not present in the data')
})

test_that("plot_degrees fails when smooth are not in the selected options", {
  # Create sample data
  sample_data <- data.frame(
    x = c(1, 2, 3, 4, 5, 1+1, 2+2, 3+3, 4+4, 5+5, 1, 2, 3, 4, 5),
    y = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3),
    joint_ids = rep(1:3, each = 5),
    frames = rep(1:5, 3)
  )

  # Get the angle data
  expect_error(plot_degrees(sample_data, x, y, joint_ids, frames, smooth = "lm"), '"smooth" must be one of "gam" or "spline".')
})
