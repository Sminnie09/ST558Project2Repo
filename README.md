ST558 Project 2
================
Noel Hilliard
July 3, 2020

  - [Introduction Online News Popularity
    Data](#introduction-online-news-popularity-data)
  - [monday Data](#monday-data)
  - [Summary Statistics](#summary-statistics)
      - [Histogram](#histogram)
  - [Modeling](#modeling)
      - [Ensemble Model: Bagged Tree](#ensemble-model-bagged-tree)
      - [Select Best Multiple Linear Regression
        Model](#select-best-multiple-linear-regression-model)

Project Objective: The goal is to create models for predicting the
`shares` variable from the dataset. You will create two models: a linear
regression model and a non-linear model (each of your choice). You will
use the parameter functionality of markdown to automatically generate an
analysis report for each `weekday_is_*` variable (so you’ll end up with
seven total outputted documents).

[Monday](MondayAnalysis.md)

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
discussed is a multiple linear regression model. Both types of models
were trained/tuned using the training data set and then then predictions
were made using the test data set.

The following libraries are loaded for the analysis.

``` r
library(ggplot2)
library(Hmisc)
library(rmarkdown)
library(tidyverse)
library(corrplot)
library(knitr)
library(caret)
```

# monday Data

The full data set contained data for all days of the week. This analysis
will focus on the data from monday. Once the data was filtered for
monday, the `shares` variable was divided into two groups: \< 1400 and
\>= 1400 in preparation for fitting the bagged tree model.

``` r
#read in data
newsData <-read_csv("S:/ST558/Homeworks/Project 2/ST558 Project 2/OnlineNewsPopularity.csv")
newsData$shares_group <- NA

#filter for day of week
weekdayData <- filter(newsData, newsData[[paste0("weekday_is_",params$day)]] == "1")


#split shares into 2 groups
for (i in 1:length(weekdayData$shares)){
  
  if(weekdayData$shares[i] < 1400){
    weekdayData$shares_group[i] <- "below 1400"
  }
  
  if(weekdayData$shares[i] >= 1400){
    weekdayData$shares_group[i] <- "above 1400"
  }
}

weekdayData$shares_group <- as.factor(weekdayData$shares_group)
```

The following variables were used in this analysis to predict the
`shares` variable:

  - `num_keywords` : Number of keywords in the metadata.
  - `avg_positive_polarity` : Average polarity of positive words.
  - `num_videos`: Number of videos.
  - `num_imgs`: Number of images.
  - `max_postive_polarity`: Maximum polarity of positive words.
  - `title_subjectivity`: Title subjectivity.
  - `rate_negative_words`: Rate of negative words among non-neutral
    tokens.
  - `n_unique_tokens`: Number of words in the title.
  - `average_token_length`: Average length of the words in the content.
  - `global_rate_positive_words`: Rate of positive words in the content.
  - `shares`: Number of shares.

The data frame below shows the subsetted data set with only the
variables of interest for this analysis.

``` r
weekdayData <- weekdayData %>% select(num_keywords, avg_positive_polarity, num_videos, num_imgs, 
           max_positive_polarity, title_subjectivity, rate_negative_words,
           n_unique_tokens, average_token_length, global_rate_positive_words, shares, shares_group)

head(weekdayData)
```

    ## # A tibble: 6 x 12
    ##   num_keywords avg_positive_po~ num_videos num_imgs max_positive_po~
    ##          <dbl>            <dbl>      <dbl>    <dbl>            <dbl>
    ## 1            5            0.379          0        1              0.7
    ## 2            4            0.287          0        1              0.7
    ## 3            6            0.496          0        1              1  
    ## 4            7            0.386          0        1              0.8
    ## 5            7            0.411          0       20              1  
    ## 6            9            0.351          0        0              0.6
    ## # ... with 7 more variables: title_subjectivity <dbl>,
    ## #   rate_negative_words <dbl>, n_unique_tokens <dbl>,
    ## #   average_token_length <dbl>, global_rate_positive_words <dbl>, shares <dbl>,
    ## #   shares_group <fct>

The subsetted data set was randomly sampled using the `sample` function.
The training data set consists of 70% of the data and the testing data
set consists of 30% of the data. The `set.seed` function was used to
make the work reproducible.

``` r
#Create test/train data sets from filtered data set
set.seed(1)
train <- sample(1:nrow(weekdayData), size = nrow(weekdayData)*0.7)
test <- dplyr::setdiff(1:nrow(weekdayData), train)
weekdayDataTrain <- weekdayData[train, ]
weekdayDataTest <- weekdayData[test, ]
```

# Summary Statistics

This section covers some basic summary statistics about the variables in
the training data set.

## Histogram

The histogram below shows the distribution of `shares` using the
training data set.

``` r
g <- ggplot(weekdayDataTrain, aes(x = shares))
g + geom_histogram(bins = 100)
```

![](README_files/figure-gfm/histogram-1.png)<!-- -->

The bar graph below shows the counts for the two groups of shares.

``` r
g <- ggplot(data = weekdayDataTrain, aes(x = shares_group))
g + geom_bar() + labs(x = "Shares Group", title = (paste0(capitalize(params$day)," Shares Groups")))
```

![](README_files/figure-gfm/bar%20plot-1.png)<!-- -->

``` r
table(weekdayDataTrain$shares_group)
```

    ## 
    ## above 1400 below 1400 
    ##       2365       2297

``` r
TrainStatSum <- function(group){
  data <- weekdayDataTrain %>% filter(shares_group == group) %>% 
    select(num_keywords, avg_positive_polarity, num_videos, num_imgs, 
           max_positive_polarity, title_subjectivity, rate_negative_words,
           n_unique_tokens, average_token_length, global_rate_positive_words)
           kable(apply(data, 2, summary, col.names = c("num_keywords", 
           "avg_positive_polarity", "num_videos", "num_imgs", "max_positive_polarity", 
           "title_subjectivity", "rate_negative_words", "n_unique_tokens", "average_token_length",
           "global_rate_positive_words")))
}
```

``` r
TrainStatSum("above 1400")
```

|         | num\_keywords | avg\_positive\_polarity | num\_videos | num\_imgs | max\_positive\_polarity | title\_subjectivity | rate\_negative\_words | n\_unique\_tokens | average\_token\_length | global\_rate\_positive\_words |
| ------- | ------------: | ----------------------: | ----------: | --------: | ----------------------: | ------------------: | --------------------: | ----------------: | ---------------------: | ----------------------------: |
| Min.    |       2.00000 |               0.0000000 |    0.000000 |  0.000000 |               0.0000000 |           0.0000000 |             0.0000000 |         0.0000000 |               0.000000 |                     0.0000000 |
| 1st Qu. |       6.00000 |               0.3060905 |    0.000000 |  1.000000 |               0.6000000 |           0.0000000 |             0.1764706 |         0.4689119 |               4.475000 |                     0.0294118 |
| Median  |       7.00000 |               0.3604167 |    0.000000 |  1.000000 |               0.8000000 |           0.1500000 |             0.2692308 |         0.5442804 |               4.648230 |                     0.0393228 |
| Mean    |       7.27907 |               0.3537985 |    1.380127 |  4.673573 |               0.7582498 |           0.2890607 |             0.2785470 |         0.5264764 |               4.506621 |                     0.0397244 |
| 3rd Qu. |       9.00000 |               0.4121212 |    1.000000 |  5.000000 |               1.0000000 |           0.5000000 |             0.3684211 |         0.6075949 |               4.830467 |                     0.0503979 |
| Max.    |      10.00000 |               0.8666667 |   74.000000 | 93.000000 |               1.0000000 |           1.0000000 |             1.0000000 |         0.9000000 |               5.971660 |                     0.1194539 |

``` r
TrainStatSum("below 1400")
```

|         | num\_keywords | avg\_positive\_polarity | num\_videos | num\_imgs | max\_positive\_polarity | title\_subjectivity | rate\_negative\_words | n\_unique\_tokens | average\_token\_length | global\_rate\_positive\_words |
| ------- | ------------: | ----------------------: | ----------: | --------: | ----------------------: | ------------------: | --------------------: | ----------------: | ---------------------: | ----------------------------: |
| Min.    |      1.000000 |               0.0000000 |    0.000000 |  0.000000 |               0.0000000 |           0.0000000 |             0.0000000 |         0.0000000 |               0.000000 |                     0.0000000 |
| 1st Qu. |      6.000000 |               0.3038841 |    0.000000 |  1.000000 |               0.6000000 |           0.0000000 |             0.2000000 |         0.4783505 |               4.476431 |                     0.0271186 |
| Median  |      7.000000 |               0.3565605 |    0.000000 |  1.000000 |               0.8000000 |           0.1000000 |             0.3000000 |         0.5413712 |               4.663551 |                     0.0373057 |
| Mean    |      7.023509 |               0.3542173 |    1.353505 |  4.081846 |               0.7557345 |           0.2646893 |             0.3037970 |         0.5353332 |               4.565993 |                     0.0382616 |
| 3rd Qu. |      8.000000 |               0.4121212 |    1.000000 |  2.000000 |               1.0000000 |           0.5000000 |             0.4029851 |         0.6100796 |               4.852632 |                     0.0487805 |
| Max.    |     10.000000 |               1.0000000 |   50.000000 | 91.000000 |               1.0000000 |           1.0000000 |             0.9402985 |         1.0000000 |               6.512690 |                     0.1213873 |

``` r
correlation <- cor(weekdayDataTrain %>% select(num_keywords, avg_positive_polarity, num_videos, num_imgs, 
           max_positive_polarity, title_subjectivity, rate_negative_words,
           n_unique_tokens, average_token_length, global_rate_positive_words), method = "spearman")

corrplot(correlation, type = "upper", tl.pos = "lt")
```

![](README_files/figure-gfm/correlation-1.png)<!-- -->

# Modeling

## Ensemble Model: Bagged Tree

``` r
set.seed(1)
trCtrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

bag_fit <- train(shares_group ~ num_keywords + avg_positive_polarity + num_videos + num_imgs, 
                 data = weekdayDataTrain, method = "treebag", trControl = trCtrl, 
                 preProcess = c("center", "scale"), na.action = na.pass)

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

## Select Best Multiple Linear Regression Model

``` r
mlrFit1 <- lm(shares ~ num_keywords + avg_positive_polarity + 
                num_videos + num_imgs, data = weekdayDataTrain)

mlrFit2 <- lm(shares ~ max_positive_polarity + title_subjectivity, 
              data = weekdayDataTrain)

mlrFit3 <- lm(shares ~ num_keywords + rate_negative_words,
              data = weekdayDataTrain)

mlrFit4 <- lm(shares ~ n_unique_tokens + average_token_length + 
                 global_rate_positive_words, data = weekdayDataTrain)
```

``` r
library(MuMIn)

compareFitStats <- function(mlrFit1, mlrFit2, mlrFit3, mlrFit4){
  fitStats <- data.frame(fitStat = c("Adj R Square", "AIC", "BIC"),
  col1 = c(round(summary(mlrFit1)$adj.r.squared, 5), AIC(mlrFit1),
                 BIC(mlrFit1)),
  col2 = c(round(summary(mlrFit2)$adj.r.squared, 5), AIC(mlrFit2),
                 BIC(mlrFit2)),
  col3 = c(round(summary(mlrFit3)$adj.r.squared, 5), AIC(mlrFit3),
                BIC(mlrFit3)),
  col4 = c(round(summary(mlrFit4)$adj.r.squared, 5), AIC(mlrFit4),
                BIC(mlrFit4)))
  
  #put names in data frame
  calls <- as.list(match.call())
  calls[[1]] <- NULL
  names(fitStats[2:5]) <- unlist(calls)
  fitStats
}
```

``` r
fitStats <- compareFitStats(mlrFit1, mlrFit2, mlrFit3, mlrFit4)
```

``` r
mlrFit1_pred <- predict(mlrFit1, newdata = weekdayDataTest)
RMSE(weekdayDataTest$shares, mlrFit1_pred)
```

    ## [1] 17559.41

``` r
mlrFit4_pred <- predict(mlrFit4, newdata = weekdayDataTest)
RMSE(weekdayDataTest$shares, mlrFit4_pred)
```

    ## [1] 17577.04
