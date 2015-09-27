# Variables in the code

The following tites can be found in the code as a comment. You can use them as reference points.

### 1. Merges the training and the test sets to create one data set.

activity_labels, X_test, y_test, subject_test, X_train, y_train, subject_train, features : contain the data which are in the same nemed txt file

x, y, subject : linked test and train data (the variable names hints their sources)

rawdata : joining of x, y and subject variables

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

extract_features : names of the column of rawdata which contain "mean" or "std" in their names. 
extracted_data: extracted data from rawdata which contain "mean" or "std" in their names of their columns.

### 5. From the data set in step 4, creates a second, ...

melted_data: melted extracted_data

tidy_data: output of the script
