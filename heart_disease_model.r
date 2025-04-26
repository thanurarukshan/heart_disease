# Step 1: Install and Load Required Libraries
required_packages <- c("readr", "dplyr", "caret", "e1071")

install_and_load <- function(packages) {
  for (pkg in packages) {
    if (!require(pkg, character.only = TRUE)) {
      install.packages(pkg)
      library(pkg, character.only = TRUE)
    }
  }
}

install_and_load(required_packages)

# Step 2: Load the CSV File
data <- read_csv("heart_disease_cleaned.csv")

# Step 3: Encode Categorical Variables
data <- data %>%
  mutate(across(where(~!is.numeric(.)), as.factor))

# Step 4: Feature Scaling
preproc <- preProcess(data, method = c("center", "scale"))
data_scaled <- predict(preproc, data)

# Step 5: Train/Test Split
set.seed(42)
trainIndex <- createDataPartition(data_scaled$`Heart Disease Status`, p = 0.8, list = FALSE)
train_data <- data_scaled[trainIndex, ]
test_data <- data_scaled[-trainIndex, ]

# Step 6: Train Logistic Regression Model
model <- train(`Heart Disease Status` ~ ., data = train_data, method = "glm", family = "binomial")

# Step 7: Predict and Evaluate
predictions <- predict(model, test_data)
confusionMatrix(predictions, test_data$`Heart Disease Status`)
