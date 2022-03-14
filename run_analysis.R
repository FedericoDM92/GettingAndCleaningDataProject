library(dplyr)

# Download the zip folder if needed
filename <- "dataproject.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Unzip the folder if needed
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Creation of all the dataframes
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_code")

# Combining the train with the test dataframes
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
combineddata <- cbind(subject, y, x)

# Extraction of the measurements on the mean and standard deviation for each measurement
cleandata <- combineddata %>% select(subject, activity_code, contains("mean"), contains("std"))

# Descriptive activity names
cleandata$activity_code <- activity_labels[cleandata$activity_code,2]

# Descriptive variable names
names(cleandata)<-gsub("Acc", "accelerometer", names(cleandata))
names(cleandata)<-gsub("Gyro", "gyroscope", names(cleandata))
names(cleandata)<-gsub("BodyBody", "body", names(cleandata))
names(cleandata)<-gsub("Mag", "magnitude", names(cleandata))
names(cleandata)<-gsub("^t", "time", names(cleandata))
names(cleandata)<-gsub("^f", "frequency", names(cleandata))
names(cleandata)<-gsub("tBody", "timebody", names(cleandata))
names(cleandata)<-gsub("-mean()", "mean", names(cleandata), ignore.case = TRUE)
names(cleandata)<-gsub("-std()", "STD", names(cleandata), ignore.case = TRUE)
names(cleandata)<-gsub("-freq()", "frequency", names(cleandata), ignore.case = TRUE)

# Average of each variable for each activity and each subject
smallcleandata <- cleandata %>%
  group_by(subject, activity_code) %>%
  summarise(across(,mean))
write.table(smallcleandata, "smallcleandata.txt", row.name=FALSE)
