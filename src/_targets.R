# _targets.R file
library("targets")
library("tarchetypes")

source("myFunctions.R")

tar_option_set(
  packages = c(
    "dplyr",
    "rpivotTable",
    "plotly",
    "crosstalk",
    "DT",
    "flexdashboard"
  )
)

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
    ),
    tar_render(
        dashboard,
        "flexdashboard.Rmd",
        output_file = "../../results/dashboard.html"
    )
)
