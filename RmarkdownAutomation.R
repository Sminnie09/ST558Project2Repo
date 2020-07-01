library(rmarkdown)
library(tidyverse)

#days of the week
days <- c("weekday_is_monday", "weekday_is_tuesday", "weekday_is_wednesday",
           "weekday_is_thursday", "weekday_is_friday", "weekday_is_saturday",
           "weekday_is_sunday")

#create file names
output_file <- paste0(days, ".md")

#create a list for each day of the week with the day as parameter
params <- lapply(days, FUN = function(x){list(day = x)})

#put into data frame
#reports <- tibble(days, filename = output_file, params = purrr::map(days, ~list(day = .)))
reports <- tibble(filename = output_file, params)

apply(reports, MARGIN = 1, FUN = function(x){
  render("README.Rmd", 
         output_file = x[[1]], params = x[[2]])
})
