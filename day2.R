
library(tidyverse)

# Data
fil <- "data/day2.txt"
lines <- readLines(fil) 
list_of_lines <- lapply( lines, \(x) as.vector(x))


df0 <- tibble( index = 1:length(list_of_lines), report = list_of_lines) |> 
    mutate(
        report = map(report, \(x) str_split(x, " ") |> unlist() |> as.numeric() )
    )

# unnest the list into a long tibble
df <- df0 |> 
    unnest( report)  |> 
    rename( value = report)


# count freqvence, etc. 
df1 <- df |>
    group_by(index) |> 
    mutate(
        counter = 1:n(), 
        utv = (value-lag(value)),
        max = max( abs(utv), na.rm = T)
     )   |> 
     filter( counter > 1  )

# Create variable based on a condtion
df2 <- df1 |>
    mutate( keep = ifelse( 
            # condition
            ( all(utv > 0) | all(utv < 0)  ),
            1, # if yes 
            0  # if no
            ) 
        ) |> 
    ungroup()


# Which one to keep: Two condtion -- all > 0 or all < 0, and max increase is below 4
df3 <- df2 |>
    select( index, value, utv, max, keep ) |>  
    filter( keep == 1, max <= 3)  |>
    distinct(index)

# SOLTUOKN PART ONE
length(df3$index)

# Which index that is safe
safe <- unique(df3$index)

# Part two-------------------------------------------

# 
data0 <- df # |> mutate( index = 1:n()) |> pivot_longer(-index) |> select(-name)

# Keep the unsafe
data1 <- data0 |> filter(! index %in% unique(df3$index) )

# Creating variable that ID wrongs
data2 <- data1 |> 
    group_by(index) |> 
    mutate(
        counter = 1:n(), 
        utv = ifelse( is.na( (value-lag(value)) ), 0, (value-lag(value)) ),
        max = max( abs(utv), na.rm = T)
     ) 


# Condition for removing nr.1
# Changing signs
data3 <- data2 |> 
    # Må muligens slettes
    filter( counter > 1  ) |> 
    mutate( keep = ifelse( 
            # condition
            ( all(utv > 0) | all(utv < 0)  ),
            1, # if yes 
            0  # if no
            ) 
        ) |> 
    ungroup() |> 
    distinct( index, keep)

# Adding condtion 2
data4 <- data2 |> 
    left_join(
        data3, join_by(index)
    ) |> 
    # Adding condtion 2
    mutate(
        remove1 = ifelse( utv == max & max > 3, 1, 0), # remove first that causes max get above 
        remove1_cum = cumsum(remove1),
        remove1 =  ifelse( remove1 == 1 & remove1_cum == 1 , 1, 0)
    ) |> 
    select(-remove1_cum)



data5 <- data4 |>
    filter( keep == 0) |>
    filter( counter > 1) |>
    mutate( n_sign =  n_distinct( as.factor(sign(utv)))  ) |> 
    mutate( 
        remove2 = ifelse( sign(utv) != lag(sign(utv)), 1, 0 )
    ) |> 
    replace_na(list(remove2 = 0))  |> 
    mutate(
        remove2_cum = cumsum(remove2),
        remove2 =  ifelse( remove2 == 1 & remove2_cum == 1 , 1, 0)
    ) |> 
    distinct( index, counter, remove2 ) |> 
    ungroup()

data6 <- data4 |> 
    left_join(
        data5,
        join_by( index, counter)
    ) |> 
    replace_na( list(remove2 = 0))


# create count and report change: utv 
data7 <- data6 |>
    ungroup() |> 
    filter(
        remove1 != 1,
        remove2 != 1
    ) |> 
    group_by(index) |> 
    mutate(
        counter = 1:n(), 
        utv = (value-lag(value)),
        max = max( abs(utv), na.rm = T)
    ) |> 
    mutate( keep = ifelse( 
            # condition
            ( all(utv > 0, na.rm = T) | all(utv < 0, na.rm = T)  ),
            1, # if yes 
            0  # if no
            ) 
        ) |> 
    ungroup()

data7 |> filter( keep == 1, max <= 3)  |> View()


# Safe 
length( c(safe, safe2 ) |> unique() )
