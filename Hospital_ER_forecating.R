#  Forecasting Hospital Emergency Room Patient Arrivals

# Load the necessary libraries
# Install the libraries if they are not already installed
#install.packages("ggplot2")
#install.packages("forecast")
#install.packages("tidyverse")
library(ggplot2)
library(forecast)
library(tidyverse)

# Load the data into a dataframe called 'patient_data'
# This assumes the CSV file is in the working directory
patient_data <- read.csv("Emergency_room_data.csv")

# View the first 6 records in the dataframe to understand its structure
head(patient_data)

# Check the number of columns and rows in the dataframe
ncol(patient_data)  # Number of columns
nrow(patient_data)  # Number of rows

# Get a summary of the dataframe to see statistics and data types
summary(patient_data)

# Convert the 'Date' column from character type to Date type for time series analysis
patient_data$Date <- as.Date(patient_data$Date, format="%m/%d/%Y")

# Check the summary again to confirm that the 'Date' column is now in Date format
summary(patient_data$Date)
summary(patient_data)

# Check for any missing values (NA) in the dataframe
sum(is.na(patient_data))

# Question 1: Plot the historic data and analyze the trend

# Plot the patient arrival data over time
historic_data_of_patient_arrivals <- ggplot(patient_data, aes(x=Date, y=PatientArrivals)) +
  geom_line() +
  labs(title="Historic Data of Patient Arrivals", x="Date", y="Number of Patient Arrivals")
print(historic_data_of_patient_arrivals)

# Analyze the trend in patient arrivals
# Observations:
# - The number of patient arrivals fluctuates significantly throughout the month
# - There is no clear upward or downward trend
# - Periodic cycles might be present

# Aggregate data by day of the week to see weekly patterns
weekly_data <- patient_data %>%
  group_by(DayOfWeek) %>%
  summarise(AverageArrivals = mean(PatientArrivals))

# Plot the average patient arrivals for each day of the week
bar_plot <- ggplot(weekly_data, aes(x=DayOfWeek, y=AverageArrivals)) +
  geom_bar(stat="identity", fill="skyblue") +
  labs(title="Average Patient Arrivals by Day of the Week", x="Day of the Week", y="Average Number of Patient Arrivals") +
  theme_minimal()
print(bar_plot)

# Observation from the plot:
# - Patient arrivals peak at the start of the week (Monday) and gradually decline towards the weekend

# Question 2: Analyze the demand with descriptive statistics (mean, median, standard deviation), histogram, and boxplot

# Calculate mean, median, and standard deviation of patient arrivals
mean_of_patient_arrivals <- mean(patient_data$PatientArrivals)
median_of_patient_arrivals <- median(patient_data$PatientArrivals)
sd_of_patient_arrivals <- sd(patient_data$PatientArrivals)

mean_of_patient_arrivals  # Print mean
median_of_patient_arrivals  # Print median
sd_of_patient_arrivals  # Print standard deviation

# Create a histogram to visualize the distribution of patient arrivals
histogram <- ggplot(patient_data, aes(x=PatientArrivals)) +
  geom_histogram(binwidth=10, fill="pink", color="green", alpha=0.7) +
  labs(title="Histogram of Patient Arrivals", x="Number of Patient Arrivals", y="Frequency") +
  theme_minimal()
print(histogram)

# Histogram Analysis:
# - Most patient arrivals fall between 110-120
# - Some days have significantly fewer or more patients, with a few unusually busy days around 170

# Create a boxplot to show the spread and outliers of patient arrivals
patient_boxplot <- ggplot(patient_data, aes(y=PatientArrivals)) +
  geom_boxplot(fill="skyblue", color="black") +
  labs(title="Boxplot of Patient Arrivals", y="Number of Patient Arrivals") +
  theme_minimal()
print(patient_boxplot)

# Boxplot Analysis:
# - Most days have between 90 and 140 patient arrivals
# - The middle value (median) is around 120
# - The overall range of patient arrivals is from about 70 to 160

# Question 3: Determine if there is a correlation between the arrival of patients and temperature, and Air Quality

# Calculate the correlation between patient arrivals and temperature
cor_temp <- cor(patient_data$PatientArrivals, patient_data$Temperature)

# Calculate the correlation between patient arrivals and air quality
cor_air_quality <- cor(patient_data$PatientArrivals, patient_data$Air_quality)

