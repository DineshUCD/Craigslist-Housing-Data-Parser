<<<<<<< HEAD
**Questions answered in the README:** 
 How is this different from other Craigslist scrapers?
 What is the motivation of this software?
 What additional features are coming?
 Why does this matter?

Main Challenge: Parsing *unstructured* addresses and numeric housing data.

Overview of Script calls:

main.R calls "getTextFromUrl()" in hyperText.R to get all the data

hyperText.R calls "readURL()" to handle exceptions in bad urls

hyperText.R calls "getHouseInfo()" to get bed, bath, sqft, model, city, laundry type, garage type, and price in houseInfo.R

hyperText.R calls "findaddress()" to find the house's address

hyperText.R calls "resolveAddressConflict()" in resolveAddressConflict.R to choose the best address or use Google Geocoding API to find the address.

main.R checks to see if both the zip code and address are output or only the address.

main.R calls "wait()" from wait.R to pause between link walk


* Quick summary

The Craigslist Scraper scrapes posts under "apt/housing for rent" for all San Francisco Bay area for house address, zip code, city, price, model, laundry unit, garage type, number of bedrooms, and number of bathrooms.  

Presently, the next iteration will present statistics of the data in interactive histograms, normal curves showing confidence intervals, and scatter plots using Shiny package. 

I seek to analyse Silicon Valley booming housing market trends to find out what features of a house make it attractive to buyers. I hypothesize the rent price will be mostly based on location. Certain locations have access to better schools, and attractive IT companies (Apple, HP, Facebook in Palo Alto). 

* Version

Started on => 2014-9-7 (Couple days after UC Davis Summer Session 1)
Done by    => 2014-9-14

The current version gathers numeric and categorical housing data into a data frame.

According to Craigslist's terms of use scrapers, crawlers, robots, and spiders are prohibited. Still, many websites sell Craigslist scrapers with simpler functionality than mine from $10 to $49.95. This Craigslist Scraper is intended for educational purpose only. This version waits 15 to 20 seconds between analysing each link to prevent spamming Craigslist's server, and consequently, getting one's IP banned by Craigslist.

Refer to GPL license for using the code.
 
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)


### How do I get set up? ###

* Summary of set up

1. Download the latest .R file under "Source" tab into the same working directory.
2. Start R in the terminal.
3. Change 'numberofPosts' in main.R to around 5 or so. If not, prepare to wait 1+ hour(s) for the application to finish.
3. Start the application using 'source("main.R")'.

* Configuration

1. Install R version 3.0.2 -- "Frisbee Sailing"

* Dependencies

1. XML
2. RCurl
3. g++
4. stringr
5. rjson
6. Internet Access


* How to run tests

1. In the R command line, type 'houseData' once the application is done. The links captured persist in RAM.

* Deployment instructions

1. Deploy R from the Linux Terminal. You may also try using RStudio.

### Contribution guidelines ###

* **Code review****

The hardest part is parsing unstructured addresses using Regular Expressions. Many posts in StackOverflow claim that one must use natural language processing or machine learning to achieve this. In fact, some posts recommend to use SmartyStreets API . Those ideas *do not exactly* apply in context of Craigslist and SmartyStreets API is not so smart for this task (See addressParserComparison.png). However, I used an XML parser to retrieve the raw text from the http response. A better solution does involve machine learning, but it does not do the main job of finding the address.

In software engineering, one must simplify their model of reality sometimes to approach a problem. The precursor to creating the perfect method involves research about the problem, and cross-validation of features. After browsing over 10,000 housing rent advertisements, I gathered test data of how an address a user enters may look like. Surprisingly, there are few 'unspoken' patterns all users abide by!    

Some example addresses are:

1000 Sample1 Drive Apt # 4G5, San Jose

9000 East The West Coast Drive Apt # 4G5, East Palo Alto 

42 Sample2 Way #115

100 Sample3 Ave  |  Davis, CA 95616

1028 Sample4 Dr., San Jose, CA 95129


950 W. Grant Line Rd. Tracy, CA, 95376

235 South Sample5 Avenue, Sunnyvale, ca 94086 


The structure here is that components of an address are IN ORDER. For example, the house number always comes before the pre-direction in every advertisement. Similarly, the street name comes always before the street type. The order listed under 'DC_USPS_Address_Standards.doc' is upheld by 99% users. The only arbitrary formatting is between the whitespace of two components which are limited to spaces, pipes, commas, and dots. These are captured within the perl regular expression.

Why does this make sense?

In a Craigslist ad, most users are legitimate in their purpose of renting their house. If they are not available 24/7 to answer their emails, it is to their advantage to provide an address so people can stop by to examine the neighbourhood, front yard, and nearby schools (location, location, location).
A user will never enter '1000 SampleDrive San Jose, CA' or 'Sample, San Jose CA' (There could be a 'Sample Avenue') when the real address is '1000 Sample Drive San Jose, CA'. I assume the Cragslist user has best intentions in clearing listing the address. If not, it is likely to be a scam, and is invalid input. 

However, there are also exceptional cases:

'@123.456, 78.9z'

larkin at pacific

Sample Way

Fortunately, these cases are always under a valid google map and yahoo map reference. The program clicks on the 'google map' link and uses the Google Geocode API to find the formatted address in the returned json file. The house number and street type are mandatory. If they are not present, the google maps will provide the proper address. If there is no google map and the house number or street type is absent, I will assume that the post is invalid or malicious in intent.

The housing data such as rent, square feet, garage, laundry, parking, and cities are structured by Cragislist when the user creates a post. Hence, they are all in two uniform areas: the title of the post or right hand side.



* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
=======
# Craigslist-Housing-Data-Parser
This R program parses raw housing data from craigslist for further analysis.
>>>>>>> 6c6522cd16abfaa10583bc3fde1448bd553dc306
