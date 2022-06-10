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

subset_by_date <- function(data_, min_date_=NA, max_date_=NA){
  # Given a min and max date, return all incidents between them (inclusive)
  # If only one of min or max is provided, return the data after/before the date
  # min_date/max_date: character in format YYYY-MM-DD
  # data_: data to subset
  
  # Subset the incidents by the dates desired
  if (!is.na(min_date_) & !is.na(max_date_)){
    # Both min and max dates provided, give all data between.
    return(subset(incidents, lubridate::ymd(min_date_) <= date & date <= lubridate::ymd(max_date_)))
  } else if (!is.na(min_date_)){
    # No max date: give everything after the min date
    return(subset(incidents, lubridate::ymd(min_date_) <= date))
  } else if (!is.na(max_date_)){
    # No min date: give everything before the max date
    return(subset(incidents, date <= lubridate::ymd(max_date_)))
  }
}

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