#This code is meant to automate and replicate the process of recoding matrices in Dr. Lamsdell's work
rm(list=ls())
#Download Lamsdell's file Matrices 461-470.xlsx into your working directory

#loads necessary libraries
library("tidyverse")
library("readxl")
library("dplyr")

#assigns variable name to read in the .xlsx file 
xfile_name <- "Matrices 461-470.xlsx"
x_data <- read_xlsx(xfile_name)
sheets <- excel_sheets(xfile_name)
#grab sheets name
=======

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
    
#We noticed if you call v1 from x_data it is titled column 3, therefore the following if-else code would have to have offset column numbers by 2 (because of the species name columns). So we decided to make a matrix that's just the data so that all the v-column numbers are titled with associated number, eg. v1 is titled column 1 and so on.
column_number=3:22
matrix461 <- x_data[2:56,column_number]

column_number=1 ## to test on other cols, all you need to do is change this number, right? Though when I tried this, it didn't work quite right...
v1 <- matrix461[1:55,column_number] ##v1 is a tibble, not a vector. This will cause problems later.  Please fix
#recodes according to criteria for a column where original ancestor = 2
for (number in v1) {
  if(v1[55,] == 1){ #if ancestor is equal to 1...
    (v1$`1`[v1$`1` == 1] <- 444) #change all 1s to placeholder 444
    (v1$`1`[v1$`1` == 0] <- 1) #change all 0s to orginal ancestor (1)
    (v1$`1`[v1$`1`== 2] <- -1) #now change all 2s to -1
    (v1$`1`[v1$`1`== 444] <- 0) #now change all 444s to 0
  } else if(v1[55,] == 2) { #if ancestor is equal to 2...
    (v1$`1`[v1$`1` == 2] <- 888) #change all 2s to placeholder 888
    (v1$`1`[v1$`1` == 0] <- 2) #change all 0s to original ancestor (2)
    (v1$`1`[v1$`1`== 2] <- -1) #now change all 2s to -1
    (v1$`1`[v1$`1`== 888] <- 0) #now change all 888s to 0
  } else if(v1[55,] == 0) #if ancestor is equal to 0
  
(v1$`1`[v1$`1`== 2] <- -1) #now change all 2s to -1
}

#Test above code on a column row were original ancestor = 1 (column 3 of data)
column_number=3
v3 <- matrix461[1:55,column_number]
for (number in v3) {
  if(v3[55,] == 1){ #if ancestor is equal to 1...
    (v3$`3`[v3$`3` == 1] <- 444) #change all 1s to placeholder 444
    (v3$`3`[v3$`3` == 0] <- 1) #change all 0s to orginal ancestor (1)
    (v3$`3`[v3$`3`== 2] <- -1) #now change all 2s to -1
    (v3$`3`[v3$`3`== 444] <- 0) #now change all 444s to 0
  } else if(v3[55,] == 2) { #if ancestor is equal to 2...
    (v3$`3`[v3$`3` == 2] <- 888) #change all 2s to placeholder 888
    (v3$`3`[v3$`3` == 0] <- 2) #change all 0s to original ancestor (2)
    (v3$`3`[v3$`3`== 2] <- -1) #now change all 2s to -1
    (v3$`3`[v3$`3`== 888] <- 0) #now change all 888s to 0
  } else if(v3[55,] == 0) #if ancestor is equal to 0
  
(v3$`3`[v3$`3`== 2] <- -1) #now change all 2s to -1
}

#Test above code on a column row were original ancestor = 0 (column 7 of data)
column_number=7
v7 <- matrix461[1:55,column_number]
for (number in v7) {
  if(v7[55,] == 1){ #if ancestor is equal to 1...
    (v7$`7`[v7$`7` == 1] <- 444) #change all 1s to placeholder 444
    (v7$`7`[v7$`7` == 0] <- 1) #change all 0s to orginal ancestor (1)
    (v7$`7`[v7$`7`== 2] <- -1) #now change all 2s to -1
    (v7$`7`[v7$`7`== 444] <- 0) #now change all 444s to 0
  } else if(v7[55,] == 2) { #if ancestor is equal to 2...
    (v7$`7`[v7$`7` == 2] <- 888) #change all 2s to placeholder 888
    (v7$`7`[v7$`7` == 0] <- 2) #change all 0s to original ancestor (2)
    (v7$`7`[v7$`7`== 2] <- -1) #now change all 2s to -1
    (v7$`7`[v7$`7`== 888] <- 0) #now change all 888s to 0
  } else if(v7[55,] == 0) #if ancestor is equal to 0
  
(v7$`7`[v7$`7`== 2] <- -1) #now change all 2s to -1
}

