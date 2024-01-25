
# Install and load required packages
install_and_load <- function(package_name) {
  if (!requireNamespace(package_name, quietly = TRUE)) {
    install.packages(package_name)
  }
  library(package_name, character.only = TRUE)
}

# Install and load necessary packages
# Set a CRAN mirror (choose a mirror appropriate for your location)
chooseCRANmirror(ind = 46)
install_and_load("dplyr")
install_and_load("ggplot2")
install_and_load("car")
install_and_load("xtable")


options(dplyr.print_max = Inf)
# Reset the print_max option to its default value
# options(dplyr.print_max = 20)  # You can adjust this value based on your preference

# Relevant paths
ASSIGNMENT_DATA_PATH = "../data/assignment"
ASSIGNMENT_OUTPUT_PATH = "../output/assignment"

# Check if the folder exists
if (!dir.exists(ASSIGNMENT_OUTPUT_PATH)) {
  # If it doesn't exist, create the folder
  dir.create(ASSIGNMENT_OUTPUT_PATH)
  cat("Assignments folder created successfully.\n")
} else {
  cat("Assignments folder already exists.\n")
}

# Save function
save_plot <- function(output_path, plot) {
  if (!file.exists(output_path)) {
    ggsave(output_path, plot = plot, width = 6, height = 4)
    cat(paste("\nPlot saved successfully:", output_path, "\n"))
  } else {
    if (overwrite) {
      ggsave(output_path, plot = plot, width = 6, height = 4)
      cat(paste("\nPlot saved successfully (overwritten):", output_path, "\n"))
    } else {
      cat(paste("\nFile already exists. Plot not saved to prevent overwriting:", output_path, "\n"))
    }
  }
}

# ggplot styling
plot_theme <- theme(
    plot.background = element_rect(fill = "gray"),  # Gray background outside the chart area
    panel.background = element_rect(fill = "white"),  # White background inside the chart area
    axis.line = element_line(color = "black", linewidth = 0.4),  # Solid axis lines
    panel.grid = element_blank(),  # Remove grid lines
    legend.position = "none",  # Remove the legend
    plot.title = element_text(hjust = 0.5)
  )
PLOT_FILL_COLOR <- "#71a9de"
  
# Overwrite flag for outputs
overwrite <- TRUE

# Specify the path to your CSV file
dental_data_file_path <- file.path(ASSIGNMENT_DATA_PATH, "Dental_2957161.csv")

# Load the data
dental_data <- read.csv(dental_data_file_path)

# Print the first few rows of the data frame
cat("First few rows of the data:\n")
head(dental_data)

# Check and clean NA values
cat("\nNumber of NA values in the data:", sum(is.na(dental_data)), "\n")
if (sum(is.na(dental_data)) > 0){
  dental_data <- na.omit(dental_data)
  cat("NA values removed.\n")
} else {
  cat("No NA values found.\n")
}

# Summary statistics for Sex
sex_prop_result <- dental_data %>%
  count(Sex) %>%
  mutate(proportion = 100 * n / sum(n))

cat("\nCounts and proportions of each sex calculated:\n")
print(sex_prop_result)

# Visualisation: Plot for Sex proportions
sex_barplot <- ggplot(sex_prop_result, aes(x = factor(Sex), y = n, fill = factor(Sex))) +
  geom_bar(stat = "identity", position = "dodge", fill = plot_fill_colour, color = "black", linewidth = 0.4, width=0.5) +
  labs(title = "Count of each sex", x = "Sex", y = "Count") +
  scale_x_discrete(labels = c("1" = "1 (= Male)", "2" = "2 (= Female)")) +  # Customize x-axis labels
  theme_minimal() +
  scale_y_continuous(expand = c(0, 0), limits = c(min(0, min(sex_prop_result$n)), max(sex_prop_result$n) + 5)) +
  plot_theme

# Save the plot
sex_plot_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "sex_barplot.png")
save_plot(sex_plot_output_path, sex_barplot)

# Summary statistics for DepCat
depcat_prop_result <- dental_data %>%
  count(DepCat) %>%
  mutate(proportion = 100 * n / sum(n))

