library(dplyr, dbplyr)
library(RMySQL) 
library(RMariaDB)

#connection within the mysql
connection <- dbConnect(RMySQL::MySQL(), 
                        dsn="MySQL-connection",
                        Server = "localhost",
                        dbname = "cs102_10movies", 
                        user = "root", 
                        password = "")
#SHowing the List of Tables in the Database you inputted
dbListTables(connection)
#SHowing the List of Fields in the Database you inputted
dbListFields(connection,"movie")
#contain the Data within the database within the vector
my_data <- dbGetQuery(connection, "SELECT * FROM cs102_10movies.movie")
# checking for the columns and its content
glimpse(my_data)
#getting all data using SELECT * FROM dbaseNam
my_data[c(1:10),]
#alternative way to display selected fields
#displays the selected fields of the table
movies_data <- dbGetQuery(connection, "SELECT movie_title,reviewer,date_of_review,rating,title_of_the_reviews,reviews FROM cs102_10movies.movie")
movies_data[c(1:2),]
#getting all data using SELECT * FROM dbaseName
SqlQuery <- "SELECT movie_title,reviewer,rating,date_of_review,title_of_the_reviews,reviews FROM cs102_10movies.movie"
as_tibble(dbGetQuery(connection,SqlQuery))

#importing the previous file in the 3000 movie reviews for easy scraping and cleaning of data
previous_movie_scrape <- read.csv(file = "previous3000movies.csv")
#getting 10 movies within the previous 3000 movie reviews
movies_get10 <- previous_movie_scrape[c(2,301,601,901,1201,1503,1804,2102,2401,2709),]
movies_get10
tail(movies_get10)
View(movies_get10)
#containg the date list 
movie_datelist <- movies_get10[,4]
movie_datelist

#containing the movie title
movie_title <- movies_get10[,2]

# Identify strings containing special characters
contains_special <- grepl("[[:punct:]]", movie_title)

# Replace special characters in strings
movie_title[contains_special] <- gsub("[[:punct:]]", "", movie_title[contains_special])
movie_title

#containing the username of the reviewer
movie_username <- movies_get10[,3]
movie_username

#containing the rating and cleaning  all the /n and replacing it with "" which means nothing lang
movie_rating <- movies_get10[,5]
movierating_cut <- gsub("\n", "", movie_rating)
movie_rating <- movierating_cut
movie_rating

#containing all the review title and removing the /n and replaicing it with a ""
movie_reviewtitle <- movies_get10[,6]
moviereviewtitle_cut <- gsub("\n","", movie_reviewtitle)
movie_reviewtitle <- moviereviewtitle_cut
movie_reviewtitle

#containing all the review and removing all the possible special character that is not allowed and replacing it with a blank ""
movie_review <- movies_get10[,7]
moviereview_cut <- gsub("\"","", movie_review)
moviereview_cut<-gsub("'","",moviereview_cut)
moviereview_cut<-gsub(",","",moviereview_cut)
moviereview_cut<-gsub(":","",moviereview_cut)
movie_review <- moviereview_cut
movie_review


# linking it all using paste0 in order to make the code shorter kag para di budlay mag pasulod sa database sorry cant explain it well.
for (i in 1:10) {
  moviequery[i] <- paste0("INSERT INTO movie (movie_title, reviewer, date_of_review, rating, title_of_the_reviews, reviews) VALUES ('",
                          movie_title[i], "', '",
                          movie_username[i], "','",
                          movie_datelist[i], "', '",
                          movie_rating[i], "' , '",
                          movie_reviewtitle[i], "', '",
                          movie_review[i], "')")
}


#loop of these:
# insert values into MySQL
# Execute the query
for (i in 1:10){
  query<- moviequery[i]
  query_result <- dbSendQuery(connection, query)
}

#checking if the value was inserted into a table
glimpse(my_data)
#disconnect from dbase
dbDisconnect(connection)
