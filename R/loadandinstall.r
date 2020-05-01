#' @title Load and install packages
#' @description Combines the library() and install.packages() comands in one function
#'
#' @param mypkg String. Single Character String of package name or vector of package names
#'
#' @author Frederic Schwarzenbacher
#'
#' @examples
#' loadandinstall("packagename")
#' @keywords load and install library install.packages#'
#' @export


loadandinstall <- function(mypkg) {
  
  errorhandler <- function(pck,task) {
    success <- tryCatch(
      {
        if (task=="install") {
          install.packages(pck)
        }
        if (task=="load") {
          library(pck, character.only=TRUE)
        }
        status=1
      },
      error=function(cond) {
        status=0
      },
      warning=function(cond){
        status=0
      }
    )    
    return(success)
  }
  
  errors <- c()
  for (i in c(1:length(mypkg))){
    if (!is.element(mypkg[i], installed.packages()[,1])){
      task="install"
      success <- errorhandler(mypkg[i],task)
      if (success==0) {
        errors <- append(errors,mypkg[i])
        #next() installation errors are not always catched, try to load as a next step
      }
    }
    
    task="load"
    success <- errorhandler(mypkg[i],task)
    if (success==0) {
      task="install"
      errorhandler(mypkg[i],task)
      task="load"
      success <- errorhandler(mypkg[i],task)
      if (success==0) {
        errors <- append(errors,mypkg[i])
      }
    }
  }
  if (!is.null(errors)) {
    message("The were errors or warnings while installing or loading the follwing package(s)")
    return(unique(errors))
  }
}