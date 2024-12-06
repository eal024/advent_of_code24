
library(tidyverse)

# Function multiple two numbers
mul <- function(x,y) { x*y}

currupted_ex <- "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

uttrekk <- stringr::str_extract_all( currupted_ex, "mul\\(\\d+,\\d+\\)")

tbl <- tibble( 
    index = 1:length(uttrekk),
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
    group_by(index) |> 
    summarise(
        sum = sum(eval)
    )
