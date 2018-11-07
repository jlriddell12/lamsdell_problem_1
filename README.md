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
  The resulting outputs will be, for each matrix, the mean of each score by row and clade score (mean of all species) for each group.

#### GETTING STARTED
  To begin it is necessary to download the Lamsdell's file matrices into your working directory. For the first part of this exercise we used only  Matrices 461-470.xlsx.

#### PREREQUISITES
  Necessary R packages include tidyverse and dplyr. This can be installed by running the following script in your R console.
          install.packages("tidyverse")
          install.packages("dplyr")
          
### PART 1: Read and Extract
  The purpose of the code in this section is to read in the .xlsx files, and extract the necessary column to build the automated recoding process from.  
  The output will be a matrix created from the .xlsx file, a vector containing the list of the different species names, a matrix that contains filled in family names, and one extracted column from the matrix.  

#### CHALLENGES
  as.vector does not work on tibble for converting data.frame to vector. Use pull() command under dplyr package. The default is to use the final column in the dataframe. Use var = 1 to tell it to start from the first column.

### Part 2: Indexing and Conditionals 
  This section of the code provides the number transformations needed within a single column. As stated above       If the Ancestor row contains a column of value 1 - all 1's in that column should be changed to 0
    If the Ancestor row contains a column of value 2 - all 2's in that column should be changed to 0
    All existing 0s need to be changed to the original value in the ancestor column
    All 2s need to be changed to -1
This is done using a nested "if" loop containing two "if else" conditions. 1. If the "number" in the ansestor row from a chosen column is = 1 change all 1's to 444, change all 0's to the value in the ancestor row, change all 2's to a -1, and then change all 444's to -1. 2. "otherwise"", "if" the ancestor column = 2 then change all 2's to 888, change all 0's to the value in the ancestor row, change all 2's to -1, change all 888 to 0. 3. "otherwise" "if" ancestor = 0 change all 2's to a -1. 

#### CHALLENGES 
  _column_number variable should be able to be replaced with any column number to get the correct column. You should not need to repeat the code. An alternative solution exists in read.xl that lets you read in exactly the cols and rows you desire._ 
  

### PART 3: Making a Function, Apply it
  This portion of the code creates a function using the previously made if/else arguments. The function operates across the vectors, or the columns, in the original data matrix. The apply function is used to make the function operate across an entire matrix by applying it to a set of vectors or columns. 

#### CHALLENGES
  Be sure the range of rows to includes the ancestor row. Be sure that your function is operating a vector.
  
### EXAMPLE CODE:
## Script:
**#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work**

rm(list=ls())

**#loads necessary libraries**

library("tidyverse")

library("readxl")

library("dplyr")

**#assigns variable name to read in the .xlsx file** 

xfile_name <- "Matrices 461-470.xlsx"

**#grabs sheets name**

sheets <- excel_sheets(xfile_name)

**#reads in .xlsx as a tbl**

x_data <- read_xlsx(xfile_name)

**#created vector of sheet names**

sheets <- excel_sheets(xfile_name)

**#vector of species names excluding ancestor row**

species <- pull(x_data[2:55,2], var = 1)

**#Fills in missing family values in first column, then excludes ancestor line and removes excess file**

group <- pull((fill(data_tb, 1, .direction = "down")[1:(nrow(data_tb)-1),]), var = 1)


**#assigns selected excel file name, sheet, and range**

data_tb <- read_excel(xfile_name, sheet = sheets[1], range = "R4C3:R58C22", col_names = FALSE) ## JILL: this is what you were trying to do.

**#Extraction of first column in vector form** 
jl_vector <- pull(data_tb, X__1) #change X__1 to view another column

**#Sets the source for where the function is stored**

source("Lamsdell_Recoding_function.R") 

**#Calls the funtion and applies it to data_tb**

matrix_461_recoded <- apply(data_tb, 2, recoding_function)

## Function
**# Applies conditionals to extracted vector for recoding column based on ancestor value**

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
  
## AUTHORS:
Jill Riddell
Autum Downey
Brittany Casey
