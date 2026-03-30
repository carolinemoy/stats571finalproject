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
