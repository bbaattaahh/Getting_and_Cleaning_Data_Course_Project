library(dplyr)
library(tidyr)
library(data.table)
library(reshape2)


# 0. Set YOUR working directory, you can see mine as an exampel
setwd("C:\\Users\\Henrik\\Dropbox\\Coursera\\Getting And Cleaning Data\\Course Project\\UCI HAR Dataset")


# 1. Merges the training and the test sets to create one data set.
# 1.1. Read all data in

activity_labels <- read.table("./activity_labels.txt")[,2]

X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

features <- read.table("./features.txt")[,2]

# 1.2. Link the read data, and rename the cloumns
x <- rbind(X_test, X_train)
names(x) <- features

y <- rbind(y_test, y_train)
names(y) <- "y"

subject <- rbind(subject_test, subject_train)
names(subject) <- "subject"

# rawdata:this is tha wariable which contains the whole read data
rawdata <- cbind(y, subject, x)



# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 2.1. Find that coloumn names which are contains "mean" or "std" parts
extract_features <- grepl("mean|std", names(rawdata))
# 2.2. Extract from rawdata the matching coloumns.
extracted_data <- rawdata[,extract_features]



# 3. Uses descriptive activity names to name the activities in the data set
# 3.1 Change the activity id (number) to the activity label in rawdata. (This coloumn will be linked to extracted_data.)
rawdata$y <- activity_labels[rawdata$y]



# 4. Appropriately labels the data set with descriptive variable names. 
# 4.1. Link the extracted data and the subjects and the activiti labels
names(rawdata)[1] <- "Activity_Label"
extracted_data <- cbind(rawdata$Activity_Label, rawdata$subject, extracted_data)
# 4.2. Correcting the changed coloumn names. They are changed because of cbind, they are herated the variable nem as well in their names.
names(extracted_data)[1] <- "Activity_Label"
names(extracted_data)[2] <- "subject"



# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 5.1. Melt the extracted data by subject and Activity labael

melted_data <- melt(extracted_data, id = c("subject", "Activity_Label"))

tidy_data <- dcast(melted_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "tidy.txt", row.name=FALSE)


