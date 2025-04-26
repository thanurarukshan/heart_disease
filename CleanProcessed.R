
# Load necessary libraries
library(dplyr)      # Data manipulation
library(readr)      # To read CSV files
library(ggplot2)    # For visualizations
library(factoextra) # For clustering and visualization

# 1. Load the dataset
df <- read_csv("C:/Users/hp/Documents/RStudio Practicals/heart_disease.csv")

# 2. Inspect the dataset
# View first few rows
head(df)

# View the structure of the dataset (column types, missing values)
str(df)

# 3. Check for missing values
sum(is.na(df))      # Count total NA values in the dataset
sapply(df, function(x) sum(is.na(x)))  # Count NA values per column

# 4. Handle missing values
# Option 1: Remove rows with any missing values
df_clean <- df %>% filter(complete.cases(.))

# Option 2: Impute missing values (mean, median, mode, or other methods)
# Example: Replace NAs in numeric columns with the column mean
df_clean <- df %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

# 5. Remove constant variables (same value across all rows)
constant_vars <- sapply(df_clean, function(x) length(unique(x)) == 1)
df_clean <- df_clean[, !constant_vars]

# 6. Convert categorical columns to factors (if not already)
# Assuming "Heart Disease Status" is the target variable
df_clean$`Heart Disease Status` <- as.factor(df_clean$`Heart Disease Status`)

# 7. Convert other categorical variables to factors as necessary
# Example: If there's a categorical column called "Gender"
# df_clean$Gender <- as.factor(df_clean$Gender)

# 8. Check the data after preprocessing
summary(df_clean)

# 9. Scale numeric data (if necessary for certain models like K-means)
# Select numeric columns only
numeric_data <- df_clean[, sapply(df_clean, is.numeric)]

# Scale the numeric data (important for K-means, PCA, etc.)
numeric_data_scaled <- scale(numeric_data)

# 10. Optional: Visualize missing data (if any)
# You can visualize missing values in a heatmap if necessary
# library(ggplot2)
# ggplot(df_clean, aes(x = factor(1))) + geom_bar(aes(fill = `Heart Disease Status`)) + labs(title = "Distribution of Heart Disease Status")

# 11. Save cleaned data (optional)
write_csv(df_clean, "C:/Users/hp/Documents/RStudio Practicals/heart_disease_clean.csv")




