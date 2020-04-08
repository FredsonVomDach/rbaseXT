loadandinstall <- function(mypkg) {
  for (i in c(1:length(mypkg))){
    if (!is.element(mypkg[i], installed.packages()[,1])){
      install.packages(mypkg[i])}
    
    library(mypkg[i], character.only=TRUE)
  }
}