# Install and load the dplyr package if not already installed
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

if (!requireNamespace("tidyr", quietly = TRUE)) {
  install.packages("tidyr")
}
# Load the readxl package
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

# Relevant path
WB1_DATA_PATH = "../data/wb1SummarisingPresentingData"
WB1_OUTPUT_PATH = "../output/wb1SummarisingPresentingData"

# Specify the path to your Excel file
alert_rct_file_path <- file.path(WB1_DATA_PATH, "alert_rct.xlsx")
ischaemic_damage_file_path <- file.path(WB1_DATA_PATH, "ischaemic_damage.xlsx")
pregnancy_file_path <- file.path(WB1_DATA_PATH, "pregnancy_longitudinal.xlsx")

# Read the Excel file into a data frame
alert_rct_data <- read_excel(alert_rct_file_path)

# Display more decimal places
options(digits=4)

# Print the first few rows of the data frame
# head(alert_rct_data)
# colnames(alert_rct_data)

# a) Quant and qual variables
# Quant: age, dbp, sbp, bmi, ldl_b, ldl_6, cho_b, cho_6, hdl_b, hdl_6, tri_b, tri_6
# Qual: randgrp, sex, csmoker

# Descriptive Statistics
# age, sex, tri_b for 2 groups
# N, N*, Mean, SE Mean, StDev, Min, Q1, Median, Q3, Max
# Grouped summary statistics using dplyr

# Use filter() to remove rows with NA values
sprintf("Number of NA values: %s", sum(is.na(alert_rct_data)))

# Remve NA values in age and triglyceride columns
filtered_data <- alert_rct_data %>%
  filter(!is.na(age) & !is.na(tri_b))

# Summary statistics
# Assuming your dataset is named alert_rct_data
age_summary <- alert_rct_data %>%
  group_by(randgrp) %>%
  summarise(across(age, 
                   .fns = list(
                     N = ~sum(!is.na(.)),          # Sample size
                     N_total = ~sum(!is.na(.)),     # Total non-missing values
                     Mean = ~mean(., na.rm = TRUE), # Mean
                     SE_Mean = ~sd(., na.rm = TRUE) / sqrt(sum(!is.na(.))),  # Standard Error of the Mean
                     StDev = ~sd(., na.rm = TRUE),  # Standard Deviation
                     Min = ~min(., na.rm = TRUE),   # Minimum
                     Q1 = ~quantile(., 0.25, na.rm = TRUE),  # First Quartile
                     Median = ~median(., na.rm = TRUE),      # Median
                     Q3 = ~quantile(., 0.75, na.rm = TRUE),  # Third Quartile
                     Max = ~max(., na.rm = TRUE)    # Maximum
                   ), 
                   .names = "{.col}_{.fn}")) 

tri_b_summary <- alert_rct_data %>%
  group_by(randgrp) %>%
  summarise(across(tri_b, 
                   .fns = list(
                     N = ~sum(!is.na(.)),          # Sample size
                     N_total = ~sum(!is.na(.)),     # Total non-missing values
                     Mean = ~mean(., na.rm = TRUE), # Mean
                     SE_Mean = ~sd(., na.rm = TRUE) / sqrt(sum(!is.na(.))),  # Standard Error of the Mean
                     StDev = ~sd(., na.rm = TRUE),  # Standard Deviation
                     Min = ~min(., na.rm = TRUE),   # Minimum
                     Q1 = ~quantile(., 0.25, na.rm = TRUE),  # First Quartile
                     Median = ~median(., na.rm = TRUE),      # Median
                     Q3 = ~quantile(., 0.75, na.rm = TRUE),  # Third Quartile
                     Max = ~max(., na.rm = TRUE)    # Maximum
                   ), 
                   .names = "{.col}_{.fn}")) 
    #                %>%
    # pivot_longer(everything(), names_sep='_', names_to=c('variable', '.value'))

# print(grouped_summary)

# Separate tables for each variable

# Print the tables
print(age_summary)
print(tri_b_summary)

# Use dplyr to calculate proportions for randgrp by sex
proportions_result <- alert_rct_data %>%
  count(randgrp, sex) %>%
  group_by(randgrp) %>%
  mutate(proportion = 100 * n / sum(n))

# Create box plots for age and baseline triglyceride and save to output
age_boxplot <- ggplot(alert_rct_data, aes(x = as.factor(randgrp), y = age)) +
  geom_boxplot(fill = "#57A0D3") +
  labs(title = "Box Plot of Age by randgrp",
       x = "randgrp",
       y = "age")
ggsave(file.path(WB1_OUTPUT_PATH, "age_boxplot.png"), plot = age_boxplot, width = 6, height = 4) # nolint

