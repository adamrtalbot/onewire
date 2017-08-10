# You can learn more about package authoring with RStudio at: http://r-pkgs.had.co.nz/
# Some useful keyboard shortcuts for package authoring: Build and Reload Package: 'Cmd + Shift + B' Check Package: 'Cmd +
# Shift + E' Test Package: 'Cmd + Shift + T'

###############################################
### Function(s) for reading in iButton data ###
###############################################

#' Read iButton Data
#'
#' Function for reading data from an individual iButton
#'
#'  @param file CSV output from an individual iButton
#'  @param identity Name of iButton 'sample', as either character. Leave as false for no-name.
#'
#'  @return Data frame of iButton data, with time, unit and value. If included, identity will be added as the first vector.
#'  @export


read_ibutton <- function(file, identity = FALSE) {
    data <- read.csv(file = file, skip = 14, header = TRUE, sep = c(",", " "), stringsAsFactors = FALSE)
    data$Date.Time <- as.POSIXct(x = data$Date.Time, format = "%d/%m/%y %T")
    if (identity != FALSE) {
        data$identity <- paste(identity)
        colnames(data)[4] <- "Identity"
        data <- data[, c("Identity", "Date.Time", "Unit", "Value")]
    }
    return(data)
}

#'  Read folder of iButton data
#'
#'  Function for reading in a folder of iButton .csv data files, then returning them as a list of data
#'
#'  @param file_list Character vector of files to import as iButton data files. Overrides 'folder' and 'pattern'.
#'  @param folder Folder of iButton data to be read in. All files matching the pattern will be included. Ignored if file list is provided.
#'  @param pattern All files matching the REGEX pattern will be included. By default, this is any files ending in '.csv' ("*.csv"). Ignored if file list is provided.
#'  @return List of data frames of iButton data, with file name as the identity for each.
#'  @export

read_ibutton_folder <- function(file_list = FALSE, folder = FALSE, pattern = "*.csv") {

  if(file_list != FALSE){
    files <- file_list
      } else {
    files <- list.files(path = folder, full.names = TRUE, pattern = pattern, ignore.case = FALSE)
      }

    data_list <- list()

    for (i in files) {
        ident <- gsub(pattern = paste0(folder, "/"), replacement = "", x = i)
        ident <- gsub(pattern = ".csv", replacement = "", x = ident)
        data <- read_ibutton(file = i, identity = ident)
        data_list[[i]] <- data
    }
    return(data_list)
}


