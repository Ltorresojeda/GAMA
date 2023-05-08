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

# change coordinates of a geometry from one spatial reference to another
kern_ammonia_st <- st_transform(kern_ammonia_sf, crs = 4326)
kern_shp_3338 <- st_transform(kern_shp, crs = 4326)


well_id_joined <- st_join(kern_shp_3338, kern_ammonia_st, join = st_contains)
plot(well_id_joined["gm_result"], axes = TRUE)



##### exploring arguments in geom_sf plot

kern_plot <- ggplot(data=kern_shp_3338) + 
                    geom_sf(fill = "antiquewhite") +
                    xlab("Longitude") + ylab("Latitude") +
                    ggtitle("Kern County") +
                    theme(panel.grid.major = element_line(color = gray(.5), 
                          linetype = "dashed", size = 0.5), 
                          panel.background = element_rect(fill = "white"))
kern_plot                    

# well locations
kern_well_plot <- ggplot(data=kern_ammonia_sf) + 
                  geom_sf(fill = "antiquewhite") +
                  xlab("Longitude") + ylab("Latitude") +
                  ggtitle("Wells with Ammonia Measurement in Kern County")
kern_well_plot     

# plotting joined shp and sf object

kern_ammonia_plot <- ggplot() + 
  geom_sf(data = kern_shp_3338, fill = NA, lwd = 0.5, col = 'black') +
  geom_point(data = kern_ammonia_sf, 
             aes( x = gm_longitude, 
                  y = gm_latitude),
             col = 'white',
             fill = 'cadetblue4',
             shape = 21,
             size = 3,
             alpha = 0.4) +
  theme_void() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("Wells with Ammonia Measurement in Kern County")
kern_ammonia_plot   
