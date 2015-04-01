library(XML)
library(stringr)
library(RCurl)
library(rjson)

source("houseInfo.R")
source("readURL.R")
source("hyperText.R")
source("resolveAddressConflict.R")
source("searchAddress.R")
source("wait.R")

craigListings <- url("http://sfbay.craigslist.org/apa/")

houseLinks <- readLines(craigListings)

postId <- grep('<p class="row".*class="hdrlnk">', houseLinks)

houseLinks <- houseLinks[postId]

#sfc, sby, eby, pen, nby, scz
postLinkById <- str_extract_all(houseLinks,"/(sby|sfc|pen|eby|nby|scz)/apa/\\d+")
#paste("http://sfbay.craigslist.org",postLinkById[1], sep="")

set.seed(18120)

houseData <- data.frame()
zip       <- numeric(0)

numberofPosts <- length(postLinkById[[1]])

for(linkWalk in seq(from=1, to=numberofPosts, by=2)) {
  delay <- sample(15:20, 1, replace=T)  # To PREVENT IP BAN, I must pause between each link retrieval
  if(!is.na(postLinkById[linkWalk])) {
    print("Opening Craigslist Link...")
    craig <- getTextFromUrl(paste("http://sfbay.craigslist.org",postLinkById[[1]][linkWalk], ".html", sep=""))
 
  if (length(craig$location) == 2) { 
    zip <- as.numeric(craig$location[[2]])
  }
  else {
    zip <- NA
  }

  houseData <- rbind(houseData, data.frame(bedroom  = craig$type$bedroom, bathroom = craig$type$bathroom, 
                                           sqft     = craig$type$sqft,       model = craig$type$model, 
                                           laundry  = craig$type$laundry,   garage = craig$type$garage, 
                                           city     = craig$type$city,           price = craig$type$price, 
                                           location = craig$location[1],   zipCode = zip))
  }
  print("Delay about to start!")
  wait(delay)
}





