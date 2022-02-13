library(tidyverse)
library(plyr)
library(stringr)
library(RColorBrewer)
library(writexl)
library(data.table)
library(readxl)
library(ggcorrplot)
library(patchwork)
library(gtools)


charts <- read_csv('charts.csv')
songs <- read_csv('song_data.csv')

coul <- colorRampPalette(brewer.pal(8, "PRGn"))(25)

#regularize name column
songs<-songs%>%dplyr::rename(song = song_name)




##Approach 
nuchart <- charts %>% filter(date >= '1997-08-31', rank<=5, `peak-rank`<=3) %>% distinct(song, artist, .keep_all = T) %>% left_join(songs, by = "song") %>% distinct(song, artist , .keep_all =T) %>% 
  select(date, rank, song, artist, `peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness) %>%
  as.data.frame() %>% write_xlsx('/home/srikar/Code/R_Project/top.xlsx')



#1997 onwards
full<-read_excel('topfill.xlsx')
full %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% heatmap(col = coul)


#1997 to 2000
#pmatrix
p.mat90 <- full %>%  filter(date < '2000-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% cor_pmat()
#corr matrix and plot
plt_1<- full %>%  filter(date < '2000-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% 
  ggcorrplot(type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat90) +labs(title="1997-2000 Correlations")
#  ggcorrplot( hc.order = TRUE, type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat90) +labs(title="1997-2000 Correlations")




#2000 to 2005
#pmatrix
p.mat00 <- full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% cor_pmat()
#corr matrix and plot
plt_2<-full %>%  filter(date >= '2000-01-01' & date<="2005-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>%
  ggcorrplot(type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat00) +labs(title="2001-2005 Correlations")

#ggcorrplot( hc.order = TRUE, type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat00) +labs(title="2001-2005 Correlations")


#2005 to 2010
#pmatrix
p.mat05 <- full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% cor_pmat()
#corr matrix and plot 
plt_3<-full %>%  filter(date >= '2006-01-01' & date <= "2010-12-31") %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>%
  ggcorrplot(type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat05) +labs(title="2006-2010 Correlations")
#  ggcorrplot( hc.order = TRUE, type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat05) +labs(title="2006-2010 Correlations")


 
#2010 to 2015
#pmatrix
p.mat10<- full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% cor_pmat()
#corr matrix and plot 
plt_4<-full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>%
  ggcorrplot( type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat10) +labs(title="2011-2015 Correlations")
# ggcorrplot( hc.order = TRUE, type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat10) +labs(title="2011-2015 Correlations")




#2015 to 2021
#pmatrix
p.mat15<- full %>% filter(date >= '2016-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>% cor_pmat()
#corr matrix and plot 
plt_5<-full %>% filter(date >= '2016-01-01') %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
  as.matrix() %>% cor(use="complete.obs") %>%
  ggcorrplot( type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat15) +labs(title="2016-2021 Correlations")

#  ggcorrplot( hc.order = TRUE, type = "lower", lab = TRUE, insig = "blank", p.mat = p.mat15) +labs(title="2016-2021 Correlations")




#Plot One
(plt_1 + plt_2+ plt_3) 

#Plot Two
(plt_4 |plt_5)





##Investigating the Acoustic Songs in 2010-2015
full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') %>% select(`weeks-on-board`)



filt<- full %>%  filter(date >= '2011-01-01' & date <= '2015-12-31') 
x<-filt$`weeks-on-board` 
filt$normalized = (x-min(x))/(max(x)-min(x))
filt$weeks_quartile<-quantcut(normalized, 4)

temp<-full %>%filter(date >= '2011-01-01' & date <= '2015-12-31', `weeks-on-board` >29) 
temp$acousticness %>% sd()

filt %>% 
  ggplot() + geom_boxplot(aes(weeks_quartile, acousticness, group = weeks_quartile)) + labs(title="The Longest Lasting Songs were Acoustic")


##2016-2021






















































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

