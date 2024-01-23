library(rvest)
library(httr)
library(dplyr) 
library(polite)

library(kableExtra)

polite::use_manners(save_as = 'polite_scrape.R')

url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225007011&rh=n%3A16225007011%2Cn%3A172584&ref=nav_em__nav_desktop_sa_intl_scanners_0_2_6_12'
session <- bow(url,
               user_agent = "Educational")


Des_list <- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>% 
  html_text



price_list <- scrape(session) %>%
  html_nodes('span.a-price-whole') %>% 
  html_text

price_df<-price_list
price_df<-price_df[1:24]



rate_list <- scrape(session) %>%
  html_nodes('span.a-icon-alt') %>% 
  html_text
Rate<-rate_list
Rate<-Rate[1:24]
Rate<-as.data.frame(Rate)



numberofreviews_list <- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>% 
  html_text
numberofreviews_list<-numberofreviews_list[1:24]
Category1<-cbind(Des_list,price_df,Rate,numberofreviews_list)
colnames(Category1)<-c("Description","Price","Ratings","Number of Reviews")
Category1
#-----------------------------------------------------------------------------

url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225007011&rh=n%3A16225007011%2Cn%3A172635&ref=nav_em__nav_desktop_sa_intl_printers_0_2_6_11'

session <- bow(url,
               user_agent = "Educational")


title <- character(0)


Des_list <- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>% 
  html_text



price_list <- scrape(session) %>%
  html_nodes('span.a-price-whole') %>% 
  html_text
price_df<-price_list
price_df<-price_df[1:24]



rate_list <- scrape(session) %>%
  html_nodes('span.a-icon-alt') %>% 
  html_text

Rate<-rate_list
Rate<-Rate[1:24]
Rate<-as.data.frame(Rate)


numberofreviews_list <- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>% 
  html_text
numberofreviews_list<-numberofreviews_list[1:24]
Category2<-cbind(Des_list,price_df,Rate,numberofreviews_list)
Category2
#--------------------------------------------------------------------

url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225007011&rh=n%3A16225007011%2Cn%3A2348628011&ref=nav_em__nav_desktop_sa_intl_tablet_accessories_0_2_6_14'
session <- bow(url,
               user_agent = "Educational")


title <- character(0)


Des_list <- scrape(session) %>%
  html_nodes('span.a-size-base-plus.a-color-base.a-text-normal') %>% 
  html_text



price_list <- scrape(session) %>%
  html_nodes('span.a-price-whole') %>% 
  html_text
price_df<-price_list
price_df<-price_df[1:24]



rate_list <- scrape(session) %>%
  html_nodes('span.a-icon-alt') %>% 
  html_text

Rate<-rate_list
Rate<-Rate[1:24]
Rate<-as.data.frame(Rate)


numberofreviews_list <- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>% 
  html_text
numberofreviews_list<-numberofreviews_list[1:24]
Category3<-cbind(Des_list,price_df,Rate,numberofreviews_list)
Category3
