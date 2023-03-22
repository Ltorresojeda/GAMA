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

# load shape file
CA_counties <- read_sf("~/Desktop/data/gama/CA_Counties/CA_Counties_TIGER2016.shp")

# parse out Kern + Ammonia for plotting
kern_ammonia <- kern %>%
  filter(gm_chemical_name == "Ammonia") %>%
  select(county, gm_well_id, gm_chemical_name, gm_result, gm_result_units,
         gm_samp_collection_date, gm_latitude, gm_longitude)

# transform gm_samp_collection_date from character to date
kern_ammonia$gm_samp_collection_date <- as.Date(kern_ammonia$gm_samp_collection_date, format ="%m/%d/%y")