tri_b_boxplot <- ggplot(alert_rct_data, aes(x = as.factor(randgrp), y = tri_b)) +
  geom_boxplot(fill = "#57A0D3") +
  labs(title = "Box Plot of tri_b by randgrp",
       x = "randgrp",
       y = "tri_b")
ggsave(file.path(WB1_OUTPUT_PATH, "tri_b_boxplot.png"), plot = tri_b_boxplot, width = 6, height = 4)

# Create a bar chart using proportions_result
# sex_count_bar_chart <- ggplot(proportions_result, aes(x = as.factor(randgrp), y = count, fill = as.factor(sex))) +
#   geom_bar(stat = "identity", position = "dodge") +
#   labs(title = "Bar Chart of Proportions by Sex and randgrp",
#        x = "randgrp",
#        y = "Proportion (%)",
#        fill = "Sex")

# ggsave(file.path(WB1_OUTPUT_PATH, "sex_count_bar_chart.png"), plot = sex_count_bar_chart, width = 6, height = 4)

# # Create a bar chart using proportions_result
# sex_proportion_bar_chart <- ggplot(proportions_result, aes(x = as.factor(randgrp), y = proportion, fill = as.factor(sex))) +
#   geom_bar(stat = "identity", position = "dodge") +
#   labs(title = "Bar Chart of Proportions by Sex and randgrp",
#        x = "randgrp",
#        y = "Proportion (%)",
#        fill = "Sex")

# ggsave(file.path(WB1_OUTPUT_PATH, "sex_proportion_bar_chart.png"), plot = sex_proportion_bar_chart, width = 6, height = 4)


# Assuming your dataset is named alert_rct_data
missing_summary <- sapply(alert_rct_data, function(x) 100 * sum(is.na(x))/length(x))

# Create a data frame for better presentation
missing_df <- data.frame(Variable = names(missing_summary), Missing_Count = missing_summary)

# Print the data frame
print(missing_df)
# Use dplyr to calculate percentage difference - mutate creates new column based on percentage difference

alert_rct_data <- alert_rct_data %>%
  mutate(ldl_diff = ((ldl_6 - ldl_b) / ldl_b) * 100)

# head(percentage_difference_result[, ldl_diff])

ldl_percentage_change <- alert_rct_data %>%
    group_by(randgrp) %>%
    summarise(
        mean(ldl_diff, na.rm = TRUE)
    )

print(ldl_percentage_change)

ldl_diff_summary <- alert_rct_data %>%
  group_by(randgrp) %>%
  summarise(across(ldl_diff, 
                   .fns = list(
                     N = ~sum(!is.na(.)),          # Sample size
                     N_total = ~sum(!is.na(.)),     # Total non-missing values
                     Mean = ~mean(., na.rm = TRUE), # Mean
                     SE_Mean = ~sd(., na.rm = TRUE) / sqrt(sum(!is.na(.))),  # Standard Error of the Mean
                     StDev = ~sd(., na.rm = TRUE),  # Standard Deviation
                     Min = ~min(., na.rm = TRUE),   # Minimum
                     Q1 = ~quantile(., 0.25, na.rm = TRUE),  # First Quartile
                     Median = ~median(., na.rm = TRUE),      # Median
                     Q3 = ~quantile(., 0.75, na.rm = TRUE),  # Third Quartile
                     Max = ~max(., na.rm = TRUE)    # Maximum
                   ), 
                   .names = "{.col}_{.fn}")) 
    #                %>%
options(width=300)
print(ldl_diff_summary)

ischaemic_damage_data <- read_excel(ischaemic_damage_file_path)
filtered_ischaemic_data <- ischaemic_damage_data %>% filter(level == 8)


back_brain_summary <- filtered_ischaemic_data %>%
  group_by(strain) %>%
  summarise(across(area, 
                   .fns = list(
                     N = ~sum(!is.na(.)),          # Sample size
                     N_total = ~sum(!is.na(.)),     # Total non-missing values
                     Mean = ~mean(., na.rm = TRUE), # Mean
                     SE_Mean = ~sd(., na.rm = TRUE) / sqrt(sum(!is.na(.))),  # Standard Error of the Mean
                     StDev = ~sd(., na.rm = TRUE),  # Standard Deviation
                     Min = ~min(., na.rm = TRUE),   # Minimum
                     Q1 = ~quantile(., 0.25, na.rm = TRUE),  # First Quartile
                     Median = ~median(., na.rm = TRUE),      # Median
                     Q3 = ~quantile(., 0.75, na.rm = TRUE),  # Third Quartile
                     Max = ~max(., na.rm = TRUE)    # Maximum
                   ), 
                   .names = "{.col}_{.fn}")) 

print(back_brain_summary)

