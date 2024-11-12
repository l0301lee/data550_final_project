# Load libraries
library(ggplot2)
library(here)

here::i_am(
  "code/03_plot_age_distribution.R"
)


# Load preprocessed data
lung_data_clean <- readRDS(here("output", "lung_data_clean.rds"))

# Plot age distribution
age_plot <- ggplot(lung_data_clean, aes(x = Age, fill = Lung_Cancer)) +
  geom_histogram(binwidth = 5, position = "dodge") +
  labs(title = "Age Distribution by Lung Cancer Status",
       x = "Age",
       y = "Frequency") +
  theme_minimal()

# Save plot
ggsave(here("output", "age_distribution.png"), age_plot, width = 8, height = 5)
