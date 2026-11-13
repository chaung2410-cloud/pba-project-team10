
library(readxl)
library(dplyr)

# Import the original dataset
data <- read_excel("/Users/octaannachellejovanah/PBA project/pba-project-team10/Youth-unemployment PBA project.xlsx")

# Clean the data
data <- data %>%
  mutate(
    year = as.integer(year),
    unemployment_rate = as.numeric(unemployment_rate),
    min_wage = as.numeric(min_wage),
    treatment = ifelse(
      state %in% c("California", "New York", "Washington"), 1, 0
    ),
    post = ifelse(year >= 2021, 1, 0),
    did = treatment * post
  )

# Save the cleaned dataset
write.csv(
  data,
  "youth_unemployment_subset.csv",
  row.names = FALSE
)