ischaemic_damage_boxplot <- ggplot(filtered_ischaemic_data, aes(x = as.factor(strain), y = area)) +
  geom_boxplot(fill = "#57A0D3") +
  labs(title = "Box Plot of area by rodent strain",
       x = "strain",
       y = "area")
ggsave(file.path(WB1_OUTPUT_PATH, "area_boxplot.png"), plot = ischaemic_damage_boxplot, width = 6, height = 4)


ischaemic_damage_cluster_boxplot <- ggplot(ischaemic_damage_data, aes(x = as.factor(strain), y = area)) +
  geom_boxplot(fill = "#57A0D3") +
  facet_grid(. ~ level)
  labs(title = "Box Plot of area by rodent strain",
       x = "strain",
       y = "area")
ggsave(file.path(WB1_OUTPUT_PATH, "ischaemic_damage_cluster_boxplot.png"), plot = ischaemic_damage_cluster_boxplot, width = 6, height = 4)

brain_damage_summary <- ischaemic_damage_data %>%
  group_by(strain, level) %>%
  summarise(across(area, 
                   .fns = list(
                     N = ~sum(!is.na(.)),          # Sample size
                     N_total = ~sum(!is.na(.)),     # Total non-missing values
                     Mean = ~mean(., na.rm = TRUE), # Mean
                     SE_Mean = ~sd(., na.rm = TRUE) / sqrt(sum(!is.na(.))),  # Standard Error of the Mean
                     StDev = ~sd(., na.rm = TRUE),  # Standard Deviation
                     Min = ~min(., na.rm = TRUE),   # Minimum
                     Q1 = ~quantile(., 0.25, na.rm = TRUE),  # First Quartile
                     Median = ~median(., na.rm = TRUE),      # Median
                     Q3 = ~quantile(., 0.75, na.rm = TRUE),  # Third Quartile
                     Max = ~max(., na.rm = TRUE)    # Maximum
                   ), 
                   .names = "{.col}_{.fn}")) 

mean_damage_clusterplot <- ggplot(brain_damage_summary, aes(x = as.factor(strain), y = area_Mean)) +
  geom_point(position = position_dodge(width = 0.8), size = 3) +
  facet_grid(. ~ level) +
  geom_errorbar(
    aes(ymin = area_Mean - area_StDev, ymax = area_Mean + area_StDev),
    position = position_dodge(width = 0.8),
    width = 0.2
  ) +
  labs(title = "Clustered Plot of Mean and Standard Deviation of Ischaemic Damage",
       x = "Section",
       y = "Mean Area")
  # theme_minimal()

  ggsave(file.path(WB1_OUTPUT_PATH, "ischaemic_damage_cluster_boxplot_mean_stdev.png"), plot = mean_damage_clusterplot, width = 6, height = 4)


print(head(ischaemic_damage_data %>% filter(level == 1)))

volume_plot <- ggplot(ischaemic_damage_data %>% filter(level == 1), aes(x = strain, y = volume)) +
  geom_point() +
  labs(title = "Scatter Plot of Volume Against Strain",
       x = "Strain",
       y = "Volume")
  ggsave(file.path(WB1_OUTPUT_PATH, "ischaemic_damage_scatter_plot_level1.png"), plot = volume_plot, width = 6, height = 4)


pregnancy_data <- read_excel(pregnancy_file_path)
head(pregnancy_data)

pregnancy_data <- pregnancy_data %>%
  mutate(obese = ifelse(bmi < 30, 0, 1))

head(pregnancy_data)
bmi_true <- pregnancy_data %>%
  filter(time == 1) %>%
  summarise(count_obese = sum(obese == 1),
  percentage_obese = mean(obese)*100)
print(bmi_true)

leptin_scatter_plot <- ggplot(pregnancy_data %>% filter(time != 5), aes(x = gest, y = leptin, color = factor(obese))) +
  geom_point() +
  labs(title = "Scatter Plot of Leptin concentration Against gestational age",
       x = "Gest Age",
       y = "Leptin")
ggsave(file.path(WB1_OUTPUT_PATH, "leptin_scatter_plot.png"), plot = leptin_scatter_plot, width = 6, height = 4)

leptin_trimester_clusterplot <- ggplot(pregnancy_data %>% filter(time != 5), aes(x = as.factor(time), y = leptin, fill=factor(obese))) +
 geom_boxplot(position = position_dodge(width = 0.8)) +
#  facet_grid(obese ~ ., scales = "free_y", space = "free_y") +
  labs(title = "Box plot of Leptin concentration Against trimester",
       x = "Trimester",
       y = "Leptin")
ggsave(file.path(WB1_OUTPUT_PATH, "leptin_trimester_clusterplot.png"), plot = leptin_trimester_clusterplot, width = 6, height = 4)
