


### Getting and Cleaning Data Course Project the CODE BOOK for,
### R script called run_analysis.R
*This makes an attempt to explain the actions in the R Script*
##### Download the file and save as dataset.zip
######  Getting and Cleaning Data Course Project: R script called run_analysis.R
setwd('C:/CourseraR')
#####  ACT: Download the file  unzip to the folder and save as dataset.zip

**__if (!file.exists('dataset.zip')) {download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',destfile='dataset.zip')} else { warning("Already Downloaded from the given URL and dataset.zip is in working dir: Moving to Unzip! ")}**__

*Zip file contains a folder called 'UCI HAR Dataset' if not unzipped then this folder would not be there.  If so, Unzip the downloaded file 'dataset.zip'*

if (!file.exists('UCI HAR Dataset')) { warning("File does not exist: unzipping the file ' dataset.zip '")
  unzip('dataset.zip')} else {warning("Folder 'UCI HAR Dataset' already unzipped - moving forward ")}

*unzipped files are in the folder UCI HAR Dataset.* 

#####  ACT: Change the working directory to suit the data folder. ensure the working directory is correct

#######------------------------------------------------------------------
setwd('UCI HAR Dataset')
getwd()
## The following will be displayed after execution
## [1] "C:/CourseraR/UCI HAR Dataset"
####  ACT: Get the list of files
files  <- list.files( "." , recursive=TRUE)
files
## Some result similar to the following will be displayed after execution
## [1] "activity_labels.txt"                         
## [2] "features.txt"                                
## [3] "features_info.txt"                           
## [4] "README.txt"                                  
## [5] "test/Inertial Signals/body_acc_x_test.txt"   
## [6] "test/Inertial Signals/body_acc_y_test.txt"   
## [7] "test/Inertial Signals/body_acc_z_test.txt"   
## [8] "test/Inertial Signals/body_gyro_x_test.txt"  
## [9] "test/Inertial Signals/body_gyro_y_test.txt"  
## [10] "test/Inertial Signals/body_gyro_z_test.txt"  
## [11] "test/Inertial Signals/total_acc_x_test.txt"  
## [12] "test/Inertial Signals/total_acc_y_test.txt"  
## [13] "test/Inertial Signals/total_acc_z_test.txt"  
## [14] "test/subject_test.txt"                       
## [15] "test/X_test.txt"                             
## [16] "test/y_test.txt"                             
## [17] "train/Inertial Signals/body_acc_x_train.txt" 
## [18] "train/Inertial Signals/body_acc_y_train.txt" 
## [19] "train/Inertial Signals/body_acc_z_train.txt" 
## [20] "train/Inertial Signals/body_gyro_x_train.txt"
## [21] "train/Inertial Signals/body_gyro_y_train.txt"
## [22] "train/Inertial Signals/body_gyro_z_train.txt"
## [23] "train/Inertial Signals/total_acc_x_train.txt"
## [24] "train/Inertial Signals/total_acc_y_train.txt"
## [25] "train/Inertial Signals/total_acc_z_train.txt"
## [26] "train/subject_train.txt"                     
## [27] "train/X_train.txt"                           
## [28] "train/y_train.txt" 

##     FURTHER NOTES ON THE DATA FROM THE ASSIGNMENT EXPLANATIONS
## From the picture and the related files, we can see:
## Reference link: https://class.coursera.org/getdata-008/forum/thread?thread_id=24  
## Values of Varible Activity consist of data from "Y_train.txt" and "Y_test.txt"
## values of Varible Subject consist of data from "subject_train.txt" and subject_test.txt"
## Values of Varibles Features consist of data from "X_train.txt" and "X_test.txt"
## Names of Varibles Features come from "features.txt"
## levels of Varible Activity come from "activity_labels.txt"
## So we will use Activity, Subject and Features as part of descriptive variable names for data in data frame.
####  ACT:  Read data from the files and assign to objects
##--------------------------------------------------------------------
dataActivityTrain <- read.table(file.path("." , "train", "Y_train.txt"),col.names='Activity.Id')
dataActivityTest  <- read.table(file.path( ".", "test" , "Y_test.txt" ),col.names='Activity.Id')
##--------------------------------------------------------------------
dataSubjectTrain <- read.table(file.path(".", "train", "subject_train.txt"),col.names='Subject.Id')
dataSubjectTest  <- read.table(file.path(".", "test" , "subject_test.txt"),col.names='Subject.Id')
##--------------------------------------------------------------------
dataFeaturesTest  <- read.table(file.path(".", "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(".", "train", "X_train.txt"),header = FALSE)
##--------------------------------------------------------------------
#### MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET
####  ACT:  Bind the datasets
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)
####  ACT:  Set names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(".","features.txt"), head=FALSE)
names(dataFeatures) <- dataFeaturesNames$V2
####  ACT: Merge columns to get the dataframe 'Data' for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
####  ACT:  subset name of Features by measurements on the mean and std dev
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
####  ACT:  subset the dataframe "data" by selected names of features
SelectedNames  <- c(as.character(subdataFeaturesNames), "subject", "activity")
Data <- subset(Data, select=SelectedNames)
####  ACT:  Check the structure of the dataframe "Data"
str(Data)
### A similar result to The following will appear after execution
###  'data.frame':  10299 obs. of  68 variables:
###    $ tBodyAcc-mean()-X          : num  0.289 0.278 0.28 0.279 0.277 ...
###    $ tBodyAcc-mean()-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
###  ......
###  ......
####  ACT: Read Descriptive Activity Names
activityLabels  <- read.table(file.path(".","activity_labels.txt"), col.names=c('Activity.Id', 'Activity'))
####  ACT: check the names and activity id
head(activityLabels)
### The following will appear after execution
##   Activity.Id           Activity
##   1           1            WALKING
##   2           2   WALKING_UPSTAIRS
##   3           3 WALKING_DOWNSTAIRS
##   4           4            SITTING
##   5           5           STANDING
##   6           6             LAYING
####  ACT: Appropriately Labelling the dataset with descrptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
##### The following was the target of foreging commands ####
## prefix t is replaced by time
## prefix f is replaced by frequency
## Acc is replaced by Accelerometer
## Gyro is replaced by Gyroscope
## Mag is replaced by Magnitude
## BodyBody is replaced by Body
####  ACT: check the names after appropriate labelling
names(Data)
### The following will appear after execution
##    [1] "timeBodyAccelerometer-mean()-X"                
##    [2] "timeBodyAccelerometer-mean()-Y"                
##    [3] "timeBodyAccelerometer-mean()-Z"                
##    [4] "timeBodyAccelerometer-std()-X"                 
##    [5] "timeBodyAccelerometer-std()-Y"                 
##    [6] "timeBodyAccelerometer-std()-Z"                 
##    [7] "timeGravityAccelerometer-mean()-X"             
##    [8] "timeGravityAccelerometer-mean()-Y"             
##    [9] "timeGravityAccelerometer-mean()-Z"             
##    [10] "timeGravityAccelerometer-std()-X"              
##    [11] "timeGravityAccelerometer-std()-Y"              
##    [12] "timeGravityAccelerometer-std()-Z"              
##    [13] "timeBodyAccelerometerJerk-mean()-X"            
##    [14] "timeBodyAccelerometerJerk-mean()-Y"            
##    [15] "timeBodyAccelerometerJerk-mean()-Z"            
##    [16] "timeBodyAccelerometerJerk-std()-X"             
##    [17] "timeBodyAccelerometerJerk-std()-Y"             
##    [18] "timeBodyAccelerometerJerk-std()-Z"             
##    [19] "timeBodyGyroscope-mean()-X"                    
##    [20] "timeBodyGyroscope-mean()-Y"                    
##    [21] "timeBodyGyroscope-mean()-Z"                    
##    [22] "timeBodyGyroscope-std()-X"                     
##    [23] "timeBodyGyroscope-std()-Y"                     
##    [24] "timeBodyGyroscope-std()-Z"                     
##    [25] "timeBodyGyroscopeJerk-mean()-X"                
##    [26] "timeBodyGyroscopeJerk-mean()-Y"                
##    [27] "timeBodyGyroscopeJerk-mean()-Z"                
##    [28] "timeBodyGyroscopeJerk-std()-X"                 
##    [29] "timeBodyGyroscopeJerk-std()-Y"                 
##    [30] "timeBodyGyroscopeJerk-std()-Z"                 
##    [31] "timeBodyAccelerometerMagnitude-mean()"         
##    [32] "timeBodyAccelerometerMagnitude-std()"          
##    [33] "timeGravityAccelerometerMagnitude-mean()"      
##    [34] "timeGravityAccelerometerMagnitude-std()"       
##    [35] "timeBodyAccelerometerJerkMagnitude-mean()"     
##    [36] "timeBodyAccelerometerJerkMagnitude-std()"      
##    [37] "timeBodyGyroscopeMagnitude-mean()"             
##    [38] "timeBodyGyroscopeMagnitude-std()"              
##    [39] "timeBodyGyroscopeJerkMagnitude-mean()"         
##    [40] "timeBodyGyroscopeJerkMagnitude-std()"          
##    [41] "frequencyBodyAccelerometer-mean()-X"           
##    [42] "frequencyBodyAccelerometer-mean()-Y"           
##    [43] "frequencyBodyAccelerometer-mean()-Z"           
##    [44] "frequencyBodyAccelerometer-std()-X"            
##    [45] "frequencyBodyAccelerometer-std()-Y"            
##    [46] "frequencyBodyAccelerometer-std()-Z"            
##    [47] "frequencyBodyAccelerometerJerk-mean()-X"       
##    [48] "frequencyBodyAccelerometerJerk-mean()-Y"       
##    [49] "frequencyBodyAccelerometerJerk-mean()-Z"       
##    [50] "frequencyBodyAccelerometerJerk-std()-X"        
##    [51] "frequencyBodyAccelerometerJerk-std()-Y"        
##    [52] "frequencyBodyAccelerometerJerk-std()-Z"        
##    [53] "frequencyBodyGyroscope-mean()-X"               
##    [54] "frequencyBodyGyroscope-mean()-Y"               
##    [55] "frequencyBodyGyroscope-mean()-Z"               
##    [56] "frequencyBodyGyroscope-std()-X"                
##    [57] "frequencyBodyGyroscope-std()-Y"                
##    [58] "frequencyBodyGyroscope-std()-Z"                
##    [59] "frequencyBodyAccelerometerMagnitude-mean()"    
##    [60] "frequencyBodyAccelerometerMagnitude-std()"     
##    [61] "frequencyBodyAccelerometerJerkMagnitude-mean()"
##    [62] "frequencyBodyAccelerometerJerkMagnitude-std()" 
##    [63] "frequencyBodyGyroscopeMagnitude-mean()"        
##    [64] "frequencyBodyGyroscopeMagnitude-std()"         
##    [65] "frequencyBodyGyroscopeJerkMagnitude-mean()"    
##    [66] "frequencyBodyGyroscopeJerkMagnitude-std()"     
##    [67] "subject"                                       
##    [68] "activity" 
####  ACT: Creating and writing final tidy dataset using the library plyr
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
####  ACT: Data2 sorted as 'Subject' and then as 'Activity'
Data2<-Data2[order(Data2$subject,Data2$activity),]
####  ACT:  Check the contents of datra: print the header of tidy dataset
head(Data2)
####  ACT: write the tidydataset to a txt file
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
### end of preparing teh tidy data set and saved as "tidydata.txt"

