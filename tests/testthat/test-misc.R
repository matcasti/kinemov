test_that("complement_angle correctly computes complement angles", {
  # Test case 1: Check complement of angles with default reference (180)
  expect_equal(complement_angle(45), 135)

  # Test case 2: Check complement of angles with custom reference
  expect_equal(complement_angle(30, 360), 330)

  # Test case 3: Check that it throws an error if x is not numeric
  expect_error(complement_angle("abc"), "\"x\" needs to be numeric")

  # Test case 4: Check that it throws an error if ref is not numeric or of length 1
  expect_error(complement_angle(90, "abc"), "\"ref\" needs to be numeric of length 1")
  expect_error(complement_angle(90, c(180, 360)), "\"ref\" needs to be numeric of length 1")
})

test_that("to_degrees correctly converts radians to degrees", {
  # Test case 1: Check conversion of radians to degrees
  expect_equal(to_degrees(pi), 180)

  # Test case 2: Check that it throws an error if x is not numeric
  expect_error(to_degrees("abc"), "\"x\" needs to be numeric")
})

test_that("to_radians correctly converts degrees to radians", {
  # Test case 1: Check conversion of degrees to radians
  expect_equal(to_radians(180), pi)

  # Test case 2: Check that it throws an error if x is not numeric
  expect_error(to_radians("abc"), "\"x\" needs to be numeric")
})
