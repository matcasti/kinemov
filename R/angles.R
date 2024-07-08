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
  # Check for valid input data
  if (!is.data.frame(track_data)) stop("track_data must be a data frame")
  if (!(x %in% names(track_data) && y %in% names(track_data))) stop("x and y must be valid column names in track_data")
  if (nrow(track_data) < 3) return(rep(NA, nrow(track_data)))  # Not enough points to calculate angles

  n <- nrow(track_data)
  angles <- rep(NA, n)  # Pre-allocate the angles vector

  # Extract coordinates
  x_coords <- track_data[[x]]
  y_coords <- track_data[[y]]

  # Calculate differences between consecutive points
  dx <- diff(x_coords)
  dy <- diff(y_coords)

  # Calculate vectors for points 1:(n-2), 2:(n-1), and 3:n
  u_x <- dx[1:(n-2)]
  u_y <- dy[1:(n-2)]
  v_x <- dx[2:(n-1)]
  v_y <- dy[2:(n-1)]

  # Calculate dot products and magnitudes
  dot_products <- u_x * v_x + u_y * v_y
  magnitudes_u <- sqrt(u_x^2 + u_y^2)
  magnitudes_v <- sqrt(v_x^2 + v_y^2)

  # Calculate cross products to determine the sign of the angle
  cross_products <- u_x * v_y - u_y * v_x

  # Calculate cosine of angles, handle numerical issues
  cos_theta <- pmin(1, pmax(-1, dot_products / (magnitudes_u * magnitudes_v)))

  # Calculate angles in radians
  angles_rad <- acos(cos_theta)

  # Determine the sign of the angle
  angles_signed <- angles_rad * sign(cross_products)

  # Convert angles to degrees
  angles[2:(n - 1)] <- to_degrees(angles_signed)

  return(angles)
}

