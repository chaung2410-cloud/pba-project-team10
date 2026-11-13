
# Load packages
library(dplyr)
library(tidyr)
library(ggplot2)

# Load the cleaned dataset created by data_prep.R
data <- read.csv("youth_unemployment_subset.csv")

# Prepare data for treatment and comparison group trends
plot_data <- data %>%
  group_by(year, age_group, treatment) %>%
  summarise(
    avg_unemployment = mean(unemployment_rate, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    group = ifelse(
      treatment == 1,
      "Treatment group",
      "Comparison group"
    )
  )

# Figure 1: Youth unemployment trends by treatment group
ggplot(plot_data,
       aes(x = year, y = avg_unemployment,
           color = group, group = group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_vline(xintercept = 2020.5, linetype = "dashed") +
  facet_wrap(~ age_group) +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "Youth Unemployment Trends by Treatment Group",
    subtitle = "2018–2024",
    x = "Year",
    y = "Average unemployment rate (%)",
    color = "State group"
  ) +
  theme_minimal()

# Figure 2: Minimum wage trends by state
ggplot(data,
       aes(x = year, y = min_wage,
           color = state, group = state)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_vline(xintercept = 2020.5, linetype = "dashed") +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "Minimum Wage Trends Across Six States",
    subtitle = "2018–2024",
    x = "Year",
    y = "Minimum wage ($ per hour)",
    color = "State"
  ) +
  theme_minimal()

# Figure 3: Youth unemployment trends by state
ggplot(data,
       aes(x = year, y = unemployment_rate,
           color = state, group = state)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_vline(xintercept = 2020.5, linetype = "dashed") +
  facet_wrap(~ age_group) +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "Youth Unemployment Trends by State",
    subtitle = "2018–2024",
    x = "Year",
    y = "Unemployment rate (%)",
    color = "State"
  ) +
  theme_minimal()

# Figure 4: Treatment-control unemployment gap
gap_data <- plot_data %>%
  select(year, age_group, treatment, avg_unemployment) %>%
  pivot_wider(
    names_from = treatment,
    values_from = avg_unemployment,
    names_prefix = "group_"
  ) %>%
  mutate(gap = group_1 - group_0)

ggplot(gap_data, aes(x = year, y = gap)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  geom_vline(xintercept = 2020.5, linetype = "dashed") +
  facet_wrap(~ age_group) +
  scale_x_continuous(breaks = 2018:2024) +
  labs(
    title = "Youth Unemployment Gap Between State Groups",
    subtitle = "Treatment group minus comparison group",
    x = "Year",
    y = "Unemployment gap (percentage points)"
  ) +
  theme_minimal()
