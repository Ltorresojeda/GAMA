library(tidyverse)
library(here)
library(janitor)

arsenic <- read_csv(here("data/kern_AS.csv")) %>% 
  clean_names()

str(arsenic)

#change the collection date insead of character

arsenic$Date <- as.Date(arsenic$gm_samp_collection_date, format = "%m/%d/%y")
arsenic$Month <- format(arsenic$Date, "%m")
arsenic$Year <- format(arsenic$Date, "%Y")


