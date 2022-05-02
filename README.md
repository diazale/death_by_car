# Death By Car

The goal of this project is to track how many people are killed and injured by vehicles in Canada. I began this project April 25, 2022.

## Scope

I am tracking incidents where drivers hit (or threaten to hit) people who are generally not considered vehicle traffic. This includes pedestrians, cyclists, workers (construction, police, EMS, etc), and some vehicles like snowmobiles. Some incidents, like workplace accidents or vehicles hitting buildings, are considered on a case-by-case basis. It does not include incidents such as car-motorcycle collisions.

The scope is currently limited to incidents in 2022, but as I continue filling backwards in time, I may expand it.

## Methodology

I have a few scripts that check news feeds for keywords in English and French (which you can find in the files `keywords_en.txt` and `keywords_fr.txt`). These help me to find the most recent incidents. Otherwise, I use [snowball sampling](https://en.wikipedia.org/wiki/Snowball_sampling) to focus on particular regions, time periods, etc, since these require using smaller local sources for which I have not yet created an automated process.

## Data

Data are organized into several tables. Each incident has an `incident_id` variable. Victims are put into three mutually exclusive tables: `pedestrians`, `cyclists`, and `other`. Each table contains unique IDs (respectively: `ped_id`, `cyc_id`, `oth_id`) and `incident_id` to link them together. Where available, I have recorded the age, sex, injury status, and location of the incident. Sometimes we are given an age range ("man in his 60s", "a small child", etc.) rather than a strict age. Notes contain relevant details, such as whether pets were also involved.

* `incidents`: master file, giving time, date, and location. There is exactly one row per incident. If a time is not given, approximate time is used (e.g. "early morning")
*  `vehicles`: details of vehicles involved. There may be more than one vehicle involved, so they are distinguished with the `vehicle_id` variable. Every incident will have at least one row for vehicles, even if there are no details available. Where available, I have noted the make and model of the vehicle, and made additional notes, such as whether the driver fled the scene. The variable `work` is set to `1` if the vehicle involved was a work vehicle, such as a delivery van, police car, bus, snowplough, etc.
*  `sources`: URL and archive URL (where possible) for incidents. Some incidents have multiple sources.
*  `pedestrians`: Pedestrians involved
*  `cyclists`: Cyclists involved
*  `other`: People involved who are not strictly pedestrians or cyclists, such as road workers, firefighters, EMS, people changing a tire, snowmobilers, etc.
*  `in_vehicle`: People in the vehicles involved, where available. The `driver` flag is set to `1` to indicate that the individual was driving the vehicle at the time. Injury status is noted where available. Notes mention if there were arrests, charges, whether the strike was deliberate, etc.

## Citation

If you use my data or would like to reference it, please credit me!

@MISC{diazpapkovich2022,
author = {Diaz-Papkovich, Alex},
title = {Death By Car},
month = April,
year = {2022},
howpublished={\url{https://github.com/diazale/death_by_car}}
}
