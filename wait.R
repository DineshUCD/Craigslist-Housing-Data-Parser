wait <- function(time) {
  p1 <- proc.time()
  Sys.sleep(time)
  proc.time() - p1
}
