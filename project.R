library(tidyverse)
library(plyr)
library(stringr)
library(RColorBrewer)
library(writexl)
library(data.table)
library(readxl)

charts <- read_csv('charts.csv')
songs <- read_csv('song_data.csv')

coul <- colorRampPalette(brewer.pal(8, "PRGn"))(25)

#regularize name column
songs<-songs%>%dplyr::rename(song = song_name)

summary(charts)
summary(songs)


#gets peaks, ordered by rank. Gives top 10's for the past year until 2021, from 1990
charts <- charts %>% filter(`peak-rank` <= 100, date >= '1990-01-01')
summary(charts)


##Get chart for the 90's 
chart_90 <- charts %>% filter(date < '2000-01-01')
summary(chart_90)
sum(ddply(chart_90, .(date), nrow)['V1'])

##Get Chart for 00's, 
chart_00 <- charts %>% filter(date >= '2000-01-01' & date < '2010-01-01')
summary(chart_00)
sum(ddply(chart_90, .(date), nrow)['V1'])

##Get Chart for 10's 
chart_10  <- charts %>% filter(date >= '2010-01-01' & date < '2020-01-01')
summary(chart_10)
sum(ddply(chart_90, .(date), nrow)['V1'])

##Get Chart for 20's (so far)
chart_20 <- charts %>% filter(date >= '2020-01-01')
summary(chart_20)
sum(ddply(chart_90, .(date), nrow)['V1'])




##90's Cleaning and NEDA
songlst_90 <- chart_90 %>% select(date, rank, `peak-rank`, song, artist, `weeks-on-board`) %>% 
  distinct(song)
      #these songs need to be searched in the songs data now, since we have extracted them. 
songlst_90
j90 <- full_join(chart_90,songs, by = "song") %>% distinct(song, artist , .keep_all =T)
j90 %>% select(`peak-rank`,`weeks-on-board`,acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness) %>% 
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)
j90


##00's Clearning and NEDA
songlst_00 <-chart_00 %>% select(date, rank, `peak-rank`, song, artist, `weeks-on-board`) %>%
  distinct(song)
j00<- full_join(chart_00,songs, by = "song") %>% distinct(song, artist , .keep_all =T)
j00 %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness) %>% 
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)

##10's Clearing and NEDA 
songlst_10 <-chart_10 %>% select(date, rank, `peak-rank`, song, artist, `weeks-on-board`) %>%
  distinct(song)
j10<- full_join(chart_10,songs, by = "song") %>% distinct(song, artist , .keep_all =T)
j10 %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness) %>% 
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)




























##alternate approach 
nuchart <- charts %>% filter(date >= '1997-08-31', rank<=5, `peak-rank`<=3) %>% distinct(song, artist, .keep_all = T) %>% left_join(songs, by = "song") %>% distinct(song, artist , .keep_all =T) %>% 
  select(date, rank, song, artist, `peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness) %>%
  as.data.frame() %>% write_xlsx('/home/srikar/Code/R_Project/top.xlsx')



#1997 onwards
full<-read_excel('topfill.xlsx')
full %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)


#1997 to 2000
full %>%  filter(date < '2000-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)
full %>%  filter(date < '2000-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs")

#2000 to 2005
full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)
full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs")

#2005 to 2010
full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)
full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs")

#2010 to 2015
full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)
full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs")

#2015 to 2021
full %>% filter(date >= '2016-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)
full %>% filter(date >= '2016-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs")
















select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,
       instrumentalness,liveness,loudness, tempo, speechiness)



####Analysis##### 

#1997 to 2000
#Find Average stats 
nines <- full %>%  filter(date < '2000-01-01') %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness )

##More Acoustic
full %>%  filter(date < '2000-01-01') %>% 
    select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
    filter(acousticness > .5) %>% summary()
full %>%  filter(date < '2000-01-01') %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness > .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)

##Less Acoustic 
full %>%  filter(date < '2000-01-01') %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness < .5) %>% summary()
full %>%  filter(date < '2000-01-01') %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness < .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)




#2000 to 2005
##More Acoustic
full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness > .5) %>% summary()
full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness > .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)

##Less Aucoustic 
full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness < .5) %>% summary()
full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness < .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)




#2005 to 2010
#More Acu 
full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness > .5) %>% summary()
full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness > .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)



#Less Acu
full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness < .5) %>% summary()
full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness < .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)


#2010 to 2015
#more
full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness > .5) %>% summary()
  #to Plot
  full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% 
  select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
  filter(acousticness > .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)

#less
  full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% 
    select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
    filter(acousticness < .5) %>% summary()
  #to Plot
  full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% 
    select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
    filter(acousticness < .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)



#2015 to 2021
#more
  full %>%  filter(date >= '2016-01-01') %>% 
    select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
    filter(acousticness > .5) %>% summary()
  #to Plot
  full %>%  filter(date >= '2016-01-01') %>% 
    select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
    filter(acousticness > .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)

#less
  full %>%  filter(date >= '2016-01-01') %>% 
    select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
    filter(acousticness < .5) %>% summary()
  #to Plot
  full %>%  filter(date >= '2016-01-01') %>% 
    select(`peak-rank`, `weeks-on-board`,acousticness,danceability,energy, instrumentalness, happiness ) %>%
    filter(acousticness < .5) %>% as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)

