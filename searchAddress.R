findaddress <- function(page)
{
  library(stringr)

  pattern <- character(0)

    # required
  housenumber    <- "(\\s?\\d{1,5} (?=\\w+))"
    #not required
  predirection   <- "((?<=[^\\w|])(East|West|North(West|East)?|South(West|East)?|(((N[EW]?)|([NS]?E)|([NS]?W)|(S[EW]?))\\.?))\\s)?"
    #required
  streetaddress  <- ".{3,20}\\s"
    #required
  streettype     <- "((Court|CT|CR)|(Drive|DR)|(Parkway|PKWY)|(Highway|HWY)|(Street|Str|ST)|(Avenue|AVE)|(Boulevard|BLVD)|(Bend|BND)|(Mount|MT)|(Mission|MSN)|Cul-De-Sac|(Circle|CIR)|(Alley|Aly)|(Way|WY)|(Road|RD)|(APT))(?![A-Z])\\.?\\,?"
    #not required
  unitdesignator <- "( ?(APARTMENT|APT|AP|BUILDING|BLDG|FLOOR|FL|SUITE|STE|UNIT|ROOM|RM|DEPARTMENT|DEPT|DOOR))?"
    #required
    #18120 Sample Drive Apt
  doornumber     <- "( # ?[A-Z0-9]{1,3}|\\s?\\d{1,3})?\\.?,?(\\s\\s\\|)?\\s{0,2}"
    #not required
  city 		 <- "(Alameda|Albany|American Canyon|Antioch|Atherton|Belmont|Belvedere|Benicia|Berkeley|Brentwood|Brisbane|Burlingame|Calistoga|Campbell|Clayton|Cloverdale|Colma|Concord|Corte Madera|Cotati|Cupertino|Daly|Danville|Dixon|Dublin|East Palo Alto|El Cerrito|Emeryville|Fairfax|Fairfield|Foster|Fremont|Gilroy|Half Moon Bay|Hayward|Healdsburg|Hercules|Hillsborough|Lafayette|Larkspur|Livermore|Los Altos|Los Altos Hills|Los Gatos|Martinez|Menlo Park|Mill Valley|Millbrae|Milpitas|Monte Sereno|Moraga|Morgan Hill|Mountain View|Napa|Newark|Novato|Oakland|Oakley|Orinda|Pacifica|Palo Alto|Petaluma|Piedmont|Pinole|Pittsburg|Pleasant Hill|Pleasanton|Portola Valley|Redwood|Redwood City|Richmond|Rio Vista|Rohnert Park|Ross|St. Helena|San Anselmo|San Bruno|San Carlos|San Francisco|San Jose|San Leandro|San Mateo|San Pablo|San Ramon|San Rafael|Santa Clara|Santa Rosa|Saratoga|Sausalito|Sebastopol|Sonoma|South Beach|SOMA|South San Francisco|Suisun|Sunnyvale|Tiburon|Union|Vacaville|Vallejo|Walnut Creek|Windsor|Woodside|Yountville)?"
    #not required
  state          <- ",?\\s?(CA)?\\.?\\s?"
  zipcode 	 <- "(\\d{5})?"


  pattern <-  paste("(",housenumber, predirection, streetaddress, streettype, unitdesignator, doornumber, city, state, zipcode ,")", sep="");

  matches <- str_extract(page,perl(ignore.case(pattern)))
  matches[!is.na(matches)]
}

