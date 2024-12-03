# packages
library(tidyverse)

data <- 

# data
data <- tribble(
  ~start, ~stop,
  3, 4,
  4, 3,
  2, 5,
  1, 3,
  3, 9,
  3, 3
)



#
stop_count <- data |>
    group_by(stop) |> 
    summarise(
        count = n()
    )

# How often each in start, appear/is counted in stop
start_match_counter <- select( data, start) |> 
    left_join(
        stop_count, join_by(start == stop)
    ) |> 
    replace_na(list(count = 0 )) |> 
    mutate(
        score_increase = count*start
    )


# Summing up
start_match_counter |> 
    summarise(
        sum = sum(score_increase)
    )
