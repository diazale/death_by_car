# Define dictionaries for our data (parent categories, etc)

# Health status
# Look at data first to build on it
#unique(c(as.character(pedestrians$status), as.character(cyclists$status), as.character(others$status)))

##### Injury categories #####

injury_categories <- c()
injury_categories[["dead"]] <- "Dead"
injury_categories[["critical injury"]] <- "Critical"
injury_categories[["minor injury"]] <- "Minor"
injury_categories[["uninjured"]] <- "Uninjured"
injury_categories[["life-threatening injury"]] <- "Critical"
injury_categories[["serious injury"]] <- "Major"
injury_categories[["non life-threatening injury"]] <- "Major"
injury_categories[["non life-threatening head injury"]] <- "Major"
injury_categories[["serious, non life-threatening"]] <- "Major"
injury_categories[["stable condition"]] <- "Major"
injury_categories[["serious, non life-threatening injury"]] <- "Major"
injury_categories[["hospitalization for injury"]] <- "Major"
injury_categories[["significant injury"]] <- "Major"
injury_categories[["unspecified injury"]] <- "Major"
injury_categories[["injury"]] <- "Minor"
injury_categories[["head injury"]] <- "Major"
injury_categories[["serious head injury"]] <- "Major"
injury_categories[["non-life-threatening injury"]] <- "Major"
injury_categories[["non-life-threatening head injury"]] <- "Major"
injury_categories[["major injury"]] <- "Major"
injury_categories[["taken to hospital with injury"]] <- "Major"
injury_categories[["taken to hospital with minor injury"]] <- "Minor"
injury_categories[["serious, non-life-threatening injury"]] <- "Major"
injury_categories[["major injury, fracture leg"]] <- "Major"
injury_categories[["arm and elbow injury"]] <- "Minor"
injury_categories[["unknown injury"]] <- "Minor"
injury_categories[["face and arm injury"]] <- "Major"
injury_categories[["upper body injury"]] <- "Major"
injury_categories[["hospital injury"]] <- "Major"
injury_categories[["life-altering injury"]] <- "Critical"
injury_categories[["airlifted to hospital with injury"]] <- "Major"
injury_categories[["significant non-life-threatening injury"]] <- "Major"
injury_categories[["non life-threatening"]] <- "Major"
injury_categories[["sever injury"]] <- "Major"

# Usage example:
# pedestrians$injury_type <- injury_categories[match(as.character(pedestrians$status), names(injury_categories))]

##### Vehicle classes #####
vehicle_types <- c()
vehicle_types[["car"]] <- "Car"
vehicle_types[["SUV"]] <- "SUV"
vehicle_types[["truck"]] <- "Truck"
vehicle_types[["delivery truck"]] <- "Large truck"
vehicle_types[["garbage truck"]] <- "Large truck"
vehicle_types[["bus"]] <- "Bus or streetcar"
vehicle_types[["pickup truck"]] <- "Pickup truck"
vehicle_types[["van"]] <- "Van"
vehicle_types[["transport truck"]] <- "Large truck"
vehicle_types[["cargo truck"]] <- "Large truck"
vehicle_types[["large truck"]] <- "Large truck"
vehicle_types[["cube-style truck"]] <- "Large truck"
vehicle_types[["U-Haul truck"]] <- "Large truck"
vehicle_types[["small vehicle"]] <- "Car"
vehicle_types[["industrial forklift"]] <- "Other"
vehicle_types[["minivan"]] <- "Van"
vehicle_types[["camionnette"]] <- "Pickup truck"
vehicle_types[["snow plow"]] <- "Other"
vehicle_types[["motorcycle"]] <- "Other"
vehicle_types[["school bus"]] <- "Bus or streetcar"
vehicle_types[["grader"]] <- "Other"
vehicle_types[["flatbed truck"]] <- "Large truck"
vehicle_types[["dump truck"]] <- "Large truck"
vehicle_types[["shuttle bus"]] <- "Bus or streetcar"
vehicle_types[["pickup truck plow"]] <- "Other"
vehicle_types[["forklift"]] <- "Other"
vehicle_types[["commercial truck"]] <- "Large truck"
vehicle_types[["streetcar"]] <- "Bus or streetcar"
vehicle_types[["mail truck"]] <- "Large truck"
vehicle_types[["cement truck"]] <- "Large truck"
vehicle_types[["street sweeper"]] <- "Other"
vehicle_types[["excavator"]] <- "Other"

##### Age groups #####
# Age group (Under or Over 18)
unique(c(as.character(pedestrians$age_range), as.character(cyclists$age_range), as.character(others$age_range)))

age_ranges <- c()
age_ranges[["early 30s"]] <- "18 to 64"
age_ranges[["70s"]] <- "65 and older"
age_ranges[["child"]] <- "Under 18"
age_ranges[["60s"]] <- "18 to 64"
age_ranges[["20-40"]] <- "18 to 64"
age_ranges[["50s"]] <- "18 to 64"
age_ranges[["mid 30s"]] <- "18 to 64"
age_ranges[["20s"]] <- "18 to 64"
age_ranges[["late teens/early 20s"]] <- "18 to 64"
age_ranges[["adult"]] <- "18 to 64"
age_ranges[["teen"]] <- "Under 18"
age_ranges[["under 12"]] <- "Under 18"
age_ranges[["30s"]] <- "18 to 64"
age_ranges[["toddler"]] <- "Under 18"
age_ranges[["80s"]] <- "65 and older"
age_ranges[["40s"]] <- "18 to 64"
age_ranges[["senior"]] <- "65 and older"
age_ranges[["infant"]] <- "Under 18"
age_ranges[["elderly"]] <- "65 and older"
age_ranges[["50s or 60s"]] <- "18 to 64"
age_ranges[["youth"]] <- "Under 18"
age_ranges[["45 to 55"]] <- "18 to 64"
age_ranges[["teenager"]] <- "Under 18"
age_ranges[["83"]] <- "65 and older"
age_ranges[["environ même age"]] <- "65 and older"
age_ranges[["girl"]] <- "Under 18"
age_ranges[["grade 4"]] <- "Under 18"
age_ranges[["late 40s"]] <- "18 to 64"
age_ranges[["young boy"]] <- "Under 18"
age_ranges[["boy, youth"]] <- "Under 18"
age_ranges[["adolescent"]] <- "Under 18"
age_ranges[["16 to 21"]] <- "Under 18"
age_ranges[["late 60s"]] <- "65 and older"
age_ranges[["under 12"]] <- "Under 18"
age_ranges[["60s or 70s"]] <- "65 and older"
age_ranges[["40s or 50s"]] <- "18 to 64"
age_ranges[["moins de 10 ans"]] <- "Under 18"

##### Metro areas #####

# Look at regions and classify as Greater [X] Area
greater_toronto <- c("Ajax","Aurora","Brampton","Brock","Burlington","Caledon","Clarington","East Gwillimbury","Georgina",
                     "Halton Hills","King","Markham","Milton","Mississauga","Newmarket","Oakville","Oshawa","Pickering",
                     "Richmond Hill","Scugog","Toronto","Uxbridge","Vaughan","Whitby","Whitchurch-Stouffville")
greater_montreal <- c()
greater_vancouver <- c()
greater_victoria <- c()



