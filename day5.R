

# 
library(tidyverse)

# Data
rules <- read.delim("data/day5_rules.txt",   header = F, sep = "|")

names(rules) <- c("before", "after")

infile <- "data/day5_input.txt"
input <- readLines(infile) |> as.list() |> map(\(x) str_split(x, ",")[[1]] |> as.numeric() )

# 1) Both as vector
# Rules
both <- map2(rules$V1, rules$V2, \(b,a){ c(b,a) } )

# Example
vec <- input[1]


