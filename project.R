library(tidyverse)
tank <- read_csv('Shark Tank Companies.csv')

summary(tank)
str(tank)
cor(tank$deal,tank$askedFor)
cor(tank$deal,tank$exchangeForStake)
cor(tank$deal, tank$valuation)
cor(tank$askedFor, tank$valuation)

tank[c('askedFor','exchangeForStake','valuation')] %>% cor()

tank %>% ggplot(aes(askedFor, valuation)) + geom_point() 

tank %>% ggplot() +geom_bar(mapping = aes(x = category), tank$deal)

###Tidy up the data so that the categories each have their own stuff in them
##furthemore try analyzing corre
tank %>% filter(deal) %>% select(c(category,deal)) -> modtank
count(modtank,category) -> countn
keep(countn$category, countn$n > 5)->categories

modtank[categories]

ggplot() + geom_bar(mapping = aes(x=category))
