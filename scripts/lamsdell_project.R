#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work

#Clears environment of previous work
rm(list=ls())

#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

#loads necessary libraries
library("tidyverse")
library("readxl")
library("dplyr")

#Nested loop for applying the recoding process across all files

files <- list.files("./data") #create vector of files

for (file_name in files){
  x_data <- read_xlsx(paste0("data/", file_name)) #reads in .xlsx as a tbl
  sheets <- excel_sheets(paste0("data/", file_name)) #creates a vector of sheet names
  species <- pull(x_data[2:55,2], var = 1) #vector of species names excluding ancestor row and first row (the "grand" score)
  group <- pull((fill(x_data, 1, .direction = "down")[2:(nrow(x_data)-1),]), var = 1) #Fills in missing family values in first column, then excludes first line and ancestor line and removes excess file
  
  for (sheet_name in sheets) {
    data_tb <- read_excel(paste0("data/", file_name), sheet = sheet_name, range = "R4C3:R58C22", col_names = FALSE) #assigns selected excel file name, sheet, and range
    jl_vector <- pull(data_tb, X__1) #Extraction of first column in vector form
    source("functions/Lamsdell_Recoding_function.R") #sets the source for where the function is stored
    m <- apply(data_tb, 2, recoding_function) #calls the funtion and applies it to data_tb
    m_mean <- cbind(m, mean=rowMeans(m)) #Mean of the species rows into a new column on the end of the recoded matrix. This isn't necessary for the assignment but could be useful in future projects if the user wanted individual matrix outputs with the mean
    assign(paste0(sheet_name, "dmean"), m_mean[1:(nrow(m_mean)-1),]) #Outputs each individual sheet produced through the loop, excludes ancestor line 
    matrix_list <- ls(pattern="Matrix") #creates a vector of all matrices ran through the recoding loop
  }
}

# Extracting the means for each matrix and combining into a single file
summaryM <- matrix(nrow=54) #makes an empty data frame to fill each matrix mean into

for (matrix_name in matrix_list){
  summary <- rowMeans(get(matrix_name)) #extracts means row, not pretty. I tried matrix_name[,c("means)]
  summaryM <- cbind(summaryM, summary) #binds all means columns into one matrix
}

summaryM <- summaryM[,-1] #deletes weird extra column
colnames(summaryM) <- matrix_list #assigns sheetnames to column headers
summaryM <- cbind(group, species, summaryM) #adds group and species list to matrix
write.csv(summaryM, file = "summaryM.csv") #outputs the mean summaries as a .csv


#IN PROGRESS
#group_mean_by_row <- cbind(summaryM, rowmean=rowMeans(summaryM)) #mean of species means
#group_mean <- as.data.frame(summaryM) %>% group_by(group) %>% summarise(colMeans(summaryM[2:54, 3:19]))
