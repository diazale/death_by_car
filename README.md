# Death By Car

## Purpose

Each year in Canada, hundreds of pedestrians, cyclists, and workers are killed or badly wounded by drivers and their vehicles. It is a widespread, pervasive, and systemic problem; it is not limited to urban, suburban, or rural areas; it affects people of all ages. For many, it is the deadliest aspect of daily life.

The goal of this project is to scan news sources and track how many people are killed and injured by vehicles in Canada, in particular those who are not in vehicles themselves. I will be tweeting tallies and various findings via [@DeathByCar](https://twitter.com/DeathByCar).

## Scope

I am tracking incidents where drivers hit (or threaten to hit) people who are generally not considered vehicle traffic. This includes pedestrians, cyclists, workers (construction, police, EMS, etc), and some vehicles like snowmobiles. Some incidents, like workplace accidents or vehicles hitting buildings, are considered on a case-by-case basis. It does not include incidents such as car-motorcycle collisions.

The scope is currently limited to incidents in 2022, but as I continue filling backwards in time, I may expand it. I began this project April 25, 2022.

Update: As of September 2023, I have paused data collection to carry out some analyses.

## Methodology

I have a few scripts that check news feeds for keywords in English and French (which you can find in the files `keywords_en.txt` and `keywords_fr.txt`). These help me to find the most recent incidents. Otherwise, I manually crawl/search websites to focus on particular regions, time periods, etc, since these require using smaller local sources for which I have not yet created an automated process.

## Data

Data are organized into several tables. Each incident has an `incident_id` variable. Victims are put into three mutually exclusive tables: `pedestrians`, `cyclists`, and `other`. Each table contains unique IDs (respectively: `ped_id`, `cyc_id`, `oth_id`) and `incident_id` to link them together. Where available, I have recorded the age, sex, injury status, and location of the incident. Sometimes we are given an age range ("man in his 60s", "a small child", etc.) rather than a strict age. Notes contain relevant details, such as whether pets were also involved.

* `incidents`: master file, giving time, date, and location. There is exactly one row per incident. If a time is not given, approximate time is used (e.g. "early morning")
*  `vehicles`: details of vehicles involved. There may be more than one vehicle involved, so they are distinguished with the `vehicle_id` variable. Every incident will have at least one row for vehicles, even if there are no details available. Where available, I have noted the make and model of the vehicle, and made additional notes, such as whether the driver fled the scene. The variable `work` is set to `1` if the vehicle involved was a work vehicle, such as a delivery van, police car, bus, snowplough, etc.
*  `sources`: URL and archive URL (where possible) for incidents. Some incidents have multiple sources.
*  `pedestrians`: Pedestrians involved
*  `cyclists`: Cyclists involved
*  `other`: People involved who are not strictly pedestrians or cyclists, such as road workers, firefighters, EMS, people changing a tire, snowmobilers, horse-and-buggy, etc.
*  `in_vehicle`: People in the vehicles involved, where available. The `driver` flag is set to `1` to indicate that the individual was driving the vehicle at the time. Injury status is noted where available. Notes mention if there were arrests, charges, whether the strike was deliberate, etc.
* `structures`: Structures hit by drivers/vehicles, categorized as residential or non-residential. These are included when there is significant damage and/or victimization, even if no physical injuries are reported. While most are buildings, some are not (e.g. things like gazebos, sheds, patios, etc.). Damage is classified as "damaged" (e.g. a cracked window or door), "heavily damaged" (e.g. a structure or part of it is at least temporarily unusable), or "destroyed".

## Citation

If you use my data or would like to reference it, please credit me.

`Diaz-Papkovich, Alex. "Death By Car." 2022. https://github.com/diazale/death_by_car`

`@MISC{diazpapkovich2022,  
author = {Diaz-Papkovich, Alex},  
title = {Death By Car},  
month = April,  
year = {2022},  
howpublished={\url{https://github.com/diazale/death_by_car}}  
}`
