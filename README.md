ST558 Project 2
================
Noel Hilliard
July 3, 2020

  - [Introduction](#introduction)
  - [Online News Popularity Data](#online-news-popularity-data)
  - [Modeling](#modeling)

Project Objective: The goal is to create models for predicting the
`shares` variable from the dataset. You will create two models: a linear
regression model and a non-linear model (each of your choice). You will
use the parameter functionality of markdown to automatically generate an
analysis report for each `weekday_is_*` variable (so you’ll end up with
seven total outputted documents).

# Introduction

# Online News Popularity Data

``` r
library(tidyverse)

newsData <-read_csv("S:/ST558/Homeworks/Project 2/ST558 Project 2/OnlineNewsPopularity.csv")

#paste column name for day of week
day <- paste0('weekday_is_', params$weekday)

#filter for day of week
weekdayData <- newsData %>% filter(!!as.name(day) == "1")
```

``` r
#Create test/train data sets from filtered data set
set.seed(1)
train <- sample(1:nrow(weekdayData), size = nrow(weekdayData)*0.7)
test <- dplyr::setdiff(1:nrow(weekdayData), train)
weekdayDataTrain <- weekdayData[train, ]
weekdayDataTest <- weekdayData[test, ]
```

# Modeling

``` r
library(caret)

#set.seed(1)
#trCtrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

#bag_fit <- train(shares ~ , data = newsDataTrain, method = "treebag", 
#trControl = trCtrl, preProcess = c("center", "scale"))

#bag_fit
```
