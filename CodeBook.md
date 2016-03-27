# General Introduction to the Project
`run_analysis.R`Script, does a 5 steps process based on the requirements of the project as following:

* 1-Merges the training and the test sets to create one data set.
* # installing and opening the packages
#install.packages("data.table")
#setting the working directory for downloading the project data
#creating the required folder 
# setting download url path
# Downloading the required data
# the data should be unzipped in the created directory
# reading existing files in unzipped folder and storing them into data tables
# setting path of the unzipped files
# Read files of subjects
# Read files which containn required data for activities
#Read files which contain Training and testing data

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

* 2-Extracts only the measurements on the mean and standard deviation for each measurement.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.

* 3-Uses descriptive activity names to name the activities in the data set
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.

* 4-Appropriately labels the data set with descriptive variable names.
* On the whole dataset, those columns with vague column names are corrected.

* 5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `averages_data.txt`, and uploaded to this repository.

# Variables of the Project
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
