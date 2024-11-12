# Load necessary libraries
library(dplyr)
library(broom)
library(knitr)
library(kableExtra)
library(here)

here::i_am(
  "code/04_predictive_modeling.R"
)
# Load preprocessed data
lung_data_clean <- readRDS(here("output", "lung_data_clean.rds"))

# Logistic regression model
lung_model <- glm(Lung_Cancer ~ Age + Smoking + Chest_pain + Shortness_of_breath, 
                  data = lung_data_clean, family = "binomial")

# Tidy the model summary
model_summary <- tidy(lung_model) %>%
  mutate(OR = exp(estimate),
         CI_lower = exp(estimate - 1.96 * std.error),
         CI_upper = exp(estimate + 1.96 * std.error)) %>%
  mutate(across(c(estimate, std.error, OR, CI_lower, CI_upper, p.value), \(x) round(x, 2)))

# Generate the HTML table
model_summary_html <- kable(model_summary[, c("term", "estimate", "std.error", "OR", "CI_lower", "CI_upper", "p.value")],
                            col.names = c("Variable", "Estimate", "Std. Error", "Odds Ratio", "95% CI Lower", "95% CI Upper", "P-value"),
                            caption = "Logistic Regression Results for Lung Cancer Prediction") %>%
  kable_styling("striped", full_width = FALSE)

# Save as HTML file
writeLines(model_summary_html, here("output", "model_summary.html"))