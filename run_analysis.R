
# installing and opening the packages
install.packages("data.table")
library(data.table)
library(dplyr)
library(tidyr)

#setting the working directory for downloading the project data
setwd("C:/Users/hamed/Desktop/Data Science/Working Directory")

#creating the required folder 
if(!file.exists("./cleaningprojectdata")){dir.create("./cleaningprojectdata")}

# setting download url path

downloadPath <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Downloading the required data
download.file(downloadPath,destfile="./cleaningprojectdata/Dataset.zip")
# the data should be unzipped in the created directory
unzip(zipfile="./cleaningprojectdata/Dataset.zip",exdir="./cleaningprojectdata")

# reading existing files in unzipped folder and storing them into data tables
# setting path of the unzipped files
Path <- "C:/Users/hamed/Desktop/Data Science/Working Directory/cleaningprojectdata/UCI HAR Dataset"
# Read files of subjects
SubjectTrainSet <- tbl_df(read.table(file.path(Path, "train", "subject_train.txt")))
SubjectTestSet  <- tbl_df(read.table(file.path(Path, "test" , "subject_test.txt" )))

# Read files which containn required data for activities
ActivityTrainSet <- tbl_df(read.table(file.path(Path, "train", "Y_train.txt")))
ActivityTestSet  <- tbl_df(read.table(file.path(Path, "test" , "Y_test.txt" )))

#Read files which contain Training and testing data
Train <- tbl_df(read.table(file.path(Path, "train", "X_train.txt" )))
Test  <- tbl_df(read.table(file.path(Path, "test" , "X_test.txt" )))

#Question 1: Merges the training and the test sets to create one data set.

# Aplly rowbind command to merge Activity and Subject files  and rename variables "subject" and "activityNumber"
FullSubject <- rbind(SubjectTrainSet, SubjectTestSet)
setnames(FullSubject, "V1", "subject")
FullActivity<- rbind(ActivityTrainSet, ActivityTestSet)
setnames(FullActivity, "V1", "activityNumber")

#merge training and testing data together
Fulldata <- rbind(Train, Test)

# set the variables names based on the features in final fulldata table
Features <- tbl_df(read.table(file.path(Path, "features.txt")))
setnames(Features, names(Features), c("featureNumber", "featureName"))
colnames(Fulldata) <- Features$featureName

#create column names for activity labels
activityLabels<- tbl_df(read.table(file.path(Path, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNumber","activityName"))

# adding the full subject data set to the full data 
FullSubjAct<- cbind(FullSubject, FullActivity)
Fulldata <- cbind(FullSubjAct, Fulldata)

#question 2:Extracts only the measurements on the mean and standard deviation for each measurement.
# in this part we retrieve only the column lables which contain mean and standard deviation from  "features.txt" file 
varnames <- grep("mean\\(\\)|std\\(\\)",Features$featureName,value=TRUE) 
varnames <- union(c("subject","activityNumber"), varnames)
#subsetting only the columns which match the selected variable names out of our full data set
Fulldata<- subset(Fulldata,select=varnames) 

#Question 3: Uses descriptive activity names to name the activities in the data set
Fulldata <- merge(activityLabels, Fulldata , by="activityNumber", all.x=TRUE)
Fulldata$activityName <- as.character(Fulldata$activityName)
Aggregatedset<- aggregate(. ~ subject - activityName, data = Fulldata, mean) 
Fulldata<- tbl_df(arrange(Aggregatedset,subject,activityName))

#question4: Appropriately labels the data set with descriptive variable names.
#setting descriptive names
#std()=Standard Deviation
#mean()=Average
#leading t=Time
#leading f=Frequency
#BodyBody = Body
#Acc = accelerometer
#Gyro = gyroscope
#Mag = magnitude 

names(Fulldata)<-gsub("std()", "Standard Deviation", names(Fulldata))
names(Fulldata)<-gsub("mean()", "Average", names(Fulldata))
names(Fulldata)<-gsub("^t", "Time", names(Fulldata))
names(Fulldata)<-gsub("^f", "Frequency", names(Fulldata))
names(Fulldata)<-gsub("BodyBody", "Body", names(Fulldata))
names(Fulldata)<-gsub("Acc", "Accelerometer", names(Fulldata))
names(Fulldata)<-gsub("Gyro", "Gyroscope", names(Fulldata))
names(Fulldata)<-gsub("Mag", "Magnitude", names(Fulldata))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr);
NewDataSet<-Fulldata
NewDataSet<-aggregate(. ~subject + activity, Fulldata, mean)
NewDataSet<-NewDataSet[order(NewDataSet$subject,NewDataSet$activity),]
write.table(NewDataSet, file = "tidydata.txt",row.name=FALSE)

