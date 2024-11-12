# Load necessary libraries
library(dplyr)
library(here)

here::i_am(
  "code/01_data_preprocessing.R"
)


# Load the data
lung_data <- read.csv(here("data", "lung_cancer_data.csv"))

# Preprocess data and rename variables
lung_data_clean <- lung_data %>%
  rename(Gender = GENDER,
         Age = AGE,
         Smoking = SMOKING,
         Yellow_fingers = YELLOW_FINGERS,
         Anxiety = ANXIETY,
         Peer_pressure = PEER_PRESSURE,
         Chronic_disease = CHRONIC.DISEASE,
         Fatigue = FATIGUE,
         Allergy = ALLERGY,
         Alcohol_consuming = ALCOHOL.CONSUMING,
         Coughing = COUGHING,
         Shortness_of_breath = SHORTNESS.OF.BREATH,
         Swallowing_difficulty = SWALLOWING.DIFFICULTY,
         Chest_pain = CHEST.PAIN,
         Lung_Cancer = LUNG_CANCER) %>%
  
  # Recode binary variables
  mutate(across(c(Smoking, Yellow_fingers, Anxiety, Peer_pressure, Chronic_disease, Fatigue, Allergy, Alcohol_consuming, Coughing, Shortness_of_breath, Swallowing_difficulty, Chest_pain),
                ~ ifelse(. == 2, 1, 0)),
         Lung_Cancer = factor(Lung_Cancer, levels = c("NO", "YES"),
                              labels = c("No Lung Cancer", "Lung Cancer Present")))

# Save cleaned data
saveRDS(lung_data_clean, file = here("output", "lung_data_clean.rds"))
