#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work

#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

#loads necessary libraries
library("tidyverse")
library("readxl")
library("dplyr")

#assigns variable name to read in the .xlsx file 
xfile_name <- "Matrices 461-470.xlsx"

#reads in .xlsx as a tbl
x_data <- read_xlsx(xfile_name)

#created vector of sheet names
sheets <- excel_sheets(xfile_name)

#alternate way of confirming data storage as a tbl
data_tb <- as.tbl(x_data)

#vector of species names excluding ancestor row
species <- pull(x_data[2:55,2], var = 1)

#Fills in missing family values in first column, then excludes ancestor line and removes excess file
group <- pull((fill(data_tb, 1, .direction = "down")[1:(nrow(data_tb)-1),]), var = 1)

#assign variable x as desired column number within the matrix, extracts selected column
#Note that in the final assignment, some of these lines will likely be combined into single lines of code. Here, they are separated for clarity and to ensure the template will work for all the sheets.
column_number=3
v1 <- x_data[2:56,column_number]

##RECODING LOOP
    
#specifies if ancestor value is 1 or 2 and recodes to 444 and 888 respectively 
for (number in "v1") {
  if(v1[55,] == 1){ 
    (v1$`1`[v1$`1` == 1] <- 444)
  } else if(v1[55,] == 2) {
    (v1$`1`[v1$`1` == 2] <- 888)
  }
}


