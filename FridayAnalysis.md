Friday Analysis
================
Noel Hilliard
July 3, 2020

  - [Introduction Online News Popularity
    Data](#introduction-online-news-popularity-data)
  - [Friday Data](#friday-data)
  - [Summary Statistics](#summary-statistics)
      - [Histogram](#histogram)
      - [Bar Plot](#bar-plot)
      - [Numerical Summary](#numerical-summary)
  - [Modeling](#modeling)
      - [Ensemble Model: Bagged Tree](#ensemble-model-bagged-tree)
      - [Select Linear Regression
        Model](#select-linear-regression-model)

Project Objective: The goal is to create models for predicting the
`shares` variable from the dataset. You will create two models: a linear
regression model and a non-linear model (each of your choice). You will
use the parameter functionality of markdown to automatically generate an
analysis report for each `weekday_is_*` variable (so you’ll end up with
seven total outputted documents).

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
using the training data set and then then predictions were made using
the test data set.

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

# Friday Data

The full data set contained data for all days of the week. This analysis
will focus on the data from friday. Once the data was filtered for
friday, the `shares` variable was divided into two groups: \< 1400 and
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
    ## 1           10            0.310          0        1             0.75
    ## 2            7            0.621         12        0             1   
    ## 3            5            0.381          0        1             0.6 
    ## 4           10            0.281          0        0             0.9 
    ## 5            7            0.53          21        0             1   
    ## 6            8            0.329          0        1             0.8 
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
training data set. The majority of the number of shares are on the lower
end with some higher outliers. The `geom_histogram` function from the
`ggplot2` library was used to create the histogram.

``` r
g <- ggplot(weekdayDataTrain, aes(x = shares))
g + geom_histogram(bins = 100)
```

![](FridayAnalysis_files/figure-gfm/histogram-1.png)<!-- -->

## Bar Plot

The bar graph below shows the counts for the two groups of `shares`
using the training data set. The `geom_bar` function from the `ggplot2`
library was used to create the bar plot.

``` r
g <- ggplot(data = weekdayDataTrain, aes(x = shares_group))
g + geom_bar() + labs(x = "Shares Group", title = (paste0(capitalize(params$day)," Shares Groups")))
```

![](FridayAnalysis_files/figure-gfm/bar%20plot-1.png)<!-- -->

## Numerical Summary

This is a numerical summary of the counts of shares in the two groups
using the training data set. The `table` function was used to create the
frequency table.

``` r
table(weekdayDataTrain$shares_group)
```

    ## 
    ## above 1400 below 1400 
    ##       2188       1802

This is a summary of the `shares` variable in the training data set
which includes: minimum, 1st quartile, median, mean, 3rd quartile, and
maximum.

``` r
summary(weekdayDataTrain$shares)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##     22.0    984.2   1500.0   3309.2   2700.0 233400.0

The `TrainStatSum` function calculates a statistical summary for all the
variables of interest in the two `shares` groups.

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

The function is called for the `shares` above 1400.

``` r
TrainStatSum("above 1400")
```

|         | num\_keywords | avg\_positive\_polarity | num\_videos |  num\_imgs | max\_positive\_polarity | title\_subjectivity | rate\_negative\_words | n\_unique\_tokens | average\_token\_length | global\_rate\_positive\_words |
| ------- | ------------: | ----------------------: | ----------: | ---------: | ----------------------: | ------------------: | --------------------: | ----------------: | ---------------------: | ----------------------------: |
| Min.    |      1.000000 |               0.0000000 |     0.00000 |   0.000000 |               0.0000000 |           0.0000000 |             0.0000000 |         0.0000000 |               0.000000 |                     0.0000000 |
| 1st Qu. |      6.000000 |               0.3132597 |     0.00000 |   1.000000 |               0.6000000 |           0.0000000 |             0.1891892 |         0.4749274 |               4.465522 |                     0.0301290 |
| Median  |      7.000000 |               0.3605364 |     0.00000 |   1.000000 |               0.8000000 |           0.1250000 |             0.2758621 |         0.5458734 |               4.653505 |                     0.0401533 |
| Mean    |      7.271938 |               0.3588063 |     1.41819 |   4.821755 |               0.7656961 |           0.2865835 |             0.2828453 |         0.5358649 |               4.549521 |                     0.0407668 |
| 3rd Qu. |      9.000000 |               0.4134619 |     1.00000 |   6.000000 |               1.0000000 |           0.5000000 |             0.3750000 |         0.6166667 |               4.848241 |                     0.0512058 |
| Max.    |     10.000000 |               1.0000000 |    91.00000 | 108.000000 |               1.0000000 |           1.0000000 |             1.0000000 |         0.9473684 |               6.285985 |                     0.1369863 |

The function is called for the `shares` below 1400.

``` r
TrainStatSum("below 1400")
```

|         | num\_keywords | avg\_positive\_polarity | num\_videos |  num\_imgs | max\_positive\_polarity | title\_subjectivity | rate\_negative\_words | n\_unique\_tokens | average\_token\_length | global\_rate\_positive\_words |
| ------- | ------------: | ----------------------: | ----------: | ---------: | ----------------------: | ------------------: | --------------------: | ----------------: | ---------------------: | ----------------------------: |
| Min.    |      1.000000 |               0.0000000 |    0.000000 |   0.000000 |               0.0000000 |           0.0000000 |             0.0000000 |         0.0000000 |               0.000000 |                     0.0000000 |
| 1st Qu. |      6.000000 |               0.3000462 |    0.000000 |   1.000000 |               0.5000000 |           0.0000000 |             0.2046911 |         0.4771884 |               4.474566 |                     0.0251046 |
| Median  |      7.000000 |               0.3538025 |    0.000000 |   1.000000 |               0.8000000 |           0.1000000 |             0.3000000 |         0.5453835 |               4.677769 |                     0.0361555 |
| Mean    |      7.150943 |               0.3496097 |    1.188124 |   3.963929 |               0.7358707 |           0.2678713 |             0.3113334 |         0.5393832 |               4.562084 |                     0.0372842 |
| 3rd Qu. |      9.000000 |               0.4078002 |    1.000000 |   2.000000 |               1.0000000 |           0.5000000 |             0.4166667 |         0.6168224 |               4.879445 |                     0.0479642 |
| Max.    |     10.000000 |               0.8000000 |   74.000000 | 100.000000 |               1.0000000 |           1.0000000 |             1.0000000 |         0.9250000 |               6.431034 |                     0.1315789 |

# Modeling

This section will fit two types of models to predict the `shares`
variable.The first section discusses an ensemble model and the second
section discusses the selection of a linear regression model from a
collection of linear regression models. The training data set was used
to fit the two models and the test data set was used to make
predictions.

## Ensemble Model: Bagged Tree

The `caret` package was used to fit the bagged tree model. Repeated
cross validation was used in the `trainControl` function. This result
was fed into the `train` function with the method specified as `treebag`
for a bagged tree model to train the tree on the sample. The predictors
were centered and scaled in the `preProcess` argument. This method does
not have any tuning parameters. The best model fit is shown below.

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
    ## 3990 samples
    ##    4 predictor
    ##    2 classes: 'above 1400', 'below 1400' 
    ## 
    ## Pre-processing: centered (4), scaled (4) 
    ## Resampling: Cross-Validated (10 fold, repeated 3 times) 
    ## Summary of sample sizes: 3592, 3591, 3591, 3590, 3591, 3591, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.5209675  0.0249055

The best bagged tree model fit was used to predict the `shares` groups
using the test data set. The top of the bagged tree model prediction is
shown below.

``` r
bag_pred <- predict(bag_fit, newdata = weekdayDataTest)

head(bag_pred)
```

    ## [1] below 1400 above 1400 above 1400 above 1400 above 1400 above 1400
    ## Levels: above 1400 below 1400

A data frame of the prediction based on the test data set and the test
data set are shown below.

``` r
bag_fitInfo <- tbl_df(data.frame(bag_pred, weekdayDataTest$shares_group, weekdayDataTest$num_keywords, 
                                weekdayDataTest$avg_positive_polarity,
                                 weekdayDataTest$num_videos, weekdayDataTest$num_imgs))

bag_fitInfo
```

    ## # A tibble: 1,711 x 6
    ##    bag_pred weekdayDataTest~ weekdayDataTest~ weekdayDataTest~ weekdayDataTest~
    ##    <fct>    <fct>                       <dbl>            <dbl>            <dbl>
    ##  1 below 1~ above 1400                      7            0.621               12
    ##  2 above 1~ above 1400                      7            0.53                21
    ##  3 above 1~ below 1400                      8            0.329                0
    ##  4 above 1~ below 1400                     10            0.260                0
    ##  5 above 1~ below 1400                      9            0.430                0
    ##  6 above 1~ above 1400                      6            0.386                0
    ##  7 above 1~ above 1400                     10            0.492                0
    ##  8 above 1~ above 1400                     10            0.4                  1
    ##  9 above 1~ above 1400                      9            0.458                0
    ## 10 above 1~ above 1400                      8            0.481                0
    ## # ... with 1,701 more rows, and 1 more variable: weekdayDataTest.num_imgs <dbl>

A frequency table of the bagged tree prediction and the `shares_group`
column from the test data set are shown below. This table will be used
to calculate the misclassification rate. The `table` function was used
to create the frequency table.

``` r
bag_tbl <- table(bag_fitInfo$bag_pred, bag_fitInfo$weekdayDataTest.shares_group)

bag_tbl
```

    ##             
    ##              above 1400 below 1400
    ##   above 1400        566        452
    ##   below 1400        359        334

A confusion matrix is below to measure model accuracy for the test data.
The model is considered useful if the accuracy (1-misClass) is greater
than the no information rate.

``` r
confusionMatrix(bag_pred, weekdayDataTest$shares_group)
```

    ## Confusion Matrix and Statistics
    ## 
    ##             Reference
    ## Prediction   above 1400 below 1400
    ##   above 1400        566        452
    ##   below 1400        359        334
    ##                                          
    ##                Accuracy : 0.526          
    ##                  95% CI : (0.502, 0.5499)
    ##     No Information Rate : 0.5406         
    ##     P-Value [Acc > NIR] : 0.891905       
    ##                                          
    ##                   Kappa : 0.0372         
    ##                                          
    ##  Mcnemar's Test P-Value : 0.001235       
    ##                                          
    ##             Sensitivity : 0.6119         
    ##             Specificity : 0.4249         
    ##          Pos Pred Value : 0.5560         
    ##          Neg Pred Value : 0.4820         
    ##              Prevalence : 0.5406         
    ##          Detection Rate : 0.3308         
    ##    Detection Prevalence : 0.5950         
    ##       Balanced Accuracy : 0.5184         
    ##                                          
    ##        'Positive' Class : above 1400     
    ## 

The misclassification rate for the bagged tree model is shown below. A
lower misclassification rate demonstrates better accuracy in
predictions.

``` r
bag_misClass <- 1 - sum(diag(bag_tbl))/sum(bag_tbl)

bag_misClass
```

    ## [1] 0.4739918

## Select Linear Regression Model

This section will discuss methods for selecting a linear regression
model from a collection of linear regression models. Correlations of
numeric predictor variables with each other and with the response
variable `shares` were used to create the collection of variables.
Predictor variables with lower correlations with each other and the
`shares` variable were used because higher correlations may interfere
with model performance.

The figure below shows a correlation plot of the correlations between a
subset of predictor variables from the full data set that were in the
training data set. The `cor` function was used from the `corrplot`
library.

``` r
correlation <- cor(weekdayDataTrain %>% select(num_keywords, avg_positive_polarity, num_videos, num_imgs, 
           max_positive_polarity, title_subjectivity, rate_negative_words,
           n_unique_tokens, average_token_length, global_rate_positive_words, shares), method = "spearman")

corrplot(correlation, type = "upper", tl.pos = "lt")
corrplot(correlation, type = "lower", method = "number", add = TRUE, tl.pos = "n")
```

![](FridayAnalysis_files/figure-gfm/correlation-1.png)<!-- -->

Linear regression models can be formed based on the predictor variables
with lower correlations. In this example, two simple linear regression
models and three multiple linear regression models were selected based
on variables with lower correlations. The `lm` function was used to fit
the models with the training data set.

``` r
mlrFit1 <- lm(shares ~ num_keywords + num_imgs, data = weekdayDataTrain)

mlrFit2 <- lm(shares ~ num_keywords, 
              data = weekdayDataTrain)

mlrFit3 <- lm(shares ~ num_imgs + num_videos + global_rate_positive_words,
              data = weekdayDataTrain)

mlrFit4 <- lm(shares ~ n_unique_tokens + max_positive_polarity, data = weekdayDataTrain)

mlrFit5 <- lm(shares ~ global_rate_positive_words, weekdayDataTrain)
```

To select the best linear regression model, adjusted R square, AIC, and
BIC values for each model fit are used to determine which model predicts
the `shares` value the best.

``` r
library(MuMIn)

compareFitStats <- function(mlrFit1, mlrFit2, mlrFit3, mlrFit4, mlrFit5){
  fitStats <- data.frame(fitStat = c("Adj R Square", "AIC", "BIC"),
  Fit1 = c(round(summary(mlrFit1)$adj.r.squared, 5), AIC(mlrFit1),
                 BIC(mlrFit1)),
  Fit2 = c(round(summary(mlrFit2)$adj.r.squared, 5), AIC(mlrFit2),
                 BIC(mlrFit2)),
  Fit3 = c(round(summary(mlrFit3)$adj.r.squared, 5), AIC(mlrFit3),
                BIC(mlrFit3)),
  Fit4 = c(round(summary(mlrFit4)$adj.r.squared, 5), AIC(mlrFit4),
                BIC(mlrFit4)),
  Fit5 = c(round(summary(mlrFit5)$adj.r.squared, 5), AIC(mlrFit5),
                BIC(mlrFit5)))
  
  #put names in data frame
  calls <- as.list(match.call())
  calls[[1]] <- NULL
  names(fitStats[2:6]) <- unlist(calls)
  fitStats
}
```

The table below shows the adjusted R square, AIC, and BIC for each model
fit. Larger adjusted R square values and smaller AIC and BIC values are
better.

``` r
fitStats <- compareFitStats(mlrFit1, mlrFit2, mlrFit3, mlrFit4, mlrFit5)

fitStats
```

    ##        fitStat        Fit1        Fit2        Fit3        Fit4        Fit5
    ## 1 Adj R Square     0.00189     0.00056     0.00402     0.00066     0.00043
    ## 2          AIC 83484.27463 83488.56817 83476.74435 83489.17197 83489.09020
    ## 3          BIC 83509.44081 83507.44281 83508.20208 83514.33815 83507.96484

For this example the first linear regression model was selected to
demonstrate predicting with test data and calculating the root mean
square error (RMSE). RMSE for the testing data set is also used to
select the best model. The `predict` function was used to make a
prediction and the `RMSE` function was used to calculate the RMSE.

``` r
mlrFit1_predTest <- predict(mlrFit1, newdata = weekdayDataTest)

head(mlrFit1_predTest)
```

    ##        1        2        3        4        5        6 
    ## 3107.823 3107.823 3264.134 3497.352 4095.376 3030.915

``` r
RMSE(weekdayDataTest$shares, mlrFit1_predTest)
```

    ## [1] 7357.244
