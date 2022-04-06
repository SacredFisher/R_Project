# What makes a Billboard Top 3 Song?
 The project.R file contains the code wherein the analysis of the <a href = https://www.billboard.com/charts/hot-100/>Billboard Hot 100</a> Songs is done. To answer what makes a Billboard song popular, we must investigate the properties of each of the songs, and compare them to the properties of songs that did not perform as well as others on the Billboard Charts. We accomplish this by comparing those whose maximum rank on the Hot 100 chart was at least 3, and songs that stayed on the charts the longest, with songs that stayed on the charts for less than a week, and songs that whose maximum rank did not surpass 75.

 Finding these songs within particular ranges of years is not very complicated. However, analyzing songs and figuring out their properties is. Luckily, we are able to 
invesigate based on the song analytics provided by the <a href=https://developer.spotify.com/documentation/web-api/reference/#/operations/get-playlist> Spotify Developer Web API </a>. From this we can get a variety of song statistics, like those provided by various song ranking websites like <a href=https://tunebat.com/> Tunebat</a>. These include: Tempo, Energy, Dancibility, Happiness, and many more subjective properties of songs that have been quantified on a 0 to 1 scale by Spotify. Combining this data with the Billboard Hot 100 Data from this <a href=https://www.kaggle.com/datasets/dhruvildave/billboard-the-hot-100-songs> Kaggle Dataset </a>, we can find the correlation between different properties and compare them between songs that have found great success on the Billboard and songs that have not. 


### [Slide Deck](https://docs.google.com/presentation/d/1cGgpLqONIsODmYG46yCfOVgKW3p2KcB3OZm1x5-XH34/edit?usp=sharing)

## Introduction and Question
The Billboard Hot 100 is a ranking for popular songs. This chart is notable for taking into consideration not only number of records sold, but also time played on radio, streaming, and other metrics. The ranking is so popular that many artists found their careers on ranking consistently high on the charts, or gain further popularity by advertising their single as reaching the Top 10, 5, 3, and/or 1. However, there are many songs that do not reach these levels of popularity, and stay amongst the bottom of the charts. Therefore, we want to ask: is there a correlation between properties of songs and song prominence on the Billboard?

## Techniques Utilized
We will answer the above question by finding all the songs that have had a peak rank of less than 75 on the charts (successful songs, but not 'chart toppers'), and compare how their song charachteristics correlate to the 'weeks on chart', and the 'peak rank' of the song. Furthermore, we perform the same analysis of song charachteristics for the songs that have had a peak rank at or above 3 (the 'chart toppers'). Comparing the attributes found for each group of songs, we can obtain some insight into how the different properties of songs effect the peak Billboard rank and the weeks on the chart.

<!-- 
## Analyzing the Chart Musical Trends-- 
 *See behavior of musical charachterstics on charts over time, just for baseline. 
## Analyzing Bottom of Charts--
 * Songs that have not broken the peaks, what are their attributes over the years?
 * What are some commonalities between their properties?
 * Show Correlation table and graphs, Show change in correlations over years, or 
something over the years.

## Analyzing the top of Charts--
* Songs that have broken the 3 peak, what are their attributes over the years. What are some Commonalities?
* Correlation Table from section, show change over the years. 

## Takeaway
We can see that while correlation doesnt reflect causation--it's highly likely that the music is 

## Future Works
Extend by being able to abstact to other critical playlists, and incoporate an AI to try and predict what types of songs will be popular in the future?




-->



