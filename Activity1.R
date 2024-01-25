library(rvest)
library(httr)
library(dplyr) 
library(polite)

library(kableExtra)

polite::use_manners(save_as = 'polite_scrape.R')

url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225009011&rh=n%3A%2116225009011%2Cn%3A172541&ref=nav_em__nav_desktop_sa_intl_headphones_0_2_5_8'
session <- bow(url,
               user_agent = "Educational")


Des_list <- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>% 
  html_text
desl<-length(Des_list)


price_list <- scrape(session) %>%
  html_nodes('span.a-price') %>% 
  html_text
split_df <- strsplit((price_list),"$",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))
split_df<-split_df[-2]

price_df<-split_df
price_df<-price_df[1:desl,2]



rate_list <- scrape(session) %>%
  html_nodes('span.a-icon-alt') %>% 
  html_text
Rate<-rate_list
Rate<-Rate[1:desl]
Rate<-as.data.frame(Rate)



numberofreviews_list <- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>% 
  html_text
numberofreviews_list<-numberofreviews_list[1:desl]
Category1<-cbind(Des_list,price_df,Rate,numberofreviews_list)
colnames(Category1)<-c("Description","Price","Ratings","Number of Reviews")
Category1
#-----------------------------------------------------------------------------

url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=4954955011&rh=n%3A4954955011%2Cn%3A%212617942011%2Cn%3A2237329011&ref=nav_em__nav_desktop_sa_intl_needlework_0_2_8_8'
session <- bow(url,
               user_agent = "Educational")


Des_list <- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>% 
  html_text
desl<-length(Des_list)


price_list <- scrape(session) %>%
  html_nodes('span.a-price') %>% 
  html_text
split_df <- strsplit((price_list),"$",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))
split_df<-split_df[-2]

price_df<-split_df
price_df<-price_df[1:desl,2]



rate_list <- scrape(session) %>%
  html_nodes('span.a-icon-alt') %>% 
  html_text
Rate<-rate_list
Rate<-Rate[1:desl]
Rate<-as.data.frame(Rate)



numberofreviews_list <- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>% 
  html_text
numberofreviews_list<-numberofreviews_list[1:desl]
Category2<-cbind(Des_list,price_df,Rate,numberofreviews_list)
Category2
#--------------------------------------------------------------------

url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225009011&rh=n%3A%2116225009011%2Cn%3A502394&ref=nav_em__nav_desktop_sa_intl_camera_and_photo_0_2_5_3'
session <- bow(url,
               user_agent = "Educational")


Des_list <- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>% 
  html_text
desl<-length(Des_list)


price_list <- scrape(session) %>%
  html_nodes('span.a-price') %>% 
  html_text
split_df <- strsplit((price_list),"$",fixed = TRUE)
split_df <- data.frame(do.call(rbind,split_df))
split_df<-split_df[-2]

price_df<-split_df
price_df<-price_df[1:desl,2]



rate_list <- scrape(session) %>%
  html_nodes('span.a-icon-alt') %>% 
  html_text
Rate<-rate_list
Rate<-Rate[1:desl]
Rate<-as.data.frame(Rate)



numberofreviews_list <- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>% 
  html_text
numberofreviews_list<-numberofreviews_list[1:desl]
Category3<-cbind(Des_list,price_df,Rate,numberofreviews_list)
Category3

