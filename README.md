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

### EXAMPLE CODE:

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

species <- pull(x_data[2:55,2], var = 1)
#vector of species names excluding ancestor row

group <- pull((fill(data_tb, 1, .direction = "down")[1:(nrow(data_tb)-1),]), var = 1)
#Fills in missing family values in first column, then excludes ancestor line and removes excess file

column_number=3
v1 <- x_data[2:56,column_number]
#if supposed to be a vector then v1 <- pull(x_data[2:56,column_number], var = 1)
#assign variable x as desired column number within the matrix, extracts selected column

#Note that in the final assignment, some of these lines will likely be combined into single lines of code. Here, they are separated for clarity and to ensure the template will work for all the sheets.

## AUTHORS:
Jill Riddell
Autum Downey
Brittany Casey
