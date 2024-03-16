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
moviedate<-movies3k$datelist
library(lubridate)
moviedate <- as.POSIXlt(moviedate, format = "%d %B %Y")
moviedate

finaloutput<-data.frame(cbind(movietitle,moviereviewer,movierate,moviereviewtitle,moviereview))

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
#direct inserting in the database
dbWriteTable(connection,name="movies",value=finaloutput,row.names=FALSE,append=TRUE)
#inserting the database information to a vector
finaldata<-dbGetQuery(connection,"SELECT * FROM movie3000.movies")
View(finaldata)
#transforming the database information to a csv
write.csv(finaldata,file="Activity5finalouput_from_the_database")
