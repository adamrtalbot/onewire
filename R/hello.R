# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'


read_ibutton <- function(file, identity = FALSE){
  data <- read.csv(file = file, skip = 14, header = TRUE, sep = c(",", " "), stringsAsFactors = FALSE)
  data$Date.Time <- as.POSIXct(x = data$Date.Time, format = "%d/%m/%y %T")
  if(source != FALSE){
    data$source <- paste(source)
    colnames(data)[4] <- "Source"
    data <- data[,c("Source", "Date.Time", "Unit", "Value")]
  }
  return(data)
}

