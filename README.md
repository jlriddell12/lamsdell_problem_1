# lamsdell_problem_1

#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

Required packages:
install.packages("tidyverse")
install.packages("dplyr")
#install the tidyverse and dplyr packages

library("tidyverse")
library("dplyr")
#Call in the tidyverse and dplyr packages

xfile_name <- "Matrices 461-470.xlsx"
#assigns variable name to read in the .xlsx file

x_data <- read_xlsx(xfile_name)
#reads in .xlsx as a tbl

sheets <- excel_sheets(xfile_name)
#created vector of sheet names

data_tb <- as.tbl(x_data)
#alternate way of confirming data storage as a tbl

species <- x_data[2:55,2]
#vector of species names excluding ancestor row

group_w <- fill(data_tb, 1, .direction = "down")
group <- group_w [-56,]
#Fills in missing family values in first column, then excludes ancestor line.

x=3
v1 <- x_data[2:56,x]
#assign variable x as desired column number within the matrix, extracts selected column
