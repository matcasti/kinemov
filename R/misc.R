#' @title Transform angles to their complement angle
#' @name complement_angle
#'
#' @param x Numeric. Angles to transform into their complement respective to `ref`
#' @param ref Numeric. Number from which to take the complement.
#'
#' @return Numeric vector of complements.
#'
#' @export

complement_angle <- function(x, ref = 180) {
  if(!is.numeric(x)) stop("\"x\" needs to be numeric")
  if(!is.numeric(ref) || length(ref) != 1) stop("\"ref\" needs to be numeric of length 1")
  out <- ref - x
  return(out)
}

#' @title Transform radians to degrees
#' @name to_degrees
#'
#' @param x Numeric. Radians to transform to degrees.
#'
#' @return Numeric vector.
#'
#' @export

to_degrees <- function(x) {
  if(!is.numeric(x)) stop("\"x\" needs to be numeric")
  out <- x * 180 / pi
  return(out)
}

#' @title Transform degrees to radians
#' @name to_radians
#'
#' @param x Numeric. Degrees to transform to radians.
#'
#' @return Numeric vector.
#'
#' @export

to_radians <- function(x) {
  if(!is.numeric(x)) stop("\"x\" needs to be numeric")
  out <- x * pi / 180
  return(out)
}

