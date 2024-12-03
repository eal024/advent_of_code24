
library(tidyverse)

# Import data
vroom::vroom("data/day1.txt", col_names = FALSE)

data <- read.delim("data/day1.txt", header = F) |> as_tibble() |> set_names( c("start", "stop"))

# Data wrangling
data2 <- separate(data, col = "V1", into = c("start", "stop"),   sep = "  ") |> 
    mutate( 
        start = str_trim(start, "both") |> as.numeric(),
        stop  = str_trim(stop, "both") |> as.numeric()
     )

# Arrange start from 1 to nrow() 
data3 <- data2 |>
    arrange( start) |> 
    mutate(
        index_start = 1:n() 
    ) |> 
    arrange( stop) |> 
    mutate(
        index_stop = 1:n()
    )

# Match start and stop columns, based on arrange 
data4 <- data3 |> 
    select(start, index = index_start) |> 
    left_join(
        data3 |> select( stop, index = index_stop),
        join_by(index)
    )


# Calcualte distance
data4 |> 
    mutate( dist = abs(start - stop) ) |> 
    summarise( sum(dist))



# Part one: The first solution -> gives one star :)
stop_count <- data |>
    group_by(stop) |> 
    summarise(
        count = n()
    )

## Part two:
# How often each in start, appear/is counted in stop
start_match_counter <- select( data, start) |> w
    left_join(
        stop_count, join_by(start == stop)
    ) |> 
    replace_na(list(count = 0 )) |> 
    mutate(
        score_increase = count*start
    )


# Summing up: star two!
start_match_counter |> 
    summarise(
        sum = sum(score_increase)
    )
