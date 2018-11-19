rm(list=ls())
library("tidyverse")
library("readxl")
library("dplyr")

files <- list.files("./data") #create vector of files

for (file_name in files){
  x_data <- read_xlsx(paste0("data/", file_name))
  sheets <- excel_sheets(paste0("data/", file_name))
  species <- pull(x_data[2:55,2], var = 1)
  group <- pull((fill(x_data, 1, .direction = "down")[2:(nrow(x_data)-1),]), var = 1)
  for (sheet_name in sheets) {
    do
    
    data_tb <- read_excel(paste0("data/", file_name), sheet = sheet_name, range = "R4C3:R58C22", col_names = FALSE) #assigns selected excel file name, sheet, and range
    
    jl_vector <- pull(data_tb, X__1) #Extraction of first column in vector form
    
    source("functions/Lamsdell_Recoding_function.R") #sets the source for where the function is stored
    
    m <- apply(data_tb, 2, recoding_function) #calls the funtion and applies it to data_tb
    
    m_mean <- assign(paste(sheet_name), rowMeans(m)) #Mean of the species rows into a new column on the end of the recoded matrix
    
    
    stuff <- cbind(m, m_mean)
    
    #assign(paste0(sheet_name, "d"), stuff[1:(nrow(stuff)-1),])
  }
}
    
    
    #assign(paste0(sheet_name, "d"), m_mean[1:(nrow(m_mean)-1),]) #Outputs each individual sheet produced through the loop, excludes ancestor line
    
  }
}

dataframe_list = grep("\\w+\\s\\w+d", ls(), value=TRUE) #makes a vector for the matrices. Might not need.

summaryM <- matrix(nrow=55) #makes an empty data frame for means. Need to fill..?

for (y in dataframe_list){
  v <- rowMeans(get(y))
  summaryM <- cbind(summaryM, v)
}

summaryM <- summaryM[,-1]
colnames(summaryM) <- dataframe_list