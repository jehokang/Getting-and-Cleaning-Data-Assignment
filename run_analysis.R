filepath <- paste0(getwd(), "/UCI HAR Dataset")

## reading table sets

activity_labels <- read.table(paste(filepath, "activity_labels.txt", sep = "/"))
feature <- read.table(paste(filepath, "features.txt", sep = "/"))

x_test <- read.table(paste(filepath, "test", "X_test.txt", sep = "/"))
y_test <- read.table(paste(filepath, "test", "y_test.txt", sep = "/"))
subject_test <- read.table(paste(filepath, "test", "subject_test.txt", sep = "/"))

x_train <- read.table(paste(filepath, "train", "X_train.txt", sep = "/"))
y_train <- read.table(paste(filepath, "train", "y_train.txt", sep = "/"))
subject_train <- read.table(paste(filepath, "train", "subject_train.txt", sep = "/"))


##  Merging the data sets
x_merge <- rbind(x_test, x_train)
y_merge <- rbind(y_test, y_train)
subject_merge <- rbind(subject_test, subject_train)


## Extracting only the measurements on the mean and standard deviation
feature_ext <- grep("mean\\(\\)|std\\(\\)", feature$V2)

all_data <- cbind(subject_merge, y_merge, x_merge[,feature_ext])
colnames(all_data) <- c("subject", "activity", as.character(feature[feature_ext,2]))

## Uses descriptive activity names to name the activities in the data set
all_data$subject <- as.factor(all_data$subject)
all_data$activity <- factor(all_data$activity, levels = activity_labels$V1, labels = activity_labels$V2)

# Creating tidy data set with the average of each variable for each activity and subject
library(reshape2)

all_data_melt <- melt(all_data, id = c("subject", "activity"))
all_data_tidy <- dcast(all_data_melt, subject + activity ~ variable, mean)

write.table(all_data_tidy, file = "tidydata.txt", row.names = FALSE, col.names = TRUE)
