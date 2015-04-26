##  Getting and Cleaning Data Course Project 2 
##  R script: run_analysis.R
setwd('C:/CourseraR')

####  ACT: Download the file  unzip to the folder and save as dataset.zip
##------------------------------------------------------------------
if (!file.exists('dataset.zip')) {
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              destfile='dataset.zip')
} else {
   warning("Already Downloaded from the given URL and dataset.zip is in working dir: Moving to Unzip! ")
}

if (!file.exists('UCI HAR Dataset')) {
  warning("File does not exist: unzipping the file ' dataset.zip '")
  unzip('dataset.zip')  
} else {
  warning("Folder 'UCI HAR Dataset' already unzipped - moving forward ")
}

####  ACT: Change the working directory to suit the data folder. ensure the 
##  working directory is correct

setwd('UCI HAR Dataset')
getwd()

####  ACT: Get the list of files

files  <- list.files( "." , recursive=TRUE)
files

####  ACT:  Read data from the files and assign to objects

dataActivityTrain <- read.table(file.path("." , "train", "Y_train.txt"),col.names='Activity.Id')
dataActivityTest  <- read.table(file.path( ".", "test" , "Y_test.txt" ),col.names='Activity.Id')

dataSubjectTrain <- read.table(file.path(".", "train", "subject_train.txt"),col.names='Subject.Id')
dataSubjectTest  <- read.table(file.path(".", "test" , "subject_test.txt"),col.names='Subject.Id')

dataFeaturesTest  <- read.table(file.path(".", "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(".", "train", "X_train.txt"),header = FALSE)

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

####  ACT: Read Descriptive Activity Names

activityLabels  <- read.table(file.path(".","activity_labels.txt"), col.names=c('Activity.Id', 'Activity'))

####  ACT: check the names and activity id

head(activityLabels)

####  ACT: Appropriately Labelling the dataset with descrptive variable names

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

####  ACT: check the names after appropriate labelling

names(Data)


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

