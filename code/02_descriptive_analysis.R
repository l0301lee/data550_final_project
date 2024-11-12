# Load libraries
library(dplyr)
library(tableone)
library(knitr)
library(kableExtra)
library(here)

here::i_am(
  "code/02_descriptive_analysis.R"
)

# Load preprocessed data
lung_data_clean <- readRDS(here("output", "lung_data_clean.rds"))

# Define variable groups for Table 1
demographics <- c("Gender", "Age")
lifestyle_factors <- c("Smoking", "Alcohol_consuming", "Peer_pressure")
health_factors <- c("Yellow_fingers", "Anxiety", "Chronic_disease", "Fatigue", 
                    "Allergy", "Coughing", "Shortness_of_breath", 
                    "Swallowing_difficulty", "Chest_pain")

# Combine all groups into one variable list
all_vars <- c(demographics, lifestyle_factors, health_factors)
categorical_vars <- c("Gender", "Smoking", "Yellow_fingers", "Anxiety", "Peer_pressure",
                      "Chronic_disease", "Fatigue", "Allergy", "Alcohol_consuming", 
                      "Coughing", "Shortness_of_breath", "Swallowing_difficulty", "Chest_pain")

# Create Table 1 as a TableOne object
table1 <- CreateTableOne(vars = all_vars, strata = "Lung_Cancer", 
                         data = lung_data_clean, factorVars = categorical_vars)

# Convert TableOne object to a printable data frame
table1_df <- as.data.frame(print(table1, printToggle = FALSE))

# Check the number of columns in table1_df
num_columns <- ncol(table1_df)

# Save Table 1 as HTML
table1_html <- kable(table1_df, caption = "Summary of Patient Characteristics by Lung Cancer Status") %>%
  kable_styling(full_width = FALSE, bootstrap_options = c("striped", "hover", "condensed"))

# Add header based on the number of columns
if (num_columns == 5) {
  table1_html <- table1_html %>%
    add_header_above(c(" " = 1, "Lung Cancer Status" = 2, " " = 2)) %>%
    column_spec(1, bold = TRUE)
}

# Save the formatted table to HTML
save_kable(table1_html, file = here("output", "table1.html"))