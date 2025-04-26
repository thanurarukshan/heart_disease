import pandas as pd

# Load the dataset
file_path = './heart_disease.csv'
df = pd.read_csv(file_path)

# Display basic info
print("Initial Missing Values:\n", df.isnull().sum())

# Strategy:
# - For numeric columns: fill missing with median
# - For categorical columns: fill missing with mode

for column in df.columns:
    if df[column].dtype in ['float64', 'int64']:
        median_value = df[column].median()
        df[column].fillna(median_value, inplace=True)
    else:
        mode_value = df[column].mode()[0]
        df[column].fillna(mode_value, inplace=True)

# Check again
print("\nMissing Values After Filling:\n", df.isnull().sum())

# Save the cleaned dataset
cleaned_file_path = './heart_disease_cleaned.csv'
df.to_csv(cleaned_file_path, index=False)
print(f"\nCleaned dataset saved to {cleaned_file_path}")