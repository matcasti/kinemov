#' @title Visualize the motion capture across frames
#' @name plot_motion
#'
#' @param data Dataset with motion capture data.
#' @param x Unquoted variable name of the x coordinate variable.
#' @param y Unquoted variable name of the y coordinate variable.
#' @param frames Unquoted variable name with the frame ids for each joint.
#'
#' @return ggplot2 object
#' @import ggplot2
#'
#' @export

plot_motion <- function(data, x, y, frames) {
  ggplot2::ggplot(data, ggplot2::aes({{x}}, -{{y}}, group = {{frames}}, col = {{frames}})) +
    ggplot2::geom_path() +
    ggplot2::geom_point(show.legend = F) +
    ggplot2::labs(x = "X-Coordinates", y = "Y-Coordinates", col = "Frame") +
    ggplot2::scale_y_continuous(expand = c(0,0))
}

#' @title Visualize the angles between joints across frames
#' @name plot_degrees
#'
#' @param data Dataset with motion capture data.
#' @param x Unquoted variable name of the x coordinate variable.
#' @param y Unquoted variable name of the y coordinate variable.
#' @param joint_ids Unquoted variable name with the joint ids.
#' @param frames Unquoted variable name with the frame ids for each joint.
#' @param plot Logical. Wheather to obtain the plot (TRUE) or the data with angle measurements (F).
#'
#' @return ggplot2 object
#' @import ggplot2
#'
#' @export

plot_degrees <- function(data, x, y, joint_ids, frames, plot = TRUE) {

  data$angle <- NA
  x_var <- deparse(substitute(x))
  y_var <- deparse(substitute(y))
  joint_var <- deparse(substitute(joint_ids))
  frame_var <- deparse(substitute(frames))

  unique_tids <- unique(data[[frame_var]])

  for (tid in unique_tids) {
    data[data[[frame_var]] == tid, "angle"] <- calculate_angles_for_track(data[data[[frame_var]] == tid,], x_var, y_var)
  }

  if(!plot) return(data)

  # Plot the data using ggplot2
  ggplot2::ggplot(data = data[data$angle != 0,],
                  mapping = ggplot2::aes(x = .data[[frame_var]]/max(.data[[frame_var]]), y = angle, col = .data[[frame_var]])) +
    ggplot2::facet_grid(ggplot2::vars(.data[[joint_var]]), scales = "free_y") +
    ggplot2::geom_point(na.rm = T) +
    ggplot2::geom_line(na.rm = T) +
    ggplot2::labs(y = "Angle", x = "Gait Phase", col = "Frame") +
    ggplot2::scale_y_continuous(expand = c(0,0,.1,0), n.breaks = 5)
}
