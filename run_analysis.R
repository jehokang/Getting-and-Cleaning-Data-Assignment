## data sets have to be stored "/UCI HAR Dataset" folder under current working directory

filepath <- paste(getwd(), "/UCI HAR Dataset", sep = "")
setwd(filepath)

## reading table sets
activity_labels <- read.table(paste(filepath, "activity_labels.txt", sep = "/"))
features <- read.table(paste(filepath, "features.txt", sep = "/"))

x_test <- read.table(paste(filepath, "test", "X_test.txt", sep = "/"))
y_test <- read.table(paste(filepath, "test", "y_test.txt", sep = "/"))
subject_test <- read.table(paste(filepath, "test", "subject_test.txt", sep = "/"))

x_train <- read.table(paste(filepath, "train", "X_train.txt", sep = "/"))
y_train <- read.table(paste(filepath, "train", "y_train.txt", sep = "/"))
subject_train <- read.table(paste(filepath, "train", "subject_train.txt", sep = "/"))

## merging the sets and assigning descriptive variable names
subject_merged <- rbind(subject_test, subject_train)
x_merged <- rbind(x_test, x_train)
y_merged <- rbind(y_test, y_train)

colnames(activity_labels) <- c("id", "activity")
colnames(subject_merged) <- "subject"

for(i in 1:561) (
    colnames(x_merged)[i] <- paste("t", i, sep = "")
)

colnames(y_merged) <- "activity_id"

## calculating mean and sd for step 2
row_mean <- rowMeans(x_merged)
x_merged_sd <- transform(x_merged, row_sd=apply(x_merged,1, sd, na.rm = TRUE))
x_merged_sdmean <- cbind(x_merged_sd, row_mean)

measures <- list(
    mean(x_merged_sdmean$row_mean),
    sd(x_merged_sdmean$row_sd)
)
names(measures) <- c("mean_value", "sd_value")

print(measures)

## joins y_merged and activity_labels
y_merged_activity <- merge(y_merged, activity_labels, by.x="activity_id", by.y="id", all.x = TRUE, sort = FALSE)


## creating second tidy data set with the average for each activity and each subject

library(dplyr)

all_data <- cbind(subject_merged, select(y_merged_activity, activity), x_merged_sdmean)
all_data_bygroup <- group_by(all_data, subject, activity)
new_tidy_set <- summarize(all_data_bygroup, mean(row_mean))
names(new_tidy_set) <- c("subject", "activity", "average_value")
write.table(new_tidy_set, file="output.txt", row.names = FALSE)
