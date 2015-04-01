readURL <- function(url) {
  out <- tryCatch(
       {
          readLines(con=url, warn=FALSE)
       },
       error=function(cond) {
         message(cond)
         return(NA)
       },
       warning=function(cond) {
         message(cond)
       },
       finally={
         message(paste("Processed URL:", url, sep=' '))
       }
  )
  return(out)
}  
