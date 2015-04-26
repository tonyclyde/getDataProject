# getDataProject

## Summary
Course project for Coursera course: getdata-013
This project consists of one R file: run_analysis.R, and a folder of data for it to analyze.

## Description

### Step 1

Loads the independent data files data/test/X_test.txt and data/train/X_train.txt which contain the bulk of the data.

### Step 2

Binds descriptive column names to the data sets (with pesky parentheses removed), loaded from: features.txt. Assumes the number of rows in this file is exactly the same as the number of columns in the test and train data.

### Step 3

Removes all columns from both sets which are not mean or std variables, again assumes this results in both data sets having the same number of columns.

### Step 4

Adds the subject ids to the data, loaded from: subject_test.txt and subject_train.txt respectively. Assumes the number of rows in the subject data matches the number of rows in their respective data sets.

### Step 5

Adds the activity ids to the data, loaded from: y_test.txt and y_train.txt respectively. Assumes the number of rows in the activity data matches the number of rows in their respective data sets.

### Step 6

Combine the two data sets together assuming identical column names, result in a data set with all rows from both of the originals.

### Step 7

Replace the activity_id column with an activity column containing the corresponding descriptive activity name from the activity_labels.txt file.

### Step 8

Create a second data set of column mean values, grouped by subject_id and activity, and write the result to the file: tidy_data.txt