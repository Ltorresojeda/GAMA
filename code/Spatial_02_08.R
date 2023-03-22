library(tidyverse)
library(here)
library(janitor)
library(terra)
library(sf)
library(rgdal)
library(ggplot2)
library(leaflet)
library(scales)
library(ggmap)


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

# load shape file
CA_counties <- read_sf("~/Desktop/data/gama/CA_Counties/CA_Counties_TIGER2016.shp")
plot(CA_counties)
str(CA_counties)

kern_region <- CA_counties %>%
        filter(NAME == "Kern") %>%
        select("geometry")
plot(kern_region)

# rasterize data
kern_sf <- st_as_sf(kern, 
                   coords = c('gm_longitude', 'gm_latitude'),
                   crs = 4326,
                   remove = F)

kern_st <- st_transform(kern_sf, crs = 3338)

kern_plot <- plot(kern_st["gm_well_id"])

kern_region_3338 <- st_transform(kern_region, crs = 3338)

well_id_joined <- st_join(kern_st, kern_region_3338, join = st_within)
plot(well_id_joined["gm_well_id"])
