* General Introduction to the Project
# `run_analysis.R`Script, does a 5 steps process based on the requirements of the project as following:

* 1-Merges the training and the test sets to create one data set.
## installing and opening the packages
## install.packages("data.table")
## setting the working directory for downloading the project data
## creating the required folder 
## setting download url path
## Downloading the required data
## the data should be unzipped in the created directory
## reading existing files in unzipped folder and storing them into data tables
## setting path of the unzipped files
## Read files of subjects
## Read files which containn required data for activities
## Read files which contain Training and testing data

* Question 1: Merges the training and the test sets to create one data set.
# Aplly rowbind command to merge Activity and Subject files  and rename variables "subject" and "activityNumber"
# merge training and testing data together
# set the variables names based on the features in final fulldata table
#create column names for activity labels
# adding the full subject data set to the full data

* Question 2-Extracts only the measurements on the mean and standard deviation for each measurement.
# in this part we retrieve only the column lables which contain mean and standard deviation from  "features.txt" file 
# subsetting only the columns which match the selected variable names out of our full data set

* Question 3-Uses descriptive activity names to name the activities in the data set

* Question 4-Appropriately labels the data set with descriptive variable names.
# setting descriptive names
# std()=Standard Deviation
# mean()=Average
# leading t=Time
# leading f=Frequency
# BodyBody = Body
# Acc = accelerometer
# Gyro = gyroscope
# Mag = magnitude 

* Question 5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Variables of the Project
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
