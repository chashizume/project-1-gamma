library(tidyverse)
df_pop <- read.csv('ACSDP5Y2018.DP05_data_with_overlays_2021-10-17T154300.csv',
                   skip = 1, header = 2)

url_states <- 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv'

filename_nyt <- "./nyt_states.csv"

## Download the data locally
curl::curl_download(
  url_states,
  destfile = filename_nyt
)

## Loads the downloaded csv
df_covid <- read_csv(filename_nyt)
df_pop %>% glimpse
df_covid %>% glimpse
# data <- read.csv("covid_short_data.csv")
df_q3 <- df_pop %>% mutate(fips = str_sub(id, -5))
df_q4 <- df_q3 %>% 
  inner_join(df_covid, by='fips')

df_data <-
    df_q4 %>%
    select(
      date,
      state,
      fips,
      cases,
      deaths,
      population = Estimate..RACE..Total.population
    )

df_normalized <-
  df_data %>%
  mutate(cases_per100k = cases / population * 100000,
         deaths_per100k = deaths / population * 100000)

write.csv(df_normalized, 'covid_short_data_states.csv')