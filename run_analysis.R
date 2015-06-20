# This script will run an analysis on the UCI HAR Dataset 

run_analysis <- function(){

# check if the data folder is in the WD
if(!(file.exists("UCI HAR Dataset")))
{stop("UCI HAR Dataset folder must be in your WD")}

# check to see if all require files are present
if(!(file.exists("UCI HAR Dataset/test/subject_test.txt")))
     {stop("UCI HAR Dataset/test/subject_test.txt MISSING")}
if(!(file.exists("UCI HAR Dataset/test/Y_test.txt")))
     {stop("UCI HAR Dataset/test/Y_test.txt MISSING")}
if(!(file.exists("UCI HAR Dataset/test/X_test.txt")))
     {stop("UCI HAR Dataset/test/X_test.txt MISSING")}
if(!(file.exists("UCI HAR Dataset/train/subject_train.txt")))
     {stop("UCI HAR Dataset/train/subject_train.txt MISSING")}
if(!(file.exists("UCI HAR Dataset/train/Y_train.txt")))
     {stop("UCI HAR Dataset/train/Y_train.txt MISSING")}
if(!(file.exists("UCI HAR Dataset/train/X_train.txt")))
     {stop("UCI HAR Dataset/train/X_train.txt MISSING")}
if(!(file.exists("UCI HAR Dataset/features.txt")))
     {stop("UCI HAR Dataset/features.txt MISSING")}
if(!(file.exists("UCI HAR Dataset/activity_labels.txt")))
     {stop("UCI HAR Dataset/activity_labels.txt")}


# read tables into dataframes
# Test
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

#Train
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

# descriptors
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                              stringsAsFactors = FALSE)


# set colnames using the features table
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]

# set col labes of other files
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"
colnames(y_test) <- "Activity_ID"
colnames(y_train) <- "Activity_ID"
colnames(activity_labels) <- c("Activity_ID", "Activity")



# append subjects
x_test$Subject <- subject_test[,1]
x_train$Subject <- subject_train[,1]

# append Activities
x_test$Activity_ID <- y_test[,1]
x_train$Activity_ID <- y_train[,1]

# combine test and train
fulltable <-rbind(x_test, x_train)

#get needed column logical The trues on the end are for the subject and activity
neededcols <- c(grepl("-mean\\(\\)|-std\\(\\)",features$V2),TRUE,TRUE)


#select only columns we want
fulltable <- fulltable[,neededcols]

# merge Activities with full descriptions
fulltable <- merge(fulltable, activity_labels, by.x = "Activity_ID", 
                   by.y = "Activity_ID")
#remove activity_ID
notactid <- !grepl("Activity_ID",colnames(fulltable))

fulltable <- fulltable[,notactid]

# Make column names syntactically valid
colnames(fulltable) <- make.names(colnames(fulltable))

#use reshape2 to melt data
library(reshape2)
melted <- melt(fulltable, id = c("Subject", "Activity"))

#cast and average data
casted <- dcast(melted, Subject + Activity ~ variable, mean, rm.na = TRUE)

#write final output
write.table(casted, "Courseoutput.txt", row.name=FALSE)
}
