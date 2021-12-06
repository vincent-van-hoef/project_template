create_scatter <- function(data) {
    pdf("scatter.pdf")
    plot(data$time, data$cal, col = "green")
    dev.off()
    return("scatter.pdf")
}