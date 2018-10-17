#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work

#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

library("tidyverse")
library("readxl")
library("dplyr")
#loads necessary libraries

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
group <- group_w [-56,1]
rm (group_w)
#Fills in missing family values in first column, then excludes ancestor line and removes excess file

column_number=3
v1 <- x_data[2:56,column_number]
#assign variable x as desired column number within the matrix, extracts selected column
#Note that in the final assignment, some of these lines will likely be combined into single lines of code. Here, they are separated for clarity and to ensure the template will work for all the sheets.
