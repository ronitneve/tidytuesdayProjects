library(tidyverse)
library(lubridate)
library(skimr)

# import data
summary <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-06-01/summary.csv')

dim(summary)
names(summary)
glimpse(summary)

#converting character colls to factors
summary_tidy <- summary %>% 
  mutate(across(where(is.character), as.factor)) %>%
  #calculate the time intervals for airdates
  mutate(days_filming = time_length(
    interval(filming_started, filming_ended), unit = "days"))  %>%
  mutate(days_aired = time_length(
    interval(premiered, ended), unit = "days")) %>% 
  #remove orignal date columns
  select(-premiered:-filming_ended) %>%
  #pivot data: combine metrics for show type
  pivot_longer(
    cols = viewers_premier:viewers_reunion,
    names_to = "show_type",
    names_prefix = "viewers_",
    values_to = "total_views",
    values_drop_na = TRUE)

summary_tidy %>% 
  filter(show_type %in% c("premier", "finale")) %>% 
  ggplot(aes(x=viewers_mean, y=total_views)) + 
  geom_point(aes(color = show_type))

summary_tidy %>% 
  group_by(season) %>% 
  summarise(views = mean(viewers_mean)) %>% 
  ggplot(aes(x=season, y=views)) +
  geom_point()



  