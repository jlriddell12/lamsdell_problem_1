#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work

#Clears environment of previous work
rm(list=ls())

#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

#loads necessary libraries
library("tidyverse")
library("readxl")
library("dplyr")

#assigns variable name to read in the .xlsx file 
xfile_name <- "data/Matrices 461-470.xlsx"

#grabs sheets name
sheets <- excel_sheets(xfile_name)


#reads in .xlsx as a tbl
x_data <- read_xlsx(xfile_name)

#created vector of sheet names
sheets <- excel_sheets(xfile_name)


#vector of species names excluding ancestor row
species <- pull(x_data[2:55,2], var = 1)

#Fills in missing family values in first column, then excludes first line and ancestor line and removes excess file
group <- pull((fill(x_data, 1, .direction = "down")[2:(nrow(x_data)-1),]), var = 1)

# Loops the recoding function through each matrix in a workbook, adds summatation column for each row, and mean for each group 
for (sheet_name in sheets) {
  do
  
  data_tb <- read_excel(xfile_name, sheet = sheet_name, range = "R4C3:R58C22", col_names = FALSE) #assigns selected excel file name, sheet, and range
  
  jl_vector <- pull(data_tb, X__1) #Extraction of first column in vector form
  
  source("functions/Lamsdell_Recoding_function.R") #sets the source for where the function is stored
  
  m <- apply(data_tb, 2, recoding_function) #calls the funtion and applies it to data_tb
  
  assign(paste0(sheet_name, "d"), m[1:(nrow(m)-1),]) #Outputs each individual sheet produced through the loop, excludes ancestor line  
}



## This works to get the mean of the species, but can not include in loop because of mismatched rows
##m_mean <- cbind(group, m, sums=rowMeans(m))#Sums the rows into a new column on the end of the recoded matrix
##clade_mean <- as.data.frame(m_sums) %>% group_by(group) %>% summarise(mean = mean(as.numeric(sum)))
##AH- The clade mean and group means can be calculted outside the loop - see next assignment.