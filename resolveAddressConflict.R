parseGeoCodeJson <- function(partialLink) {

  #Initiate Google Geocoding API
  # https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=API_KEY
  query        <- "https://maps.googleapis.com/maps/api/geocode/json?address="
  apiKey       <- "AIzaSyDc6uiQ5JkqmCNADWElVtCdGSVMbrHG1dE"  
  link         <- paste(query, partialLink, '&key=', apiKey, sep='');
  jsonDocument <- getURL(link)
  parsedJSON   <- fromJSON(jsonDocument)
  
  parsedJSON
  
} 

getZip <- function(jsonDocument) {
  zipCodeIndex <- length(jsonDocument$results[[1]]$address_components)
  zip <- jsonDocument$results[[1]]$address_components[[zipCodeIndex]]$long_name
  zip
}
				   # accepts a character list
resolveAddressConflict <- function(addressList, gmapAddr) {
  require(rjson)
  require(RCurl)
  addressOptions <- length(addressList)

  isLatAndLongFormat  <- grepl('@.+z', gmapAddr)
  zip              <- NA
  
  if(!identical(gmapAddr, character(0)) && !isLatAndLongFormat)
    zip <- getZip(parseGeoCodeJson(gmapAddr))
  
  if ((addressOptions == 0 || identical(addressList, character(0))) && !identical(gmapAddr, character(0))) {
  
    if(isLatAndLongFormat)
      return(gmapAddr)
     
    locationDocument <- parseGeoCodeJson(gmapAddr)

    return(c(locationDocument$results[[1]]$formatted_address,zip))
  }
  else if(addressOptions == 1) {
      return(c(addressList[1], zip))
  }
  else { 
    return(c(addressList[order(nchar(addressList), addressList, decreasing=TRUE)][1], zip))
  }

  return(NA)
}


