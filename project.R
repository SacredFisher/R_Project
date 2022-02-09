library(tidyverse)
orbits <- read_csv('orbits.csv')
impacts <- read_csv('impacts.csv')


full_join(orbits, impacts, by='Object Name')

