Lamsdell's R Problem Exercise

Included:
- Project Description
- Getting Started
  - Prerequisites
  - Challenges
- Example Code with descriptions

PROJECT DESCRIPTION
  The purpose of this code is to automate the recoding process for Dr. Lamsdell. Dr. Lamsdell's research is recorded in dozens of .xls files, each containing 10 sheets within, and each sheet is a matrix of data from columns C-V and rows 4-57.  He has included a "template" row, row 58, which represent the recoding values.  The necessary recoding is as follows:
    If R58 (Ancestor) has a 1 - all 1's in that column should be changed to 0
    If R58 (Ancestor) has a 2 - all 2's in that column should be changed to 0
    All existing 0s need to be changed to the original value in R58
    All 2s need to be changed to -1
        Once that is done for each column, all the 2s in the matrix need to be replaced by -1.

PREREQUISITES
  Necessary R packages include tidyverse and dplyr. This can be installed by running the following script in your R console.
          install.packages("tidyverse")
          install.packages("dplyr")

GETTING STARTED
To begin it is necessary to download the Lamsdell's file matrices into your working directory. For the first part of this exercise we used only  Matrices 461-470.xlsx.   

EXAMPLE CODE:

library("tidyverse")
library("dplyr")
#Calls in the tidyverse and dplyr packages

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
group <- group_w [-56,]
#Fills in missing family values in first column, then excludes ancestor line.

column_number=3
v1 <- x_data[2:56,column_number]
#assign variable column_number as desired column number within the matrix and then extracts the selected column. The variable can be changed to reflect desired column for extraction.

AUTHORS:
Jill Riddell
Autumn Downey
Brittany Casey
