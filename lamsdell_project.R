#Download Lamsdell's file Matrices 461-470 into your working directory
#rename the file Matrix_461-470 as bash and R don't like files with dashes or spaces in the file name
install.packages(readxl)
#install the readxl package
library(readxl)
#Call in the read xl package
matrix_461_570 <- read_xlsx("Matrics_461_470")