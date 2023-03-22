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