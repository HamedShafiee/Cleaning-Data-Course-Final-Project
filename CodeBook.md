# General Introduction to the Project
* `run_analysis.R`Script, does a 5 steps process based on the requirements of the project as following:

# Step 0: Preparation
* installing and opening the packages
* install.packages("data.table")
* setting the working directory for downloading the project data
* creating the required folder 
* setting download url path
* Downloading the required data
* the data should be unzipped in the created directory
* reading existing files in unzipped folder and storing them into data tables
* setting path of the unzipped files
* Read files of subjects
* Read files which containn required data for activities
* Read files which contain Training and testing data

# Step 1: Merges the training and the test sets to create one data set.
* Aplly rowbind command to merge Activity and Subject files  and rename variables "subject" and "activityNumber"
* merge training and testing data together
* set the variables names based on the features in final fulldata table
* create column names for activity labels
* adding the full subject data set to the full data

# Step 2-Extracts only the measurements on the mean and standard deviation for each measurement.
* in this part we retrieve only the column lables which contain mean and standard deviation from  "features.txt" file 
* subsetting only the columns which match the selected variable names out of our full data set

# Step 3-Uses descriptive activity names to name the activities in the data set

# Step 4-Appropriately labels the data set with descriptive variable names.
* setting descriptive names
* std()=Standard Deviation
* mean()=Average
* leading t=Time
* leading f=Frequency
* BodyBody = Body
* Acc = accelerometer
* Gyro = gyroscope
* Mag = magnitude 

# Step 5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Variables of the Project
* 3 packages are used: data.table,dplyr and tidyr
* data are stored in the follwoing variables:
* subject vars: SubjectTrainSet, SubjectTestSet
* activity vars: ActivityTrainSet, ActivityTestSet
* Trainig and Testing sets: Train,Test
* all subject data: FullSubject
* all activity data: FullActivity
* all data: Fulldata
* final tidy data: "tidydata.txt"
