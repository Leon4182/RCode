# convert UTF8 characters to numeric values
# pre-processing .xlsx data
# library(xlsx)

UTF8toNumeric <- function(filepath){
  # read files
  # filepath <- "\\\\qut.edu.au\\Documents\\StudentHome\\Group14$\\n8811814\\Desktop\\111.xlsx"
  my.data<-read.xlsx(filepath,1,encoding='UTF-8',header=FALSE)
  
  # convert UTF8 to normal characters
  my.data <- iconv(my.data,from="UTF-8",to='latin1')
  
  # removes spaces between characters
  for(i in 1:ncol(my.data)){
    my.data[,i] <- gsub(" ", "" ,my.data[,i])
  }
  
  # convert characters to numeric values
  my.data <- as.numeric(my.data)
  
  return(my.data)
}