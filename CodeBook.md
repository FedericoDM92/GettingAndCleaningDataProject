**The run_analysis.R script cleans the data as asked in project description.**

**Download data**
Download data and save in folder: UCI HAR Dataset

**Variables creations**
features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activity_labels <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

**Combining the train with the test dataframes**
x (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
combineddata (10299 rows, 563 column) is created by merging subject, x and y using cbind() function

**Extraction of the measurements on the mean and standard deviation for each measurement**
cleandata (10299 rows, 88 columns) is created by subsetting combineddata, selecting only columns: subject, activity_code and the measurements on the mean and standard deviation for each measurement

**Descriptive activity names**
Entire numbers in activity_code column of the cleandata replaced with corresponding activity taken from second column of the activity_labels variable

**Descriptive variable names**
All Acc in column’s name replaced by accelerometer
All Gyro in column’s name replaced by gyroscope
All BodyBody in column’s name replaced by body
All Mag in column’s name replaced by magnitude
All start with character f in column’s name replaced by frequency
All start with character t in column’s name replaced by time

**Average of each variable for each activity and each subject**
FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalData into FinalData.txt file.
