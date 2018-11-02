#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work
rm(list=ls())
#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

rm(list=ls()) #clears environment of previous work

#loads necessary libraries
library("tidyverse")
library("readxl")
library("dplyr")

#assigns variable name to read in the .xlsx file 
xfile_name <- "Matrices 461-470.xlsx"
x_data <- read_xlsx(xfile_name)
sheets <- excel_sheets(xfile_name)
#grab sheets name

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


##RECODING LOOP

data_tb <- read_excel(xfile_name, sheet = sheets[1], range = "R4C3:R58C22", col_names = FALSE) ## JILL: this is what you were trying to do.
v <- pull(data_tb, X__7) #change X__1 to view another column

#ANCESTOR LINE (line 55) IS NOT CHANGED FOR THIS LOOP, remains original. 
if(v[55] == 1){ #if ancestor is equal to 1...
  (v[1:54][v[1:54] == 1] <- 444) #change all 1s to placeholder 444
  (v[1:54][v[1:54] == 0] <- 1) #change all 0s to orginal ancestor (1)
  (v[1:54][v[1:54]== 2] <- -1) #now change all 2s to -1
  (v[1:54][v[1:54]== 444] <- 0) #now change all 444s to 0
} else if(v[55] == 2) { #if ancestor is equal to 2...
  (v[1:54][v[1:54] == 2] <- 888) #change all 2s to placeholder 888
  (v[1:54][v[1:54] == 0] <- 2) #change all 0s to original ancestor (2)
  (v[1:54][v[1:54]== 2] <- -1) #now change all 2s to -1
  (v[1:54][v[1:54]== 888] <- 0) #now change all 444s to 0
} else if(v[55] == 0){
  (v[1:54][v[1:54]==2] <- -1)
}


