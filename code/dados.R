#---------------------------------------------------------------------
# Alissa Mune & Bruna Wundervald
# R-Ladies Meetup, 21 de Março de 2019
# Usando purrrr com dados do googleAnalyticsR
#---------------------------------------------------------------------

library(googleAnalyticsR)
library(tidyverse)

ga_auth()

ga_id <- 191857260

range <- c("2019-03-20", "2019-03-21")

Pages_Data <- google_analytics(ga_id,
                             date_range = range,
                             dimensions = c("userType","pageTitle","sourceMedium", "landingPagePath", "pageDepth"),
                             metrics = c("sessions","entrances", "pageviews", "timeOnPage", "exits", "organicSearches"))

Geo_Data <- google_analytics(ga_id,
                             date_range = range,
                             dimensions = c("userType","pageTitle","sourceMedium","city"),
                             metrics = c("sessions","entrances", "pageviews", "timeOnPage", "exits","organicSearches"))

city_filter <- dim_filter("ga:city", "EXACT", "Sao Paulo")

city_filter <- filter_clause_ga4(list(city_filter))

Geo_Data_Filtered <- google_analytics(ga_id,
                             date_range = range,
                             dimensions = c("userType","pageTitle","sourceMedium","city"),
                             metrics = c("sessions","entrances", "pageviews", "timeOnPage", "exits","organicSearches"),
                             dim_filters = city_filter)

Search_Data <- google_analytics(ga_id,
                              date_range = range,
                              dimensions = c("referralPath", "sourceMedium", "keyword", "socialNetwork"),
                              metrics =  c("sessions","entrances", "pageviews", "timeOnPage", "exits","organicSearches"),
                              anti_sample = TRUE)
RLadies <- list(Geo_Data, Geo_Data_Filtered, Pages_Data, Search_Data, city_filter)
save(RLadies,file = "RLadies.RData")
