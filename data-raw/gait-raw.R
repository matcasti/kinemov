## code to prepare `DATASET` dataset goes here

library(data.table)
gait <- fread(input = "data-raw/gait_data.csv")[, 1:5]

gait

names(gait) <- c("nr", "joint", "frame", "x_coord", "y_coord")

gait <- as.data.frame(gait)

usethis::use_data(gait, overwrite = TRUE)
