# _targets.R file
source("myFunctions.R")
install.packages("targets")
library("targets")

list(
    tar_target(
        raw_data_file,
        "calcium.csv",
        format = "file"
    ),
    tar_target(
        raw_data,
        read.csv(raw_data_file)
    ),
    tar_target(
        scatter,
        create_scatter(raw_data),
        format = "file"
    )
)
