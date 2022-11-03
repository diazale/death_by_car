# Import data
library(tidyverse)

cyclists <- read_csv("data/cyclists", col_names = TRUE,
                     col_types = cols(
                       col_double(), # incident ID
                       col_double(), # cyclist ID
                       col_factor(), # sex
                       col_double(), # age
                       col_character(), # age range
                       col_factor(), # status
                       col_character(), # location
                       col_character() # notes
                     ))

pedestrians <- read_csv("data/pedestrians", col_names = TRUE,
                        col_types = cols(
                          col_double(), # incident ID
                          col_double(), # pedestrian ID
                          col_factor(), # sex
                          col_double(), # age
                          col_character(), # age range
                          col_factor(), # status
                          col_character(), # location
                          col_character() # notes
                        ))

others <- read_csv("data/other", col_names = TRUE,
                   col_types = cols(
                     col_double(), # incident ID
                     col_double(), # other ID
                     col_factor(), # sex
                     col_double(), # age
                     col_character(), # age range
                     col_factor(), # status
                     col_character(), # location
                     col_character() # notes
                   ))

incidents <- read_csv("data/incidents", col_names = TRUE,
                      col_types = cols(
                        col_double(), # incident ID
                        col_date(), # date
                        col_character(), # time
                        col_character(), # approx time
                        col_character(), # country
                        col_character(), # province
                        col_character(), # region
                        col_character(), # location
                        col_double(), # revision/project ID
                        col_character(), # entry date-time
                        col_character() # notes
                      ))

# Drop notes
incidents <- incidents[,-c(which(colnames(incidents)=="notes"))]

# Add DOW
incidents$dow <- lubridate::wday(incidents$date, label = T)
incidents <- incidents[,c(1,2,11,3,4,5,6,7,8,9,10)]
#temp <- incidents$time
#temp2 <- lubridate::parse_date_time(temp, orders = c("%H:%M %p"))

#incidents$time <- lubridate::parse_date_time(incidents$time,orders=c("%I:%M %p"))

vehicles <- read_csv("data/vehicles", col_names = TRUE,
                     col_types = cols(
                       col_double(), # incident ID
                       col_double(), # vehicle ID
                       col_factor(), # type
                       col_character(), # make
                       col_character(), # model
                       col_character(), # year
                       col_character(), # work flag
                       col_character() # notes
                     ))

in_vehicles <- read.csv("data/in_vehicles")
structures <- read.csv("data/structures")
sources <- read.csv("data/sources")
