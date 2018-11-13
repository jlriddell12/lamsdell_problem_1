##Your function variable data_tb is not used anywhere in your function.
##Instead of a tb, the function should be calling a vector, not a tibble
##The apply function will apply your function (which works on a single
##vector, to each 'vector' (column) in the dataframe)
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