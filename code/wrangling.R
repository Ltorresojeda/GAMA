# general use
library(here) # file organization
library(tidyverse) # manipulating
library(sf) # reading in spatial data, etc.
library(janitor) # cleaning variable names
library(randomcoloR) # random color generator
library(ggplot2) # visualization

# load in data
kern <- read_csv(here("data", "usgs_monitoring_allchem_kern.csv")) %>%
  clean_names() %>%
  add_column(county = "KERN")

madera <- read_csv(here("data", "usgs_monitoring_madera.csv")) %>%
  clean_names()  %>%
  add_column(county = "MADERA")

tulare <- read_csv(here("data", "usgs_monitoring_tulare.csv")) %>%
  clean_names() %>%
  add_column(county = "TULARE")

# join all data
all_chemicals <- rbind(kern, madera, tulare)