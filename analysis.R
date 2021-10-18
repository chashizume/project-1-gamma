library(tidyverse)
library(ggplot2)
library(dplyr)

covid_data <- read.csv('covid_short_data_states.csv')
trend_search <- read.csv('Conspiracy - 2020_2021.csv')
# weekly_covid_cases <- covid_data %>% 
#     group_by(week = cut(date, "week")) %>% 
#     summarise(value = mean(cases))