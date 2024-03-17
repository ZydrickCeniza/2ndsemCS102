movies3k<-read.csv("previous3000movies.csv")
View(movies3k)
#-------------------------------
movietitle<-tolower(movies3k$movietitle)
movietitle
#------------------------------
moviereviewer<-tolower(movies3k$usernamelist)
moviereviewer
#------------------------------------
movierate<-movies3k$ratelist
movierate<-gsub("\\s+","",movierate)
movierate
rate <- strsplit(movierate, "/")
rate<- data.frame(do.call(rbind,rate))
movierate<-mapply(function(x,y)as.numeric(x)/as.numeric(y),rate$X1,rate$X2)
movierate

#--------------------------------------------------
moviereviewtitle<-movies3k$reviewtitlelist
moviereviewtitle<-gsub("[^a-zA-Z0-9 ]", "", moviereviewtitle)
moviereviewtitle<-tolower(moviereviewtitle)
moviereviewtitle
#--------------------------------------------------
moviereview<-movies3k$reviewlist
moviereview<-gsub("[^a-zA-Z0-9 ]","",moviereview)
moviereview

#-------------------------------------------------
reviewdate<-movies3k$datelist
library(lubridate)
reviewdate <- as.POSIXct(reviewdate, format = "%d %B %Y")
reviewdate<-data.frame(reviewdate)
reviewdate
finaloutput<-data.frame(cbind(movietitle,moviereviewer,reviewdate,movierate,moviereviewtitle,moviereview))
View(finaloutput)
#---------------------------------------
library(dplyr, dbplyr)
library(RMySQL) 
library(RMariaDB)

#connection within the mysql
connection <- dbConnect(RMySQL::MySQL(), 
                        dsn="MySQL-connection",
                        Server = "localhost",
                        dbname = "movie3000", 
                        user = "root", 
                        password = "")
#SHowing the List of Tables in the Database you inputted
dbListTables(connection)
dbListFields(connection,"movies")

dbWriteTable(connection,name="movies",value=finaloutput,row.names=FALSE,append=TRUE)
finaldata<-dbGetQuery(connection,"SELECT * FROM movie3000.movies")
View(finaldata)
write.csv(finaldata,file="Activity5finalouput_from_the_database.csv")
