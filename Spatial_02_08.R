library(tidyverse)
library(here)
library(janitor)
library(terra)
library(sf)
library(rgdal)

# load in data
kern <- read_csv(here("data", "usgs_monitoring_allchem_kern.csv")) %>%
  clean_names()
kern$county <- "KERN"

madera <- read_csv(here("data", "usgs_monitoring_madera.csv")) %>%
  clean_names() 
madera$county <- "MADERA"

tulare <- read_csv(here("data", "usgs_monitoring_tulare.csv")) %>%
  clean_names() 
tulare$county <- "TULARE"

# join all data
all_chemicals <- rbind(kern, madera, tulare)

# rasterize data
chemicals_sf <- st_as_sf(all_chemicals, 
                   coords = c('gm_longitude', 'gm_latitude'),
                   crs = 4326,
                   remove = F)

chemicals_st <- st_transform(chemicals_sf, crs = 3338)

plot(chemicals_st["gm_well_id"])