cat("\nCounts and proportions of each deprivation category calculated:\n") 
print(depcat_prop_result)

# Visualisation: Plot for DepCat proportions
depcat_barplot <- ggplot(depcat_prop_result, aes(x = factor(DepCat), y = n, fill = factor(DepCat))) + # nolint
  geom_bar(stat = "identity", position = "dodge", fill = plot_fill_colour, color = "black", linewidth = 0.4, width=0.5) +
  labs(title = "Count of deprivation categories", x = "Deprivation Category (DepCat)", y = "Count") + 
  theme_minimal() +
  scale_y_continuous(expand = c(0, 0), limits = c(min(0, min(depcat_prop_result$n)), max(depcat_prop_result$n) + 5)) +
  plot_theme

# Save the plot 
depcat_plot_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "depcat_barplot.png")
save_plot(depcat_plot_output_path, depcat_barplot)

# Summary statistics for RegCat
regcat_prop_result <- dental_data %>%
  count(RegCat) %>%
  mutate(proportion = 100 * n / sum(n))

cat("\nCounts and proportions of each registration category calculated:\n")
print(regcat_prop_result)

# Visualisation: Plot for RegCat proportions
regcat_barplot <- ggplot(regcat_prop_result, aes(x = factor(RegCat), y = n, fill = factor(RegCat))) +
  geom_bar(stat = "identity", position = "dodge", fill = plot_fill_colour, color = "black", linewidth = 0.4, width=0.5) +
  labs(title = "Count of registration categories", x = "Registration Category (RegCat)", y = "Count") + 
  theme_minimal() +
  scale_y_continuous(expand = c(0, 0), limits = c(min(0, min(regcat_prop_result$n)), max(regcat_prop_result$n) + 5)) +
  plot_theme

# Save the plot
regcat_plot_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "regcat_barplot.png")
save_plot(regcat_plot_output_path, regcat_barplot)

# Summary statistics for DFMT (Decayed, Filled, Missing Teeth)
dfmt_summary <- dental_data %>%
  summarise(across(DFMT, 
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
cat("\nSummary statistics calculated for decayed, filled or missing teeth:\n")
print.data.frame(dfmt_summary)

# Visualisation: Value Plot for DFMT
dfmt_value_plot <- ggplot(dental_data, aes(x = "DFMT", y = DFMT)) +
  geom_point(position = position_jitter(width = 0.2), shape = 19, size = 3, alpha = 0.7, width = 0.2, color = plot_fill_colour) +
  stat_summary(fun.y = "mean", geom = "point", shape = 18, size = 4, color = "darkblue") +
  labs(title = "Individual Value Plot of DFMT", x = "", y = "Number of decayed, filled or missing teeth") +
  theme(axis.text.x = element_blank()) +  # To hide x-axis label since it's not meaningful in this context
  theme_minimal() + 
  plot_theme

# Save the plot
dfmt_value_plot_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "dfmt_value_plot.png")
save_plot(dfmt_value_plot_output_path, dfmt_value_plot)

# Visualisation: Box Plot for DFMT
dfmt_box_plot <- ggplot(dental_data, aes(x = "DFMT", y = DFMT)) +
  geom_boxplot(fill = plot_fill_colour, width = 0.2) +
  labs(title = "Boxplot of DFMT", x = "", y = "Number of decayed, filled or missing teeth") +
  theme(axis.text.x = element_blank()) +  # To hide x-axis label since it's not meaningful in this context
  theme_minimal() + 
  plot_theme

# Save the plot
dfmt_boxplot_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "dfmt_box_plot.png")
save_plot(dfmt_boxplot_output_path, dfmt_box_plot)

