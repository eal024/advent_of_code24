

# 
library(tidyverse)

# Data
# rules <- read.delim("data/day5_rules.txt",   header = F, sep = "|")
rules <- read.delim("data/day5_rules_compl.txt",   header = F, sep = "|")
names(rules) <- c("before", "after")

# input
# infile <- "data/day5_input.txt"
infile <- "data/day5_input_compl.txt"
input <- readLines(infile) |> as.list() |> map(\(x) str_split(x, ",")[[1]] |> as.numeric() )

# 1) convert rules to a list of vectors
both <- map2(rules$before, rules$after, \(b,a){ c(b,a) |> as.numeric() } )


# Function for testing each line 
test_of_line <- function(vec_x){

    # Store number before
    l_before_x <- map( seq_along(vec_x), \(x) vec_x[0:(x-1)] )

    # Organizing the data
    df_x <- tibble( num = vec_x, before = l_before_x )


    # Conecting number with rules
    list_rules_x <- list()
    for( i in 1:length(vec_x) ){
        
        # The number 
        number <- vec_x[i]
        list_rules_x[[i]] <- both[ map_lgl(both, \(x)  x[[2]] == number & x[[1]] %in% vec_x)]
    }

    #
    list_rules_x

    # Organzing the rules 
    df_x$must_be_before <- map( list_rules_x, \(l) map_dbl(l, \(x) x[1]))


    df_x |> 
        mutate(
            is_all_condtion_ok = map2( must_be_before, before, \(num_before, test) all( test %in% num_before) == TRUE)  
        ) |> 
        unnest( cols = is_all_condtion_ok)
            
    }

# Test all inputs 
test_of_all <- map( input, \(x) test_of_line(x))

names(test_of_all) <-  1:length(test_of_all) 

# This inputs are ok
keep <- input[map_lgl(test_of_all, \(x) all(x$is_all_condtion_ok) == TRUE)]


# Fine the mimidlmiddle page numers 
map_dbl(keep, \(x) x[ceiling(length(x)/2)] ) |> sum()


# Part two------------------------

# 1) Keeping only the parts with the wrong order
# Indexing the wrong parts
wrong_parts <- map_lgl(test_of_all, \(x) all(x$is_all_condtion_ok) == FALSE)

# 2) Using the test_of_line -- genereated info
wrong_part_check_list <- test_of_all[wrong_parts]

# Reordering the df -- simple fixing 
fun_re_order_df <- function(df){
    df |>
        mutate(
        index = map_dbl(must_be_before, \(x) length(x)) ) |> 
    arrange( index) 
}

#
ls_reorder <- map( wrong_part_check_list, \(df) fun_re_order_df( df) )

# 3) Re check
ls_reorder <- map( ls_reorder, \(x) test_of_line(  vec_x = x$num) )


# 4) Get the midle numer
dbl_keep_the_reorder <- map_dbl(ls_reorder, \(x) x$num[ceiling(length(x$num)/2)] )

sum(dbl_keep_the_reorder)