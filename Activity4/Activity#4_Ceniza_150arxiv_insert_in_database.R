#Zydrick Ceniza BSIT-2B

library(dplyr)
library(stringr)
library(httr)
library(rvest)

url <- 'https://arxiv.org/search/?query=%22data+base%22&searchtype=all&source=header&start=0'

parse_url(url)

start <- proc.time()
title <- NULL
author <- NULL
subject <- NULL
abstract <- NULL
meta <- NULL

pages <- seq(from = 0, to = 100, by = 50)

for( i in pages){
  
  tmp_url <- modify_url(url, query = list(start = i))
  tmp_list <- read_html(tmp_url) %>% 
    html_nodes('p.list-title.is-inline-block') %>% 
    html_nodes('a[href^="https://arxiv.org/abs"]') %>% 
    html_attr('href')
  
  for(j in 1:length(tmp_list)){
    
    tmp_paragraph <- read_html(tmp_list[j])
    
    # title
    tmp_title <- tmp_paragraph %>% html_nodes('h1.title.mathjax') %>% html_text(T)
    tmp_title <-  gsub('Title:', '', tmp_title)
    title <- c(title, tmp_title)
    
    # author
    tmp_author <- tmp_paragraph %>% html_nodes('div.authors') %>% html_text
    tmp_author <- gsub('\\s+',' ',tmp_author)
    tmp_author <- gsub('Authors:','',tmp_author) %>% str_trim
    author <- c(author, tmp_author)  
    
    # subject
    tmp_subject <- tmp_paragraph %>% html_nodes('span.primary-subject') %>% html_text(T)
    subject <- c(subject, tmp_subject)
    
    # abstract
    tmp_abstract <- tmp_paragraph %>% html_nodes('blockquote.abstract.mathjax') %>% html_text(T)
    tmp_abstract <- gsub('\\s+',' ',tmp_abstract)
    tmp_abstract <- sub('Abstract:','',tmp_abstract) %>% str_trim
    abstract <- c(abstract, tmp_abstract)
    
    # meta
    tmp_meta <- tmp_paragraph %>% html_nodes('div.submission-history') %>% html_text
    tmp_meta <- lapply(strsplit(gsub('\\s+', ' ',tmp_meta), '[v1]', fixed = T),'[',2) %>% unlist %>% str_trim
    meta <- c(meta, tmp_meta)
    cat(j, "paper\n")
    Sys.sleep(1)
    
  }
  cat((i/50) + 1,'/ 9 page\n')
  
}
papers <- data.frame(title, author, subject, abstract, meta)
end <- proc.time()
end - start # Total Elapsed Time
View(papers)
# Export the result
save(papers, file = "Arxiv_data_base.RData")
write.csv(papers, file = "Arxiv papers on data base.csv")



#-------------------------------------------------------
library(dplyr, dbplyr)
library(RMySQL) 
library(RMariaDB)

#connection within the mysql
connection <- dbConnect(RMySQL::MySQL(), 
                        dsn="MySQL-connection",
                        Server = "localhost",
                        dbname = "arxiv_150insert", 
                        user = "root", 
                        password = "")
#SHowing the List of Tables in the Database you inputted
dbListTables(connection)
#SHowing the List of Fields in the Database you inputted
dbListFields(connection,"arxivpapers")
#contain the Data within the database within the vector
my_data <- dbGetQuery(connection, "SELECT * FROM arxiv_150insert.arxivpapers")
# checking for the columns and its content
glimpse(my_data)
#getting all data using SELECT * FROM dbaseNam
my_data[c(1:10),]
#alternative way to display selected fields
#displays the selected fields of the table
movies_data <- dbGetQuery(connection, "SELECT title, author, subject, abstract, meta FROM arxiv_150insert.arxivpapers")
movies_data[c(1:2),]
#getting all data using SELECT * FROM dbaseName
SqlQuery <- "SELECT movie_title,reviewer,rating,date_of_review,title_of_the_reviews,reviews FROM arxiv_150insert.arxivpapers"
as_tibble(dbGetQuery(connection,SqlQuery))

dbWriteTable(connection, name = "arxivpapers", value = papers, row.names = FALSE, append = TRUE)

my_data <- dbGetQuery(connection, "SELECT * FROM arxiv_150insert.arxivpapers")
glimpse(my_data)
View(my_data)
write.csv(my_data,file="Activity4_lastoutput_150Arxiv.csv")
#disconnect from dbase
dbDisconnect(connection)

