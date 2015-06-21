# Getting-and-Cleaning-Data-Course-Project
This is the script and supporting documents for the Getting and Cleaning data course project

The data used for input can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This data should be downloaded and unzipped. This folder needs to be left intact in your working directory.

You will need reshape2 to run this script.

When you run run_analysis() the following steps will happen:

Check for nessessary files
  1. Presense of UUCI HAR dataset folder in working directory
  2. UCI HAR Dataset/test/subject_test.txt
  3. UCI HAR Dataset/test/Y_test.txt
  4. UCI HAR Dataset/test/X_test.txt
  5. UCI HAR Dataset/train/subject_train.txt
  6. UCI HAR Dataset/train/Y_train.txt
  7. UCI HAR Dataset/train/X_train.txt
  8. UCI HAR Dataset/features.txt
  9. UCI HAR Dataset/activity_labels.txt

The above files will be combined into a single dataframe based on the the following:
There are two sets of data train and test. The layout of this data is the same. 
- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training data set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test data set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

These files will be all combined into a single dataset with only the activity labels that are mean or standard deviation kept.
These can be identified with -mean() or -std() suffix

A list of which fields were kept can be found in the code book in this repo.


The script combines the files as follows:
1. Column names are appended onto X file from the activity labels file.
2. Subjects(subject file) are appended to the X file as a seperate column. This must be done before order is changed and done for test and train.
3. Activity ID's(y file) are appended to the X file as a seperate column. This must be done before order is changed and done for test and train.
4. Column names with -mean() and -std() are selected. The assignment specifies only mean and standard devation of measurements. There are other's such as meanfreq that are not measurements that were not selected.
5. Datatable is subsetted to only keep needed columns and the subject and activity ID column
6. Activity_ID is merged with Activity's to get the descriptive names. 
7. Activity ID is removed
8. Data is melted using reshape2 and grouped with Subject and Activity
9. Data is casted back to a table summerized with the mean function.
10. Column's are renamed to be valid. 
10. courseoutput.txt is output with row.name =false. 

Output data can be used via read.table in R. 





