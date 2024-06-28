#' Basic 2D gait analysis dataset
#'
#' This is an example dataset from a motion capture of a gait, with frames por the
#' position of each major joint of the right lower limb
#'
#' @format A data.frame, data.table with 168 rows and 5 columns:
#' \describe{
#'   \item{nr}{The row number}
#'   \item{joint}{The id for the joint}
#'   \item{frame}{the frame number for the respective joint}
#'   \item{x_coord}{The X coordinates for the position of the joint in the specific frame}
#'   \item{y_coord}{The Y coordinates for the position of the joint in the specific frame}
#' }
"gait"
