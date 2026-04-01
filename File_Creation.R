install.packages("haven")
library(haven)
albumin <- read_xpt("/Users/carolinemoy/stats571finalproject/Data/ALB_CR_L.xpt")
high_blood_pressure <- read_xpt("/Users/carolinemoy/stats571finalproject/Data/BPQ_L.xpt")
demographic <- read_xpt("/Users/carolinemoy/stats571finalproject/Data/DEMO_L.xpt")
insecticide <- read_xpt("/Users/carolinemoy/stats571finalproject/Data/PUQMEC_L.xpt")
ldl_chol <- read_xpt("/Users/carolinemoy/stats571finalproject/Data/TRIGLY_L.xpt")
total_chol <- read_xpt("/Users/carolinemoy/stats571finalproject/Data/TCHOL_L.xpt")


library(tidyverse)
library(dplyr)

complete_table <- demographic %>%
  inner_join(albumin, by = "SEQN") %>%
  inner_join(high_blood_pressure, by = "SEQN") %>%
  inner_join(insecticide, by = "SEQN") %>%
  inner_join(ldl_chol, by = "SEQN") %>%
  inner_join(total_chol, by = "SEQN")


write.csv(complete_table, file = "/Users/carolinemoy/stats571finalproj/Data/big_data.csv", row.names = FALSE)

total_chol_insecticide <- demographic %>%
  inner_join(total_chol, by = "SEQN") %>%
  inner_join(insecticide, by = "SEQN")

write.csv(total_chol_insecticide, file = "/Users/carolinemoy/stats571finalproj/Data/total_chol_insect.csv", row.names = FALSE)


clean_df <- read_csv("/Users/carolinemoy/stats571finalproj/Data/clean_df.csv")

clean_df

# Making the other outcome columns -- raw difference and mean sys and dia pressure
clean_df <- clean_df %>% 
  mutate(raw_difference = systolic_avg - diastolic_avg, 
         mean_bp = diastolic_avg + (1/3) * (systolic_avg - diastolic_avg))

write.csv(clean_df, file = "/Users/carolinemoy/stats571finalproj/Data/clean_df.csv", row.names = FALSE)

# Encoding all of clean_df and replacing
clean_df <- clean_df %>% 
  mutate(gender = ifelse(gender == "Female", 1, 0), # Female is 1, Male 0
         Mexican = ifelse(race_ethnicity_detailed == "Mexican American", 1, 0), 
         Asian = ifelse(race_ethnicity_detailed == "Non-Hispanic Asian", 1, 0),
         Black = ifelse(race_ethnicity_detailed == "Non-Hispanic Black", 1, 0), 
         White = ifelse(race_ethnicity_detailed == "Non-Hispanic White", 1, 0), 
         Hispanic = ifelse(race_ethnicity_detailed == "Other Hispanic", 1, 0), 
         Other = ifelse(race_ethnicity_detailed == "Other Race", 1, 0), 
         Less_9th_grade = ifelse(education_level == "<9th grade", 1, 0), 
         Some_High_School = ifelse(education_level == "9-11th grade", 1, 0), 
         High_School_Degree = ifelse(education_level == "High school/GED", 1, 0), 
         Some_College = ifelse(education_level == "Some college/AA", 1, 0), 
         College_Grad_or_More = ifelse(education_level == "College graduate or above", 1, 0), 
         Divorced = ifelse(marital_status == "Divorced", 1, 0), 
         Married = ifelse(marital_status == "Married", 1, 0), 
         Widowed = ifelse(marital_status == "Widowed", 1, 0)) 


write.csv(clean_df, file = "/Users/carolinemoy/stats571finalproj/Data/clean_df.csv", row.names = FALSE)
