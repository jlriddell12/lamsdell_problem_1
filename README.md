# Lamsdell's R Problem Exercise 

## Included:
- Overall Project Description
- Part 1
- Getting Started
  - Prerequisites
  - Challenges
- Example Code with descriptions

## PROJECT DESCRIPTION
  The purpose of this code is to automate the recoding process for Dr. Lamsdell. Dr. Lamsdell's research is recorded in dozens of .xls files, each containing 10 sheets within, and each sheet is a matrix of data from columns C-V and rows 4-57.  He has included a "template" row, row 58, which represent the recoding values.  The necessary recoding is as follows:
  
    If R58 (Ancestor) has a 1 - all 1's in that column should be changed to 0
    
    If R58 (Ancestor) has a 2 - all 2's in that column should be changed to 0
    
    All existing 0s need to be changed to the original value in R58
    
    All 2s need to be changed to -1
    
    Once that is done for each column, all the 2s in the matrix need to be replaced by -1.
    
  The resulting outputs will be, a .csv file for each matrix:
  * weighted average (mean) column for each matrix
  * mean per group (5 groups)
  * Grand mean- clade score for all (score/54)

#### GETTING STARTED
  To begin it is necessary to download the Lamsdell's file matrices into your working directory. For the first part of this exercise we used only  Matrices 461-470.xlsx.

#### PREREQUISITES
  **Necessary R packages** include tidyverse and dplyr. This can be installed by running the following script in your R console.
  
          install.packages("tidyverse")
          install.packages("dplyr")
          install.packages("readxl")     
#### Challenges
- The function paste0 was introduced to base R in version 2.15.0, if you are having issues utilizing the function you may need to upgrade your version.
- as.vector does not work on tibble for converting data.frame to vector. Use pull() command under dplyr package. The default is to use the final column in the dataframe. Use var = 1 to tell it to start from the first column.
- For the loop to produce a dataframe output for each sheet, the variable in the for/in statement must be renamed according to each sheet at the end of the loop. 
  
### EXAMPLE CODE:
#### Script:
```R
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
    do
    
    data_tb <- read_excel(paste0("data/", file_name), sheet = sheet_name, range = "R4C3:R58C22", col_names = FALSE) #assigns selected excel file name, sheet, and range
    
    jl_vector <- pull(data_tb, X__1) #Extraction of first column in vector form
    
    source("functions/Lamsdell_Recoding_function.R") #sets the source for where the function is stored
    
    m <- apply(data_tb, 2, recoding_function) #calls the funtion and applies it to data_tb
    
    m_mean <- cbind(m, mean=rowMeans(m)) #Mean of the species rows into a new column on the end of the recoded matrix
    
    assign(paste0(sheet_name, "d"), m_mean[1:(nrow(m_mean)-1),]) #Outputs each individual sheet produced through the loop, excludes ancestor line
    
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

```
#### Recoding Function
```R
# Function to apply Lamsdell recoding criteria to the matrix
recoding_function <- function(jl_vector){ 
  if(jl_vector[55] == 1){ #if ancestor is equal to 1...
    (jl_vector[1:55][jl_vector[1:55] == 1] <- 444) #change all 1s to placeholder 444
    (jl_vector[1:55][jl_vector[1:55] == 0] <- 1) #change all 0s to orginal ancestor (1)
    (jl_vector[1:55][jl_vector[1:55]== 2] <- -1) #now change all 2s to -1
    (jl_vector[1:55][jl_vector[1:55]== 444] <- 0) #now change all 444s to 0
  } else if(jl_vector[55] == 2) { #if ancestor is equal to 2...
    (jl_vector[1:55][jl_vector[1:55] == 2] <- 888) #change all 2s to placeholder 888
    (jl_vector[1:55][jl_vector[1:55] == 0] <- 2) #change all 0s to original ancestor (2)
    (jl_vector[1:55][jl_vector[1:55]== 2] <- -1) #now change all 2s to -1
    (jl_vector[1:55][jl_vector[1:55]== 888] <- 0) #now change all 444s to 0
  } else if(jl_vector[55] == 0){ #if ancestor line is 0...
    (jl_vector[1:55][jl_vector[1:55]==2] <- -1) #change all 2s to -1
  }
  return(jl_vector)
}
```

## AUTHORS:

Jill Riddell

Autum Downey

Brittany Casey
