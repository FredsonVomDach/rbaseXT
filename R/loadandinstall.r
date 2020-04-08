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
  for (i in c(1:length(mypkg))){
    if (!is.element(mypkg[i], installed.packages()[,1])){
      install.packages(mypkg[i])}
    
    library(mypkg[i], character.only=TRUE)
  }
}