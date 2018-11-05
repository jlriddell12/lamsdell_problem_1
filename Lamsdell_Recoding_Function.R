##Your function variable data_tb is not used anywhere in your function.
##Instead of a tb, the function should be calling a vector, not a tibble
##The apply function will apply your function (which works on a single
##vector, to each 'vector' (column) in the dataframe)
recoding_function <- function(data_tb){ 
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
  } else if(v[55] == 0){ #if ancestor line is 0...
    (v[1:54][v[1:54]==2] <- -1) #change all 2s to -1
  }
  return(v)
}