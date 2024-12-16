
library(tidyverse)

# Data
currupted <- read.delim("data/day3.txt",   header = F)

ll <- currupted |> as.list() 

# Function multiple two numbers
mul <- function(x,y) { x*y}

# currupted_ex <- "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

uttrekk <- stringr::str_extract_all( ll, "mul\\(\\d+,\\d+\\)")

tbl <- tibble( 
    data = uttrekk
    ) |> 
    unnest(data)


# Evaluere
tbl1 <-  tbl |> 
    mutate(
        eval = map(data, \(x) eval(parse(text = x)))
    ) |> 
    unnest( eval) 


tbl1 |> 
    summarise(
        sum = sum(eval)
    )


## Part two 
# Some are enable with do, and some with don`t
# currupted_ex <- "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

regx_pattern <- "mul\\(\\d+,\\d+\\)|don\\'t\\(\\)|do\\(\\)"


uttrekk <- stringr::str_extract_all( ll, regx_pattern)

tbl2 <- tibble( line = uttrekk  ) |> 
    unnest( line ) |> 
    mutate(
        teller = 1:n()
    )



tbl3 <- tbl2 |> 
    mutate(  
        kun = ifelse( str_detect( line, "do"), line, NA_character_)
        ) |>  
    fill( kun, .direction = "down") |>
    mutate( 
        kun = ifelse(is.na(kun), "do()", kun)
    ) |> 
    filter( kun == "do()", line != "do()")     


tbl14 <- tbl3 |> 
    mutate(
        eval = map(line, \(x) eval(parse(text = x)))
    ) |> 
    unnest( eval)  


tbl14 |> summarise( sum(eval))
