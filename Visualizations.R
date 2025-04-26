# Hi

# working folder: C:\Users\thanu\Desktop\Applied_Stat_Assignment
# dataset path: C:\Users\thanu\Desktop\Applied_Stat_Assignment\heart_disease.csv


# Load required libraries
library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)
library(patchwork)  # Optional for combining plots

# Load the dataset
df <- read_csv("heart_disease.csv")

# Check structure
glimpse(df)

# -------------------------------
# Numeric Variables: Histograms & Box Plots
# -------------------------------

# Histogram + Boxplot for Age
p1 <- ggplot(df, aes(x = Age)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  ggtitle("Histogram of Age")

p2 <- ggplot(df, aes(y = Age)) +
  geom_boxplot(fill = "lightgreen") +
  ggtitle("Boxplot of Age")






# Histogram + Boxplot for Blood Pressure
p3 <- ggplot(df, aes(x = `Blood Pressure`)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  ggtitle("Histogram of Blood Pressure")

p4 <- ggplot(df, aes(y = `Blood Pressure`)) +
  geom_boxplot(fill = "lightgreen") +
  ggtitle("Boxplot of Blood Pressure")



# Histogram + Boxplot for Cholesterol Level
p5 <- ggplot(df, aes(x = `Cholesterol Level`)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  ggtitle("Histogram of Cholesterol Level")

p6 <- ggplot(df, aes(y = `Cholesterol Level`)) +
  geom_boxplot(fill = "lightgreen") +
  ggtitle("Boxplot of Cholesterol Level")



# Combine all numeric plots
(p1 | p2) / (p3 | p4) / (p5 | p6)

# -------------------------------
# Categorical Variables: Bar Plots
# -------------------------------

# Smoking
ggplot(df, aes(x = Smoking)) +
  geom_bar(fill = "orange") +
  ggtitle("Bar Plot of Smoking Status")

# Diabetes
ggplot(df, aes(x = Diabetes)) +
  geom_bar(fill = "tomato") +
  ggtitle("Bar Plot of Diabetes Status")

# You can add more categorical variables similarly:
# "Gender", "Exercise Habits", "Family Heart Disease", etc.

# Heart Disease Status
ggplot(df, aes(x = `Heart Disease Status`)) +
  geom_bar(fill = "steelblue") +
  ggtitle("Bar Plot of Heart Disease Status")

# Bar Plot for Exercise Habits
ggplot(df, aes(x = `Exercise Habits`)) +
  geom_bar(fill = "darkseagreen3") +
  ggtitle("Bar Plot of Exercise Habits") +
  theme_minimal()

# Bar Plot for Family Heart Disease
ggplot(df, aes(x = `Family Heart Disease`)) +
  geom_bar(fill = "coral") +
  ggtitle("Bar Plot of Family Heart Disease History") +
  theme_minimal()

# Bar Plot for Heart Disease Status
ggplot(df, aes(x = `Heart Disease Status`)) +
  geom_bar(fill = "steelblue") +
  ggtitle("Bar Plot of Heart Disease Status") +
  theme_minimal()







# Multivarite Analysis

# Load necessary library
library(GGally)

# Select only numeric columns
numeric_df <- df %>%
  select(where(is.numeric)) %>%
  drop_na()  # Remove rows with NA for clean plotting

# Scatterplot matrix
ggpairs(numeric_df,
        title = "Scatterplot Matrix of Numeric Variables")



# Biplot of first two principal components

# Load required packages
library(factoextra)

# PCA - scale the numeric data first
pca_data <- scale(numeric_df)
pca_result <- prcomp(pca_data, center = TRUE, scale. = TRUE)

# Biplot
print(fviz_pca_biplot(pca_result, 
                repel = TRUE, 
                col.var = "red", 
                col.ind = "steelblue",
                title = "PCA Biplot - First Two Principal Components"))


# Conditioning plots for interactions
# Load library
library(ggplot2)

# Plot
ggplot(df, aes(x = `Exercise Habits`, y = `Cholesterol Level`, fill = `Heart Disease Status`)) +
  geom_boxplot() +
  ggtitle("Cholesterol vs Exercise Habits by Heart Disease Status") +
  theme_minimal()






