## Getting-and-Cleaning-Data-Course-Project 1
Created for the Getting and Cleaning Data Course Project

This repo contains my course project to Coursera "Getting And Cleaning Data" course that is part of Data Science specialization. There is only one script called run_analysis.R.

Description - R script called run_analysis.R: Project assignment of the Getting and Cleaning Data -April 2015

### The Goal

This code is for the purpose of completing the Project assignment of the Getting and Cleaning Data, course conducted in Coursera by Johns Hopkins University 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This assignment is to be graded by peers on a series of yes/no questions related to the project. It is required to to submit: 1) a tidy data set required in the details, 2) a link to a Github repository with the script for performing the analysis, and 3) a code book called CodeBook.md that describes the variables, the data, and any transformations or work that has been carried out to clean up the data. This file is the README.md fle that outlines the work executed. 

###  Further details

One of the most exciting areas in all of data science right now is wearable computing see for example this article (http://www.insideactivitytracking.com/datascienceactivitytrackingandthebattlefortheworldstopsportsbrand/).  Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Data sources for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Target

It is required to create one R script called run_analysis.R that does the following.
* 1. Merges the training and the test sets to create one data set.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* 3. Uses descriptive activity names to name the activities in the data set.
* 4. Appropriately labels the data set with descriptive variable names.
* 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Actions Executed by the Script

It is important to set the working directory to download and then save the file using the R commands.  Therefore initially set the working directory. 
The file is coded in a way that it check whether the file is already in the destination. This is to avoid the duplication of efforts.  
Once saved, the R code then unzips the file and saves in the desired directory.
The file arrangement and the hierachy needs to be noted and printing a list of files would be a good idea.  The following reference may be a helpful reference; ## Reference link: https://class.coursera.org/getdata-008/forum/thread?thread_id=24  

In this,
* Values of Varible Activity consist of data from "Y_train.txt" and "Y_test.txt"
* Values of Varible Subject consist of data from "subject_train.txt" and subject_test.txt"
* Values of Varibles Features consist of data from "X_train.txt" and "X_test.txt"
* Names of Varibles Features come from "features.txt"
* Levels of Varible Activity come from "activity_labels.txt"
* So we will use Activity, Subject and Features as part of descriptive variable names for data in data frame.

Next is to read the data from the files and then to assign to objects.  

Then the code performes the merging of training and test datasets to create one dataset.

After setting suitable names to the variables then data columns are merged to get the dataframe for all data.  In order to get the mean and the standard deviation, the data are then assigned as subsets. Once done the code than checks the structuer of the data frame called data.  This follows the reading of descriptive activity names and then checking of names and corresponding activity Id.  
The next is to appropriately label the dataset with descriptive variable neames.  In this context,  the prefix t is replaced by time, Acc is replaced by Accelerometer, Gyro is replaced by Gyroscope, prefix f is replaced by frequency, and Mag is replaced by Magnitude, BodyBody is replaced by Body.  As a confirmation the coding checks the names after appropriate labeling with a print on display. 
Then creation and writing the final tidy dataset is carried out with the use of the plyr library.  The tidy dataset would finally be written as a text file called tidydata.txt 


