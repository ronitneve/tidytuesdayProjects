library(tidyverse)
library(skimr)


#import data
Tdata <- tidytuesdayR::tt_load('2021-05-25')
records <- Tdata$records

#initial Exploration
glimpse(records)

records %>% 
  skim()

records_tt <- records %>% 
  mutate(track = factor(track))
glimpse(records_tt)

#create box plot  
# add alpha 0.6 and switch x and y values in the box plot, add Fill = type in aes()
records_tt %>% 
  ggplot(aes(x = record_duration, y=track, fill = type)) + 
  geom_boxplot(alpha=0.6)

ggsave("mario_cart.png", last_plot(), device = "png")
  