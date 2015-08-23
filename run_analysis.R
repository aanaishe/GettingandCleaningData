## Load the necessary packages.
library(dplyr)
library(reshape2)
library(data.table)

## Download and unzip the file.
fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./CleaningData/PhoneData.zip")
unzip(zipfile="./CleaningData/PhoneData.zip", exdir="./CleaningData")

setwd("C:/Users/ahegab/Documents/Coursera/CleaningData")
list.files()

files<-list.files("UCI HAR Dataset", recursive=TRUE)
files

##Read Feature names and Activity labels
FeatureNames<-read.table("UCI HAR Dataset/features.txt")
ActivityLabels<-read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)

##Read training and test sets for Subject, Features, and Activity
setwd("C:/Users/ahegab/Documents/Coursera")
SubjectTraining<- read.table(file.path("./CleaningData", "UCI HAR Dataset", "train", "subject_train.txt"), header=FALSE)
SubjectTest<- read.table(file.path("./CleaningData", "UCI HAR Dataset", "test", "subject_test.txt"), header=FALSE)
FeaturesTest<- read.table(file.path("./CleaningData", "UCI HAR Dataset", "test", "X_test.txt"), header=FALSE)
FeaturesTraining<- read.table(file.path("./CleaningData", "UCI HAR Dataset", "train", "X_train.txt"), header=FALSE)
ActivityTraining<- read.table(file.path("./CleaningData", "UCI HAR Dataset", "train", "Y_train.txt"), header=FALSE)
ActivityTest<- read.table(file.path("./CleaningData", "UCI HAR Dataset", "test", "Y_test.txt"), header=FALSE)

##Combine training and test sets for Subject, Features, and Activity
SubjectData<- rbind(SubjectTraining, SubjectTest)
FeaturesData<- rbind(FeaturesTraining, FeaturesTest)
ActivityData<- rbind(ActivityTraining, ActivityTest)

##Naming columns for each data set
colnames(SubjectData)<-"Subject"
colnames(FeaturesData)<-t(FeatureNames[2])
colnames(ActivityData)<-"Activity"

##Merge all data into one dataset
ALLData<-cbind(SubjectData, ActivityData, FeaturesData)
View(ALLData)

##Extract only the measurements on the mean and std deviation for each measurement
ExtractMeanStdDev<-grep(".*Mean.*|.*Std.*", names(ALLData), ignore.case=TRUE)
DesiredData<-c(1,2,ExtractMeanStdDev)
ExtractedData<-ALLData[,DesiredData]
View(ExtractedData)

##Use activity labels to name the activities in the data set
ExtractedData$Activity<-as.character(ExtractedData$Activity)
for (i in 1:6){
  ExtractedData$Activity[ExtractedData$Activity == i]<- as.character(ActivityLabels[i,2])
}
ExtractedData$Activity<-as.factor(ExtractedData$Activity)
View(ExtractedData)

##Label the dataset with descriptive variable names
names(ExtractedData)<-gsub("^t", "time", names(ExtractedData))
names(ExtractedData)<-gsub("^f", "frequency", names(ExtractedData))
names(ExtractedData)<-gsub("Acc", "Accelerometer", names(ExtractedData))
names(ExtractedData)<-gsub("Gyro", "Gyroscope", names(ExtractedData))
names(ExtractedData)<-gsub("Mag", "Magnitude", names(ExtractedData))
names(ExtractedData)<-gsub("BodyBody", "Body", names(ExtractedData))
View(ExtractedData)

##Create a second, independent tidy data set with the average
##of each variable for each activity and each subject
ExtractedData$Subject<-as.factor(ExtractedData$Subject)
ExtractedData<-data.table(ExtractedData)

TidyDataSet<-aggregate(.~Subject + Activity, ExtractedData, mean)
TidyDataSet<-TidyDataSet[order(TidyDataSet$Subject, TidyDataSet$Activity),]
View(TidyDataSet)

##Create a text file using write.table() and row.name=FALSE
write.table(TidyDataSet, file="TidyDataSet.txt", row.names=FALSE)