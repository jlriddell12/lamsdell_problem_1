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
    
  The resulting outputs will be, for each matrix:
  * the sum of each score by row
  * weighted average for each row score (=row sum/20)
  * clade score (mean of all species) for each group.

#### GETTING STARTED
  To begin it is necessary to download the Lamsdell's file matrices into your working directory. For the first part of this exercise we used only  Matrices 461-470.xlsx.

#### PREREQUISITES
  **Necessary R packages** include tidyverse and dplyr. This can be installed by running the following script in your R console.
  
          install.packages("tidyverse")
          install.packages("dplyr")
          install.packages("readxl")     

- The function paste0 was introduced to base R in version 2.15.0, if you are having issues utilizing the function you may need to upgrade your version.  

### PART 1: Read and Extract
  The purpose of the code in this section is to read in the .xlsx files, and extract the necessary column to build the automated recoding process from.  
  The output will be a matrix created from the .xlsx file, a vector containing the list of the different species names, a matrix that contains filled in family names, and one extracted column from the matrix.  

#### CHALLENGES
  as.vector does not work on tibble for converting data.frame to vector. Use pull() command under dplyr package. The default is to use the final column in the dataframe. Use var = 1 to tell it to start from the first column.

### Part 2: Indexing and Conditionals 
  This section of the code provides the number transformations needed within a single column. As stated above      

This is done using a nested "if" loop containing two "if else" conditions. 1. If the "number" in the ansestor row from a chosen column is = 1 change all 1's to 444, change all 0's to the value in the ancestor row, change all 2's to a -1, and then change all 444's to -1. 2. "otherwise"", "if" the ancestor column = 2 then change all 2's to 888, change all 0's to the value in the ancestor row, change all 2's to -1, change all 888 to 0. 3. "otherwise" "if" ancestor = 0 change all 2's to a -1. 

#### CHALLENGES 
  _column_number variable should be able to be replaced with any column number to get the correct column. You should not need to repeat the code. An alternative solution exists in read.xl that lets you read in exactly the cols and rows you desire._ 
  
### PART 3: Making a Function, Apply it
  This portion of the code creates a function using the previously made if/else arguments. The function operates across the vectors, or the columns, in the original data matrix. The apply function is used to make the function operate across an entire matrix by applying it to a set of vectors or columns. 

### PART 4: Loop the Function
  Now, the function is inserted into a loop to run it across all sheets in the workbook, in this case ten sheets. The cbind operator is used to add the summation column to each matrix then apply and paste are used to name each sheet so that the loop outputs each recoded sheet as a dataframe. The character "d" is added to the sheet names to indicate that the output data represents the done, or recoded, data.

#### CHALLENGES
  For the loop to produce a dataframe output for each sheet, the variable in the for/in statement must be renamed according to each sheet at the end of the loop. 
  
  Also, how to include group mean in the loop as it is based off species (where there is 6 rows) compared to the matrix which has 55. Possibly create another loop, but that would be a seperate output than the recoded matrix. 
  
### EXAMPLE CODE:
#### Script:
```R
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

#Fills in missing family values in first column, then excludes ancestor line and removes excess file
##I adjusted this to use your tibble called x_data
group <- pull((fill(x_data, 1, .direction = "down")[1:(nrow(x_data)-1),]), var = 1)

# Loops the recoding function through each matrix in a workbook, adds summatation column for each row, and mean for each group 
for (sheet_name in sheets) {
  do
  data_tb <- read_excel(xfile_name, sheet = sheet_name, range = "R4C3:R58C22", col_names = FALSE) #assigns selected excel file name, sheet, and range 
  jl_vector <- pull(data_tb, X__1) #Extraction of first column in vector form
  
  source("functions/Lamsdell_Recoding_function.R") #sets the source for where the function is stored
  
  m <- apply(data_tb, 2, recoding_function) #calls the funtion and applies it to data_tb
  
  m_sums <- cbind(group, m, sums=rowSums(m))#Sums the rows into a new column on the end of the recoded matrix 
  
  weighted <- cbind(m_sums, weighted=(rowSums(m)/20)) #Calculates the weighted average by sum/20
  
  assign(paste0(sheet_name, "d"), weighted) #Outputs each individual sheet produced through the loop  
}
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
