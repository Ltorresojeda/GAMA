# general use
library(here) # file organization
library(tidyverse) # manipulating
library(sf) # reading in spatial data, etc.
library(janitor) # cleaning variable names
library(randomcoloR) # random color generator

# Javascript package wrappers
library(leaflet) # interactive map
library(plotly) # interactive plots
library(ggiraph) # more interactive plots
library(echarts4r) # even more interactive plots


# read in wrangled data
source("code/wrangling.R")

# filter out kern county out of CA county shapefiles
kern_shp <- CA_counties %>%
  filter(NAME == "Kern") %>%
  select("geometry")
plot(kern_shp)

# rasterize data from kern ammonia (or turn in sf object)
kern_ammonia_sf <- st_as_sf(kern_ammonia,
                    coords = c('gm_longitude', 'gm_latitude'),
                    crs = 4326,
                    remove = F)

kern_ammonia_st <- st_transform(kern_ammonia_sf, crs = 4326)
kern_shp_3338 <- st_transform(kern_shp, crs = 4326)


well_id_joined <- st_join(kern_ammonia_st, kern_shp_3338,join = st_within)
plot(well_id_joined["gm_result"])



##### interactive plot

