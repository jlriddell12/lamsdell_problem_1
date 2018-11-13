#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work

#Clears environment of previous work
rm(list=ls())

#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

#loads necessary libraries
library("tidyverse")
library("readxl")
library("dplyr")

#assigns variable name to read in the .xlsx file 
xfile_name <- "Matrices 461-470.xlsx"

#grabs sheets name
sheets <- excel_sheets(xfile_name)


#reads in .xlsx as a tbl
x_data <- read_xlsx(xfile_name)

#created vector of sheet names
sheets <- excel_sheets(xfile_name)


#vector of species names excluding ancestor row
species <- pull(x_data[2:55,2], var = 1)

#Fills in missing family values in first column, then excludes ancestor line and removes excess file
##I adjusted this to use your tibble called x_data
group <- pull((fill(x_data, 1, .direction = "down")[1:(nrow(x_data)-1),]), var = 1)


#assigns selected excel file name, sheet, and range 
data_tb <- read_excel(xfile_name, sheet = sheets[1], range = "R4C3:R58C22", col_names = FALSE) ## JILL: this is what you were trying to do.

#Extraction of first column in vector form 
jl_vector <- pull(data_tb, X__1) #change X__1 to view another column

#sets the source for where the function is stored
source("Lamsdell_Recoding_function.R") 

#calls the funtion and applies it to data_tb #notes about apply for future
matrix_461_recoded <- apply(data_tb, 2, recoding_function)

#Sums the rows into a new column on the end of the recoded matrix 
matrix_461_recoded_sums <- cbind(matrix_461_recoded, sums=rowSums(matrix_461_recoded))

#Adds the group name vector to the recoded sums matrix in prep. for group sums
group_matrix_combine <- cbind(group, matrix_461_recoded_sums)

# DOESNT WORK, can't find function. Can't install "plyr"
# ddply(
#  .data = group_matrix_combine,
#  .variable = "group",
#  .fun = function(x) sum(x$sums)
# )