# Summary statistics for DFMT (Decayed, Filled, Missing Teeth) against DepCat
dfmt_by_depcat_summary <- dental_data %>%
  group_by(DepCat) %>%
  summarise(across(DFMT, 
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
cat("\nSummary statistics calculated for decayed, filled or missing teeth across each category of deprivation:\n")
print.data.frame(dfmt_by_depcat_summary)

# Visualisation: Value Plot for DFMT by DepCat
dfmt_value_plot_depcat <- ggplot(dental_data, aes(x = factor(DepCat), y = DFMT)) +
  geom_point(position = position_jitter(width = 0.2), shape = 19, size = 3, alpha = 0.7, width = 0.5, color = plot_fill_colour) +
  stat_summary(fun.y = "mean", geom = "point", shape = 18, size = 4, color = "darkblue") +
  labs(title = "Individual Value Plot of DFMT", x = "Deprivation Category (DepCat)", y = "Number of decayed, filled or missing teeth") +
  theme_minimal() + 
  plot_theme

# Save the plot
dfmt_value_plot_depcat_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "dfmt_value_plot_depcat.png")
save_plot(dfmt_value_plot_depcat_output_path, dfmt_value_plot_depcat)

# Visualisation: Box Plot for DFMT by DepCat
dfmt_box_plot_depcat <- ggplot(dental_data, aes(x = factor(DepCat), y = DFMT)) +
  geom_boxplot(fill = plot_fill_colour, width = 0.5) +
  labs(title = "Boxplot of DFMT", x = "Deprivation Category (DepCat)", y = "Number of decayed, filled or missing teeth") +
  theme_minimal() + 
  plot_theme

# Save the plot with checking for existing file
dfmt_boxplot_depcat_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "dfmt_box_plot_depcat.png")
save_plot(dfmt_boxplot_depcat_output_path, dfmt_box_plot_depcat)

# Further analysis: 2-sample t-test
# Create the binary variable "Poorest"
test_data <- dental_data %>%
  mutate(Poorest = if_else(DepCat == 7, "1", "0"))
cat("\nPoorest area flag created in data table\n")

# Summary statistics for DFMT (Decayed, Filled, Missing Teeth) against Poorest group
dfmt_by_poorest_summary <- test_data %>%
  group_by(Poorest) %>%
  summarise(across(DFMT, 
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
cat("\nSummary statistics calculated for decayed, filled or missing teeth across each category of poorest:\n")
print.data.frame(dfmt_by_poorest_summary)

# Visualisation: Value Plot for DFMT by DepCat
dfmt_value_plot_poorest <- ggplot(test_data, aes(x = factor(Poorest), y = DFMT)) +
  geom_point(position = position_jitter(width = 0.2), shape = 19, size = 3, alpha = 0.7, width = 0.5, color = plot_fill_colour) +
  stat_summary(fun.y = "mean", geom = "point", shape = 18, size = 4, color = "darkblue") +
  labs(title = "Individual Value Plot of DFMT", x = "Poorest Group", y = "Number of decayed, filled or missing teeth") +
  theme_minimal() + 
  plot_theme

# Save the plot
dfmt_value_plot_poorest_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "dfmt_value_plot_poorest.png")
save_plot(dfmt_value_plot_poorest_output_path, dfmt_value_plot_poorest)

# Visualisation: Value Plot for DFMT to test t-test assumptions
dfmt_box_plot_poorest <- ggplot(test_data, aes(x = factor(Poorest), y = DFMT)) +
  geom_boxplot(fill = plot_fill_colour, width=0.5) +
  labs(title = "Boxplot of DFMT", x = "Poorest Group", y = "Number of decayed, filled or missing teeth") +
  theme_minimal() +
  plot_theme
# Save the plot with checking for existing file
dfmt_boxplot_poorest_output_path <- file.path(ASSIGNMENT_OUTPUT_PATH, "dfmt_box_plot_poorest.png")
save_plot(dfmt_boxplot_poorest_output_path, dfmt_box_plot_poorest)

# Perform Levene's test of equal variances
levene_test <- leveneTest(DFMT ~ Poorest, data = test_data)
cat("\nNB: Levene Test not required if using Welch")
print(levene_test)


# Perform a 2-sample t-test
t_test_result <- t.test(DFMT ~ Poorest, data = test_data)
cat("\n2-sample t-test result:\n\n")
print(t_test_result)