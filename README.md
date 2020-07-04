ST558 Project 2
================
Noel Hilliard
July 3, 2020

  - [Introduction Online News Popularity
    Data](#introduction-online-news-popularity-data)
  - [Analysis](#analysis)

Project Objective: The goal is to create models for predicting the
`shares` variable from the dataset. You will create two models: a linear
regression model and a non-linear model (each of your choice). You will
use the parameter functionality of markdown to automatically generate an
analysis report for each `weekday_is_*` variable (so you’ll end up with
seven total outputted documents).

The code below was used to create .md files for each day of the week by
calling the READMEtemplate.Rmd file in the `rmarkdown::render` function.
The `params` variable created a parameter for each day of the week and
the `output_file` variable created a file name for each day of the week.

``` r
library(rmarkdown)
library(tidyverse)
library(Hmisc)

#days of the week
days <- c("monday", "tuesday", "wednesday",
          "thursday", "friday", "saturday",
           "sunday")

#create file names
output_file <- paste0(capitalize(days), "Analysis.md")

#create a list for each day of the week with the day as parameter
params <- lapply(days, FUN = function(x){list(day = x)})

#put into data frame
#reports <- tibble(days, filename = output_file, params = purrr::map(days, ~list(day = .)))
reports <- tibble(filename = output_file, params)
```

``` r
apply(reports, MARGIN = 1, FUN = function(x){
  render("READMEtemplate.Rmd", 
         output_file = x[[1]], params = x[[2]])
})
```

# Introduction Online News Popularity Data

The data used for this analysis was obtained from the [UCI Machine
Learning
Reposititory](https://archive.ics.uci.edu/ml/datasets/Online+News+Popularity).
The data set summarizes a set of features about articles published by
Mashable over a two year period. The purpose of this analysis is to
predict the number of shares in social networks using select features
from the data set. Two types of methods will be used to predict the
`shares`. The first model discussed is a bagged tree model. For this
analysis, the `shares` were divided into two groups (\< 1400 and \>=
1400) to create a binary classification problem. The second model
discussed is linear regression. Both types of models were trained/tuned
using the training data set and then predictions were made using
the test data set.

# Analysis

The full data set contained data for all days of the week.

  - The analysis for [Monday is available here.](MondayAnalysis.md)

  - The analysis for [Tuesday is available here.](TuesdayAnalysis.md)

  - The analysis for [Wednesday is available here.](WednesdayAnalysis.md)

  - The analysis for [Thursday is available here.](ThursdayAnalysis.md)

  - The analysis for [Friday is available here.](FridayAnalysis.md)

  - The analysis for [Saturday is available here.](SaturdayAnalysis.md)

  - The analysis for [Sunday is available here.](SundayAnalysis.md)