# Print the correlation coefficients
cat("Correlation between Patient Arrivals and Temperature:", cor_temp, "\n")
cat("Correlation between Patient Arrivals and Air Quality:", cor_air_quality, "\n")

# Create a scatter plot to show the relationship between temperature and patient arrivals
plot_temp <- ggplot(patient_data, aes(x=Temperature, y=PatientArrivals)) +
  geom_point() +
  geom_smooth(method="lm", col="red") +
  labs(title="Patient Arrivals vs Temperature", x="Temperature", y="Number of Patient Arrivals") +
  theme_minimal()
print(plot_temp)

# Create a scatter plot to show the relationship between air quality and patient arrivals
plot_air_quality <- ggplot(patient_data, aes(x=Air_quality, y=PatientArrivals)) +
  geom_point() +
  geom_smooth(method="lm", col="red") +
  labs(title="Patient Arrivals vs Air Quality", x="Air Quality", y="Number of Patient Arrivals") +
  theme_minimal()
print(plot_air_quality)

# Analysis from the plots:
# - There is a very slight positive correlation between temperature and patient arrivals
# - There is a very slight positive correlation between air quality and patient arrivals
# - These correlations suggest minor impacts from temperature and air quality on patient arrivals

# Question 4: Apply exponential smoothing methods (simple, holt, winters) to calculate the forecast. Decide on the best model based on error measures.

# Convert the data into time series format for forecasting
patient_time_series <- ts(patient_data$PatientArrivals, start=c(2023, 1), frequency=365)
print(patient_time_series)

# Apply Simple Exponential Smoothing (SES) to the time series data
simple_exponential_smoothing_model <- ses(patient_time_series)

# Print summary of the SES model
summary(simple_exponential_smoothing_model)

# Plot the SES forecast
plot(simple_exponential_smoothing_model)

# Apply Holt's Linear Trend Model to the time series data
holt_model <- holt(patient_time_series)

# Print summary of the Holt model
summary(holt_model)

# Plot the Holt forecast
plot(holt_model)

# Holt-Winters Seasonal Model is not applied due to insufficient data for seasonality

# Compare models based on error measures to decide the best model
# Calculate accuracy measures for each model
ses_accuracy <- accuracy(simple_exponential_smoothing_model)
print("SES Model Accuracy:")
print(ses_accuracy)

holt_accuracy <- accuracy(holt_model)
print("Holt Model Accuracy:")
print(holt_accuracy)

# Determine the best model based on RMSE (Root Mean Squared Error)
best_model <- ifelse(ses_accuracy[,"RMSE"] < holt_accuracy[,"RMSE"], "SES", "Holt")
cat("The best model is:", best_model, "\n")

# Question 5: Calculate the forecast for the next 10 days, based on the selected method (Holt's model)

# Forecast for the next 10 days using Holt's model
forecast_values <- forecast(holt_model, h=10)
print(forecast_values)

# Plot the forecasted values for the next 10 days
plot(forecast_values)

# Extract forecast components for detailed plotting
forecast_df <- data.frame(
  Date = seq.Date(from = as.Date("2023-01-01"), by = "day", length.out = length(patient_time_series) + 10)[-(1:length(patient_time_series))],
  Point.Forecast = as.numeric(forecast_values$mean),
  Lo.80 = as.numeric(forecast_values$lower[, 1]),
  Hi.80 = as.numeric(forecast_values$upper[, 1]),
  Lo.95 = as.numeric(forecast_values$lower[, 2]),
  Hi.95 = as.numeric(forecast_values$upper[, 2])
)

# Create a dataframe for historic data
historic_df <- data.frame(
  Date = seq.Date(from = as.Date("2023-01-01"), by = "day", length.out = length(patient_time_series)),
  PatientArrivals = as.numeric(patient_time_series)
)

# Plot the historic and forecast values together
ggplot() +
  geom_line(data=historic_df, aes(x=Date, y=PatientArrivals), color="black") +
  geom_line(data=forecast_df, aes(x=Date, y=Point.Forecast), color="skyblue") +
  geom_ribbon(data=forecast_df, aes(x=Date, ymin=Lo.80, ymax=Hi.80), fill="skyblue", alpha=0.2) +
  geom_ribbon(data=forecast_df, aes(x=Date, ymin=Lo.95, ymax=Hi.95), fill="skyblue", alpha=0.1) +
  labs(title="Historic and Forecasted Patient Arrivals", x="Date", y="Number of Patient Arrivals") +
  theme_minimal()
