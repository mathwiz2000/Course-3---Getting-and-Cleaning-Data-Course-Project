---
title: "Getting and Cleaning Data Course Project"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Data description

Description of raw data used for the project is available from:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Steps

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Details

We utilize *read.table* command to read the data, *rbind* to concatenate the training and test data sets and finally *cbind* to merge the three sets of columns.

We use *grep* to filter out measurements that are not *mean* and *std*.

We use *sub* command to tidy up the column names.

Finally, we use *dplyr* library to summarize the clean data by the *mean*.
