library(tidyverse)
library(stringr)
library(leaflet)
library(sf)
library(janitor)
library(lubridate)

#turn off scientific notation
options(scipen=999)


# Get/download active FEDERAL WILDFIRE LOCATIONS from NFIS (points only)
# Data lives here:https://nifc.maps.arcgis.com/home/item.html?id=4181a117dc9e43db8598533e29972015

# (Already downloaded, but if you want to download again, just un-comment this out)
# try(download.file("https://services3.arcgis.com/T4QMspbfLg3qTGWY/arcgis/rest/services/WFIGS_Incident_Locations_Current/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson",
# "data/active_incidents.geojson"))


#read in data
active_incidents <- st_read("data/active_incidents.geojson")

# filter for wildfire data only (IncidentTypeCategory == "WF") and incidents that are at least 50 acres
# Then, select relevant columns
# Then, change dates to pretty format
active_incidents_wildfires <- active_incidents %>% 
  filter(IncidentTypeCategory == "WF",
         IncidentSize >= 50) %>% 
  select(OBJECTID, IncidentName, ContainmentDateTime, IncidentSize, PercentContained, POOCity, POOCounty, POOState, POOProtectingAgency, EstimatedCostToDate, EstimatedFinalCost, ModifiedOnDateTime_dt) %>% 
  mutate(ModifiedOnDateTime_dt = ModifiedOnDateTime_dt/1000,
         ModifiedOnDateTime_dt = as.POSIXct(ModifiedOnDateTime_dt, origin="1970-01-01", tz = "America/Los_Angeles"),
         ModifiedOnDateTime_dt_pretty = format(as.POSIXct(ModifiedOnDateTime_dt), format = "%b %d, %Y at %I:%M %p %Z")
         )


# make a test map with leaflet to make sure everything looks the way it should
test_map <- leaflet() %>% 
  addProviderTiles("CartoDB.Positron.Labels") %>% 
  addCircleMarkers(data = active_incidents_wildfires)

test_map


# everything looks good! Let's export as a geojson
st_write(active_incidents_wildfires, "output/active_incidents_wildfires.geojson", append = FALSE)


