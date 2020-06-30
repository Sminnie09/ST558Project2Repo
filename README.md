ST558 Project 2
================
Noel Hilliard
July 3, 2020

  - [Introduction](#introduction)
  - [Online News Popularity Data](#online-news-popularity-data)
  - [Summary Statistics](#summary-statistics)
  - [Modeling](#modeling)
      - [Ensemble Model: Bagged Tree](#ensemble-model-bagged-tree)

Project Objective: The goal is to create models for predicting the
`shares` variable from the dataset. You will create two models: a linear
regression model and a non-linear model (each of your choice). You will
use the parameter functionality of markdown to automatically generate an
analysis report for each `weekday_is_*` variable (so you’ll end up with
seven total outputted documents).

# Introduction

# Online News Popularity Data

``` r
#read in data#

library(tidyverse)

newsData <-read_csv("S:/ST558/Homeworks/Project 2/ST558 Project 2/OnlineNewsPopularity.csv")
newsData$shares_group <- NA

#ifelse(newsData$shares < 1400, newsData$shares_group == "below 1400" , newsData$shares_group == "above 1400")


#split shares into 2 groups
for (i in 1:length(newsData$shares)){
  
  if(newsData$shares[i] < 1400){
    newsData$shares_group[i] <- "below 1400"
  }
  
  if(newsData$shares[i] >= 1400){
    newsData$shares_group[i] <- "above 1400"
  }
}


newsData$shares_group <- as.factor(newsData$shares_group)

#paste column name for day of week
#day <- paste0('weekday_is_', params$day)

#filter for day of week
#weekdayData <- filter(newsData, day == "1")
weekdayData <- filter(newsData, weekday_is_monday == "1")
```

``` r
#binary classification#

#initialize column for shares groups



#factor share groups
```

``` r
#Create test/train data sets from filtered data set
set.seed(1)
train <- sample(1:nrow(weekdayData), size = nrow(weekdayData)*0.7)
test <- dplyr::setdiff(1:nrow(weekdayData), train)
weekdayDataTrain <- weekdayData[train, ]
weekdayDataTest <- weekdayData[test, ]
```

# Summary Statistics

# Modeling

## Ensemble Model: Bagged Tree

``` r
library(caret)

set.seed(1)
trCtrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

bag_fit <- train(shares_group ~ num_keywords + avg_positive_polarity + num_videos + num_imgs, 
                 data = weekdayDataTrain, method = "treebag", trControl = trCtrl, 
                 preProcess = c("center", "scale"))

bag_fit
```

    ## Bagged CART 
    ## 
    ## 4662 samples
    ##    4 predictor
    ##    2 classes: 'above 1400', 'below 1400' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 4196, 4197, 4196, 4196, 4195, 4196, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa     
    ##   0.5125164  0.02478471

``` r
bag_pred <- predict(bag_fit, newdata = weekdayDataTest)

head(bag_pred)
```

    ## [1] above 1400 below 1400 below 1400 below 1400 above 1400 above 1400
    ## Levels: above 1400 below 1400

``` r
bag_fitInfo <- tbl_df(data.frame(bag_pred, weekdayDataTest$shares_group, weekdayDataTest$num_keywords, 
                                weekdayDataTest$avg_positive_polarity,
                                 weekdayDataTest$num_videos, weekdayDataTest$num_imgs))

bag_fitInfo
```

    ## # A tibble: 1,999 x 6
    ##    bag_pred weekdayDataTest~ weekdayDataTest~ weekdayDataTest~ weekdayDataTest~
    ##    <fct>    <fct>                       <dbl>            <dbl>            <dbl>
    ##  1 above 1~ below 1400                      4            0.287                0
    ##  2 below 1~ below 1400                      7            0.411                0
    ##  3 below 1~ below 1400                      9            0.428                0
    ##  4 below 1~ above 1400                      7            0.567                0
    ##  5 above 1~ below 1400                      5            0.298                1
    ##  6 above 1~ above 1400                      8            0.404                0
    ##  7 above 1~ above 1400                      7            0.435                0
    ##  8 below 1~ below 1400                      8            0.376                0
    ##  9 above 1~ above 1400                      8            0.427                0
    ## 10 below 1~ above 1400                     10            0.408                0
    ## # ... with 1,989 more rows, and 1 more variable: weekdayDataTest.num_imgs <dbl>

``` r
bag_tbl <- table(bag_fitInfo$bag_pred, bag_fitInfo$weekdayDataTest.shares_group)

bag_tbl
```

    ##             
    ##              above 1400 below 1400
    ##   above 1400        547        490
    ##   below 1400        479        483

``` r
bag_misClass <- 1 - sum(diag(bag_tbl))/sum(bag_tbl)

bag_misClass
```

    ## [1] 0.4847424
