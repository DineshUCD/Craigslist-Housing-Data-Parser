getHouseInfo <- function(htmlLine, postingTitle) {

require(stringr)

housing <- c('apartment','condo','cottage/cabin', 'duplex', 'flat', 'townhouse', 'house', 'in-law', 'loft', 'manufactured', 'assisted living', 'land')
laundry <- c('laundry on site', 'laundry in bldg', 'w/d hookups', 'w/d in unit')
garage  <- c('carport', 'attached garage', 'detached garage', 'off-street parking', 'street parking', 'valet parking')

#trim whitespace, only requires one escape
htmlLine  <- gsub('^[ \t]+|[ \t]+$','', htmlLine)
info  <- gsub('<[^>]*>','', htmlLine)

info.bedroom  <- as.numeric(str_extract(info, perl(ignore.case('\\d(\\.\\d)?(?=\\s{0,2}(BR|Bedrooms?))'))))
info.bathroom <- as.numeric(str_extract(info, perl(ignore.case('\\d(\\.\\d)?(?=\\s{0,2}(BA|Bathrooms?))'))))
info.sqft     <- as.numeric(str_extract(info, perl(ignore.case('\\d{3,4}(?=\\s{0,2}?ft2?)'))))
info.city     <- str_extract(postingTitle, perl(ignore.case('(?<=\\()[A-Z\\s/]+(?=\\))')))

#Validate the bedroom data
bedroomcheck  <- as.numeric(str_extract(postingTitle, perl(ignore.case('\\d(\\.\\d)?(?=\\s{0,2}(Bed|BR|Bedroom[s/\\s]?))'))))
if( is.na(info.bedroom) || info.bedroom == 0 ) {
  info.bedroom <- bedroomcheck
}

bathroomcheck <- as.numeric(str_extract(postingTitle, perl(ignore.case('\\d(\\.\\d)?(?=\\s{0,2}(BA|Bath|Bathroom[s/\\s]?))'))))
if( is.na(info.bathroom) || info.bathroom == 0 ) {
  info.bathroom <- bathroomcheck
}

sqftcheck    <- as.numeric(str_extract(postingTitle, perl(ignore.case('\\d{3,4}(?=\\s{0,2}?ft2?)'))))
if( is.na(info.sqft) || info.sqft == 0 ) {
  info.sqft <- sqftcheck
}
									#HTML symbol for dollar sign
info.price <- as.numeric(str_extract(postingTitle, perl(ignore.case('(?<=&#x0024;)(\\d{3,5})'))))

# search for house options
for(type in housing) {
  info.model <- str_extract(info, perl(ignore.case(type)))
  if(!is.na(info.model)) break
}

for(setup in laundry) {
  info.laundry <- str_extract(info, perl(ignore.case(setup)))
  if (!is.na(info.laundry)) break
}

for(parking in garage) {
  info.garage <- str_extract(info, perl(ignore.case(parking)))
  if (!is.na(info.garage)) break
}

 list(bedroom = info.bedroom, bathroom = info.bathroom, sqft = info.sqft,
      model = info.model, city = info.city, laundry = info.laundry, garage = info.garage, price = info.price)

} 