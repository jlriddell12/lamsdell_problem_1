#Download Lamsdell's file Matrices 461-470.xlsx into your working directory
install.packages(readxl)
#install the readxl package
library(readxl)
#Call in the read xl package
xfile_name <- "Matrices 461-470.xlsx"
x_data <- read_xlsx(xfile_name)
sheets <- excel_sheets(xfile_name)
data_tb <- as.tbl(x_data)
species <- x_data[2:55,2]