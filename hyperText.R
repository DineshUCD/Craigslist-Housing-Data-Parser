getTextFromUrl <- function(webAddress) {
require(XML)
require(stringr)

htmlResponse <- url(webAddress)

document <- readURL(htmlResponse)

close(htmlResponse)

attrLine  <- document[grep('attrgroup', document)]
	                                               #data is below h2 and span
title     <- document[grep('postingtitle', document) + 2] 

houseData <- getHouseInfo(attrLine, title)

validateInput <- function(html) {
  if (grepl("</html>", document[length(document)], fixed=TRUE)) {
    return(html)
   }
   else {
     return(NULL)
   }
}

convertHtmlToText <- function(html) {
  doc <- htmlParse(html, asText = TRUE)
  text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
  return(text)
}

rawText <- convertHtmlToText(validateInput(document)) 

modifiedText <- gsub('\r?\n|\r','',rawText)

blanks <- grep('^ *$', modifiedText)

modifiedText <- modifiedText[-blanks]

locations <- findaddress(modifiedText)

#character(0) if google map link does not exist
#1042+Haight+san+francisco+ca+US
googlemap <- document[grep('google map', document)]
googlemapAddress <- gsub('%3','',str_extract(googlemap, perl('(?<=%3A\\+).*US(?=">)|(@.+)(?=">)')))


address   <- resolveAddressConflict(locations, googlemapAddress)

#processed = modifiedText, raw = document, for debugging
#houseData comes from getHouseInfo
#location comes from resolveAddressConflict, uses findaddress
info <- list( type = houseData, location = address, processed = modifiedText, raw = document)

info
}
