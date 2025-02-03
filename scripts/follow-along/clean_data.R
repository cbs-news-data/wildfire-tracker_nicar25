# install.packages("tidyverse")
# install.packages("stringr")
# install.packages("leaflet")
# install.packages("sf")
# install.packages("janitor")
# install.packages("lubridate")

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


# filter for wildfire data only (IncidentTypeCategory == "WF") and incidents that are at least 50 acres
# Then, select relevant columns
# Then, change dates to pretty format



# make a test map with leaflet to make sure everything looks the way it should



# everything looks good! Let's export as a geojson



