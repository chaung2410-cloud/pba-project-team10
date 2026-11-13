
# Codebook: Youth Unemployment and Minimum Wage

## Dataset description
This dataset contains information on youth unemployment rates and minimum wages across six US states from 2018 to 2024.

## Variables

| Variable | Description |
|---|---|
| state | Name of the US state |
| year | Year of observation |
| age_group | Age category of the youth population |
| unemployment_rate | Youth unemployment rate (%) |
| min_wage | State minimum wage ($ per hour) |
| treatment | 1 = California, New York, Washington; 0 = comparison states |
| post | 1 = 2021 onwards; 0 = before 2021 |
| did | Interaction between treatment and post |

## Treatment definition
The treatment group consists of California, New York, and Washington. The remaining states form the comparison group.

## Time period
2018–2024.

## Data preparation
The data preparation script converts variables to their appropriate types and creates the treatment, post, and DiD variables.
