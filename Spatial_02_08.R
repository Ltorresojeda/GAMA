library(tidyverse)
library(here)
library(janitor)

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
