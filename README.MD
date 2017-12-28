---
title: "README.md"
author: "Jeho Kang"
date: "December 27, 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Getting and Cleaning data project

This is for the Getting and Cleaning data course's project and following files were uploaded.

* README.MD
* CodeBook.MD
* run_analysis.R
* tidydata.txt

### Data set

The data set is able to download following link.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once download the zip file, unzip the file into current R working directory. "/UCI HAR Dataset" sub-directory will be created with unzipped data files.

### run_analysis.R script

The run_analysis.R script does followings:

1. Loads the activity and feature files.
2. Loads the files in test sub-folder and train sub-folder.
3. Merges the datasets from test and train.
4. Extracts the variables with mean() or std() from the column name.
5. Creates a tidy dataset with melt and dcast functions.
6. Creates output data file "tidydata.txt" from the tidy dataset.
