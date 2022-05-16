# Import data
library(tidyverse)

cyclists <- read_csv("data/cyclists", col_names = TRUE,
                     col_types = cols(
                       col_double(),
                       col_double(),
                       col_factor(),
                       col_double(),
                       col_character(),
                       col_factor(),
                       col_character(),
                       col_character()
                     ))

pedestrians <- read_csv("data/pedestrians", col_names = TRUE,
                        col_types = cols(
                          col_double(),
                          col_double(),
                          col_factor(),
                          col_double(),
                          col_character(),
                          col_factor(),
                          col_character(),
                          col_character()
                        ))

others <- read_csv("data/other", col_names = TRUE,
                   col_types = cols(
                     col_double(),
                     col_double(),
                     col_factor(),
                     col_double(),
                     col_character(),
                     col_factor(),
                     col_character(),
                     col_character()
                   ))

incidents <- read_csv("data/incidents", col_names = TRUE,
                      col_types = cols(
                        col_double(),
                        col_date(),
                        col_character(),
                        col_character(),
                        col_character(),
                        col_character(),
                        col_character(),
                        col_character(),
                        col_double(),
                        col_character()
                      ))

vehicles <- read_csv("data/vehicles", col_names = TRUE,
                     col_types = cols(
                       col_double(),
                       col_double(),
                       col_factor(),
                       col_character(),
                       col_character(),
                       col_character(),
                       col_character(),
                       col_character()
                     ))

in_vehicles <- read.csv("data/in_vehicles")
structures <- read.csv("data/structures")
sources <- read.csv("data/sources")
