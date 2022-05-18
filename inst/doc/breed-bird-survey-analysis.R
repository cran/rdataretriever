## ---- eval=FALSE--------------------------------------------------------------
#  library(rdataretriever)
#  library(DBI)
#  library(dplyr)
#  library(dbplyr)
#  library(raster)
#  library(ggplot2)

## ---- echo = FALSE, results = "hide", eval=FALSE------------------------------
#  rdataretriever::get_updates()

## ---- echo = FALSE, results = "hide", eval=FALSE------------------------------
#  rdataretriever::install_sqlite('breed-bird-survey', 'bbs.sqlite')

## ---- eval=FALSE--------------------------------------------------------------
#  bbs_db <- dbConnect(RSQLite::SQLite(), 'bbs.sqlite')

## ---- eval=FALSE--------------------------------------------------------------
#  surveys <- tbl(bbs_db, "breed_bird_survey_counts")
#  sites <- tbl(bbs_db, "breed_bird_survey_routes")

## ---- eval=FALSE--------------------------------------------------------------
#  rich_data <- surveys %>%
#    filter(year == 2016) %>%
#    group_by(statenum, route) %>%
#    summarize(richness = n()) %>%
#    collect()
#  rich_data

## ---- eval=FALSE--------------------------------------------------------------
#  bioclim <- getData('worldclim', var = 'bio', res = 10)

## ---- eval=FALSE--------------------------------------------------------------
#  sites <- as.data.frame(sites)
#  sites_spatial <- SpatialPointsDataFrame(sites[c('longitude', 'latitude')], sites)

## ---- eval=FALSE--------------------------------------------------------------
#  bioclim_bbs <- extract(bioclim, sites_spatial) %>%
#    cbind(sites)
#  richness_w_env <- inner_join(rich_data, bioclim_bbs)
#  richness_w_env

## ---- eval=FALSE--------------------------------------------------------------
#  ggplot(richness_w_env, aes(x = bio12, y = richness)) +
#    geom_point(alpha = 0.5) +
#    labs(x = "Annual Precipitation", y = "Number of Species")

## ---- eval=FALSE--------------------------------------------------------------
#  ggplot(richness_w_env, aes(x = bio12, y = richness)) +
#    geom_point(alpha = 0.5) +
#    geom_smooth()

## ---- fig.height = 8, fig.width = 8, warning = FALSE, eval=FALSE--------------
#  richness_w_env_high_n <- richness_w_env %>%
#    group_by(statenum) %>%
#    filter(n() >= 50)
#  
#  ggplot(richness_w_env_high_n, aes(x = bio12, y = richness)) +
#    geom_point() +
#    geom_smooth() +
#    facet_wrap(~statenum, scales = 'free') +
#    labs(x = "Annual Precipitation", y = "Number of Species")

