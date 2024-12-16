

# Definerer listen
listen <- list(
  en = c("A", "B", "C"),
  to = c("D", "E", "F"),
  tre = c("G", "H", "I")
)

n <- 3

el <- seq(1:n)


df <- tibble( en = c(1:3, NA_real_), to = c(NA_real_, 1:3)) |> 
    mutate(
        en = paste( "c(", en,",",1,")"),
        to = paste( "c(", to,",",2,")")
    )



df$en[1][[1]] |> eval()
resultater <- sapply(l, function(coord) listen[[coord[1]]][coord[2]])