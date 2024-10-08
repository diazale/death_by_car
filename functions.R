count_occurences <- function(in_, status_, exact=FALSE){
  if (exact==TRUE){
    # Statuses like "dead" and "life-threatening injury" are matched exactly
    # Others like "injury" or "critical" can be sub-strings
    return(nrow(subset(in_, status==status_)))
  } else {
    return(nrow(subset(in_, grepl(status_, status, fixed = TRUE))))
  }
}

filter_incidents <- function(data_, incident_ids_){
  # Given a set of incident IDs, return a subset
  # incident_ids: vector of ID variables
  # data_: data to subset
  return(subset(data_, incident_id %in% incident_ids_))
}

subset_by_date <- function(data_, max_date_=NA, min_date_=NA){
  # Given a min and max date, return all incidents between them (inclusive)
  # If only one of min or max is provided, return the data after/before the date
  # min_date/max_date: character in format YYYY-MM-DD
  # data_: data to subset
  
  # Subset the incidents by the dates desired
  if (!is.na(min_date_) & !is.na(max_date_)){
    # Both min and max dates provided, give all data between.
    return(subset(incidents, lubridate::ymd(max_date_) <= date & date <= lubridate::ymd(min_date_)))
  } else if (!is.na(min_date_)){
    # No max date: give everything after the min date
    return(subset(incidents, lubridate::ymd(min_date_) <= date))
  } else if (!is.na(max_date_)){
    # No min date: give everything before the max date
    return(subset(incidents, date <= lubridate::ymd(max_date_)))
  }
}

#' Get IDs of all incidents between an inclusive date range
#' If no start date is provided, get everything before the end date
#' If no end date is provided, get everything after the start date
#'
#' @param data_ Data frame/tibble, Input data
#' @param start_date_ YYYY-MM-DD character
#' @param end_date_ YYYY-MM-DD character
#'
#' @return Vector of incident_id values between the date range, inclusive
#'
#' @examples
#' winter_incident_ids <- incident_id_by_date(incidents, "2022-12-21","2023-03-20")
#' after_spring_incident_ids <- incident_id_by_date(incidents, start_date_="2023-03-20")
incident_ids_by_date <- function(data_, start_date_=NA, end_date_=NA){
  
  # Subset the incidents by the dates desired
  if (!is.na(end_date_) & !is.na(start_date_)){
    # Both min and max dates provided, give all data between.
    temp_data_ <- subset(data_, lubridate::ymd(start_date_) <= date & date <= lubridate::ymd(end_date_))
  } else if (is.na(end_date_)){
    # No end date: give everything after the start date
    temp_data_ <- subset(data_, lubridate::ymd(start_date_) <= date)
  } else if (is.na(start_date_)){
    # No start date: give everything before the end date
    temp_data_ <- subset(data_, date <= lubridate::ymd(end_date_))
  }
  
  return(temp_data_$incident_id)
}


#' incident_ids_by_variable
#'
#' @param data_ Data frame/tibble, input data (incidents)
#' @param variable_ Character, column name
#' @param value_ Character, value to filter by
#'
#' @return Vector of incident IDs
#'
#' @examples toronto_ids <- incident_ids_by_variable(incidents, "region","Toronto")
#' @exmaples quebec_ids <- incident_ids_by_variable(incidents, "province","QC")
incident_ids_by_variable <- function(data_, variable_, value_){
  return(data_[data_[[variable_]]==value_,]$incident_id)
}

#' incident_ids_by_substring
#'
#' @param data_ Data frame/tibble, input data
#' @param variable_ Character, column name to use
#' @param substring_ Substring to search
#'
#' @return Vector of incident IDs
#'
#' @examples
incident_ids_by_substring <- function(data_, variable_, substring_){
  return(data_[grepl(substring_, data_[[variable_]]),]$incident_id)
  
}

# Same as above, but takes a vector of keys
incident_ids_by_keys <- function(data_, variable_, keys_){
  return(data_[grep(paste(keys_, collapse = "|"), data_[[variable_]]),]$incident_id)
}

incidents[incident_ids_by_substring(incidents, "location", "Park"),]

group_ages <- function(in_data){
  # Given a data frame with columns for age or approximate age (age_range), give an age group
  # This uses the vector age_ranges, defined in dicts.R
  # Returns the data frame with the new column "age_group"
  
  # First use the actual age, if available
  in_data <- in_data %>%
    mutate(
      age_group = case_when(
        !is.na(age) & age < 18 ~ "Under 18",
        !is.na(age) & age > 64 ~ "65 and older",
        !is.na(age) ~ "18 to 64"
      )
    )
  
  # If there is no age, but there is an age range (e.g. "senior"), use the named vector with its equivalencies
  in_data$age_group <- ifelse(is.na(in_data$age_group) & !is.na(in_data$age_range), # If there is no age, but there is age_range...
                              age_ranges[match(as.character(in_data$age_range), names(age_ranges))], # Match to age_range
                              in_data$age_group) # Otherwise, don't do anything
  
  return(in_data)
}

generate_subsets <- function(ids_){
  # Given a vector of incident IDs, generate a subset of all data frames
  # Input: ids (vector)
  # Output: List of data frames of incidents, sources, vehicles, pedestrians, cyclists, others, structures, people in vehicles
  incidents_subs <- subset(incidents, incident_id %in% ids_)
  sources_subs <- subset(sources, incident_id %in% ids_)
  vehicles_subs <- subset(vehicles, incident_id %in% ids_)
  pedestrians_subs <- subset(pedestrians, incident_id %in% ids_)
  cyclists_subs <- subset(cyclists, incident_id %in% ids_)
  others_subs <- subset(others, incident_id %in% ids_)
  in_vehicles_subs <- subset(in_vehicles, incident_id %in% ids_)
  structures_subs <- subset(structures, incident_id %in% ids_)
  
  return(list(incidents_subs,
              sources_subs,
              vehicles_subs, 
              pedestrians_subs,
              cyclists_subs,
              others_subs,
              in_vehicles_subs,
              structures_subs))
}

quick_sub <- function(in_, ids_){
  # Quick subset of data based on incident ID so I don't have to keep typing it out
  subset(in_, incident_id %in% ids_)
}
