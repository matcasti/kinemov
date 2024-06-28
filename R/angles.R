#' @title Calculate Angle Between Two Vectors
#' @name calculate_angle
#'
#' @param u Numeric vector representing the first vector.
#' @param v Numeric vector representing the second vector.
#'
#' @return Numeric value representing the angle in degrees.
#'
#' @export

calculate_angle <- function(u, v) {
  dot_product <- sum(u * v)
  magnitude_u <- sqrt(sum(u^2))
  magnitude_v <- sqrt(sum(v^2))
  cos_theta <- dot_product / (magnitude_u * magnitude_v)
  angle <- acos(cos_theta) * 180 / pi
  return(angle)
}

#' @title Calculate Angles for a Track
#' @name calculate_angles_for_track
#'
#' @param track_data Data frame containing the track data with columns 'x' and 'y'
#' @param x The colum name with the x-coordinates of the 2D motion capture
#' @param y The colum name with the y-coordinates of the 2D motion capture
#'
#' @return Numeric vector of angles for the track.
#'
#' @export

calculate_angles_for_track <- function(track_data, x, y) {
  n <- nrow(track_data)
  angles <- numeric(n)
  for (i in 2:(n - 1)) {
    p1 <- track_data[i - 1, c(x, y)]
    p2 <- track_data[i, c(x, y)]
    p3 <- track_data[i + 1, c(x, y)]

    u <- as.numeric(p2 - p1)
    v <- as.numeric(p3 - p2)

    angles[i] <- calculate_angle(u, v)
  }
  return(angles)
}
