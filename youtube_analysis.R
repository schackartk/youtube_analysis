library(tidyverse)
library(jsonlite)
library(lubridate)

# Import data
raw_watch_history <- fromJSON("Takeout_2/YouTube/history/watch-history.json")

# Begin to tidy the data & delete uninformative columns
watch_history <- raw_watch_history %>% 
  as_tibble() %>% flatten() %>% as_tibble() %>% 
  select(-description, -titleUrl, -products, -header)

# Clean song title strings 
watch_history$title <- watch_history$title %>% 
  gsub(pattern = "Watched ", replacement = "")

# Fix time formatting and data type
watch_history$time <- watch_history$time %>% 
  gsub(pattern = "T", replacement = " ")  %>% 
  gsub(pattern = "Z", replacement = "") %>% ymd_hms()
