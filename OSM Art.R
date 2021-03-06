# OSM Art.R
# Create streetmaps with OSMs
# Created by Aja Manu on 21/02/2020

# based on:
# https://ggplot2tutor.com/streetmaps/streetmaps/

#### Load library---------------------------------------------------------------

# Load library
library(tidyverse)
library(osmdata)

#### Get Map--------------------------------------------------------------------

# Get bounding box
getbb("Bondi Beach, Australia")

# get major streets
streets <- getbb("Bondi Beach, Australia")%>%
        opq()%>%
        add_osm_feature(key = "highway", 
                        value = c("motorway", "primary", 
                                  "secondary", "tertiary")) %>%
        osmdata_sf()
streets

# get small streets
small_streets <- getbb("Bondi Beach, Australia")%>%
        opq()%>%
        add_osm_feature(key = "highway", 
                        value = c("residential", "living_street",
                                  "unclassified",
                                  "service", "footway")) %>%
        osmdata_sf()

# get coast line
coast <- getbb("Bondi Beach, Australia")%>%
        opq()%>%
        add_osm_feature(key = "natural", value = "coastline") %>%
        osmdata_sf()

# plot data
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

# can use to rezise
coord_sf(xlim = c(151.26, 151.28), 
         ylim = c(-33.895, -33.885),
         expand = FALSE)

#### More Artistic Plot

# https://github.com/deanmarchiori/culburra/blob/master/culburra.Rmd

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
        theme_minimal() +
        labs(caption = "Bondi Beach",
             y = "") +
        theme(
                plot.background = element_rect(fill = "#E4D9C6", color = NA),
                panel.background = element_rect(fill = "#E4D9C6",  color = NA),
                panel.grid = element_blank(), 
                axis.text = element_text(colour = "#C7B18A", family = "Ubuntu Mono"),
                axis.ticks = element_blank(), 
                panel.border = element_blank(), 
                plot.caption = element_text(family = "Ubuntu Mono", size = 65, vjust = -0.2, color = '#C7B18A'))