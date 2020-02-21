# OSM Art.R
# Create streetmaps with OSMs
# Created by Aja Manu on 21/02/2020

# based on:
# https://ggplot2tutor.com/streetmaps/streetmaps/

#### Load library---------------------------------------------------------------

library(tidyverse)
library(osmdata)

getbb("Bondi Beach, Australia")

streets <- getbb("Bondi Beach, Australia")%>%
        opq()%>%
        add_osm_feature(key = "highway", 
                        value = c("motorway", "primary", 
                                  "secondary", "tertiary")) %>%
        osmdata_sf()
streets

small_streets <- getbb("Bondi Beach, Australia")%>%
        opq()%>%
        add_osm_feature(key = "highway", 
                        value = c("residential", "living_street",
                                  "unclassified",
                                  "service", "footway")) %>%
        osmdata_sf()

coast <- getbb("Bondi Beach, Australia")%>%
        opq()%>%
        add_osm_feature(key = "natural", value = "coastline") %>%
        osmdata_sf()

ggplot() +
        geom_sf(data = streets$osm_lines,
                inherit.aes = FALSE,
                color = "#7fc0ff",
                size = .4,
                alpha = .8) +
        geom_sf(data = small_streets$osm_lines,
                inherit.aes = FALSE,
                color = "#ffbe7f",
                size = .2,
                alpha = .6) +
        geom_sf(data = coast$osm_lines,
                inherit.aes = FALSE,
                color = "#ffbe7f",
                size = .2,
                alpha = .5) +
        theme_void() +
        theme(
                plot.background = element_rect(fill = "#282828")
        )

coord_sf(xlim = c(151.26, 151.28), 
         ylim = c(-33.895, -33.885),
         expand = FALSE)
