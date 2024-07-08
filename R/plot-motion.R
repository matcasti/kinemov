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
#' @param inv_joint_angles Character. Levels of the joint_ids to invert the angles (i.e., negative to positive angles and viceversa).
#' @param smooth Character. Method to use to draw a smooth line interpolating the data points. Options are "loess" or "gam". (defaults to NULL).
#' @param ... Further arguments passed to ggplot2::geom_smooth().
#' @param plot Logical. Wheather to obtain the plot (TRUE) or the data with angle measurements (F).
#'
#' @return ggplot2 object
#' @import ggplot2
#'
#' @export

plot_degrees <- function(data, x, y, joint_ids, frames, inv_joint_angles = NULL, smooth = NULL, ..., plot = TRUE) {

  angle <- NULL

  data$angle <- NA
  x_var <- deparse(substitute(x))
  y_var <- deparse(substitute(y))
  joint_var <- deparse(substitute(joint_ids))
  frame_var <- deparse(substitute(frames))

  unique_frames <- unique(data[[frame_var]])
  unique_joints <- unique(data[[joint_var]])

  for (one_frame in unique_frames) {
    ind <- data[[frame_var]] == one_frame
    data[ind, "angle"] <- calculate_angles_for_track(data[ind,], x_var, y_var)
  }

  if (!is.null(inv_joint_angles)) {
    # Check if all inv_joint_angles are in data
    if (!all(inv_joint_angles %in% unique_joints)) stop ("One or more \"inv_joint_angles\" ids are not present in the data")

    ind <- data[[joint_var]] %in% inv_joint_angles
    data[ind, "angle"] <- -data[ind, "angle"]
  }

  if(!plot) {
    out_data <- data[,c(joint_var, frame_var, x_var, y_var, "angle")]
    return(out_data)
  }

  # Plot the data using ggplot2
  fig <- ggplot2::ggplot(data = data[!is.na(data$angle),],
                  mapping = ggplot2::aes(x = .data[[frame_var]]/max(.data[[frame_var]]), y = angle, col = .data[[frame_var]])) +
    ggplot2::facet_grid(ggplot2::vars(.data[[joint_var]]), scales = "free_y") +
    ggplot2::geom_point(na.rm = T) +
    ggplot2::geom_line(na.rm = T) +
    ggplot2::labs(y = "Angle", x = "Frames", col = "Frame") +
    ggplot2::scale_y_continuous(expand = c(0,0,.1,0), n.breaks = 5)

  if (!is.null(smooth)) {
    if (!smooth %in% c("gam", "loess")) stop("\"smooth\" must be one of \"gam\" or \"spline\".")
    fig <- fig +
      ggplot2::geom_smooth(ggplot2::aes(col = NULL), method = smooth, ...)
  }

  return(fig)
}
