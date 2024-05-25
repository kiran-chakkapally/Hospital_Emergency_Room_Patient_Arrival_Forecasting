# Pleasant Hospital Emergency Room Patient Arrival Forecasting

This project focuses on forecasting ER patient arrivals using various exponential smoothing methods to optimize resource allocation, reduce wait times, and improve patient outcomes at Pleasant Hospital. The analysis includes plotting historical data, performing descriptive statistics, determining correlations, and forecasting future patient arrivals.

## Table of Contents
- [Introduction](#introduction)
- [Importance of Forecasting ER Patient Arrivals](#importance-of-forecasting-er-patient-arrivals)
- [Data Loading and Inspection](#data-loading-and-inspection)
- [Data Transformation and Cleaning](#data-transformation-and-cleaning)
- [Descriptive Analysis and Visualization](#descriptive-analysis-and-visualization)
- [Correlation Analysis](#correlation-analysis)
- [Exponential Smoothing Methods](#exponential-smoothing-methods)
  - [Simple Exponential Smoothing (SES)](#simple-exponential-smoothing-ses)
  - [Holt’s Linear Trend Model](#holts-linear-trend-model)
  - [Holt-Winters Seasonal Model](#holt-winters-seasonal-model)
- [Model Selection](#model-selection)
- [Forecasting Future Patient Arrivals](#forecasting-future-patient-arrivals)
- [Conclusion](#conclusion)

## Introduction
Pleasant Hospital, the primary healthcare provider in the region, initiated a data analytics project to improve its Emergency Room (ER) operations. The aim is to accurately forecast patient arrivals, allowing for optimal resource allocation and better patient experiences.

This project applies various exponential smoothing methods to historical ER patient arrival data to find the most accurate forecasting model.

## Importance of Forecasting ER Patient Arrivals
Accurately forecasting ER patient arrivals is crucial for several reasons:
1. **Resource Allocation**: Ensures that the hospital can allocate the appropriate number of staff and medical resources to meet patient demand, preventing both understaffing and overstaffing.
2. **Reducing Wait Times**: Helps in managing patient flow more efficiently, reducing wait times and improving the overall patient experience.
3. **Improving Patient Outcomes**: Allows for better preparation and timely medical intervention, which can significantly improve patient outcomes.
4. **Operational Efficiency**: Enhances the overall operational efficiency of the ER by anticipating busy periods and planning accordingly.

## Data Loading and Inspection
### Loading the Dataset
- Manually loaded the ER patient arrival dataset from a CSV file using `read.csv()`.
### Initial Exploration
- Reviewed the first few rows and summary statistics of the dataset using functions like `head()` and `summary()`.

## Data Transformation and Cleaning
### Date Conversion
- Converted the "Date" column from character to Date type for proper time series analysis.
### Missing Values
- Checked for and handled any missing values to ensure data integrity.

## Descriptive Analysis and Visualization
### Descriptive Statistics
- Calculated mean, median, and standard deviation of patient arrivals.
### Histogram
- Created a histogram to visualize the distribution of patient arrivals.
### Boxplot
- Developed a boxplot to show the spread and outliers of patient arrivals.

## Correlation Analysis
### Temperature and Air Quality
- Calculated the correlation between patient arrivals temperature, and air quality.
### Scatter Plots
- Created scatter plots to visualize the relationship between patient arrivals, temperature, and air quality.

## Exponential Smoothing Methods
### Simple Exponential Smoothing (SES)
- Applied SES to forecast patient arrivals and reviewed the model summary and plot.
### Holt’s Linear Trend Model
- Applied Holt’s model to account for trends in patient arrivals and reviewed the model summary and plot.
### Holt-Winters Seasonal Model
- Attempted to apply the Holt-Winters seasonal model, but focused on SES and Holt's model due to insufficient data for seasonality.

## Model Selection
### Error Measures
- Evaluated the models based on error measures like RMSE.
- Selected the best model based on the lowest RMSE value.

## Forecasting Future Patient Arrivals
### Using the Best Model
- Used the best model (Holt’s Linear Trend Model) to forecast patient arrivals for the next 10 days.
### Plotting Forecasts
- Plotted the historic and forecasted patient arrivals with confidence intervals.

## Conclusion
This project involved analyzing and forecasting ER patient arrivals at Pleasant Hospital. Through various exponential smoothing methods, Holt’s Linear Trend Model was identified as the best model for forecasting. The analysis provides valuable insights for optimizing ER operations and improving patient outcomes.
