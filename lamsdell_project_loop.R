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

for (sheet_name in sheets) {
do
	data_tb <- read_excel(xfile_name, sheet = sheet_name, range = "R4C3:R58C22", col_names = FALSE) 
	jl_vector <- pull(data_tb, X__1)

	source("Lamsdell_Recoding_function.R") 
   
	m <- apply(data_tb, 2, recoding_function)
	
	m_sums <- cbind(m, sums=rowSums(m))
 
	assign(paste0(sheet_name, "d"), m_sums)  
}
