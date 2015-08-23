# Getting and Cleaning Data Course Project- ReadMe

This is the README for the Getting and Cleaning Data Course Project, it explains the course project, how all of the scripts in this repo work and how they are connected. There are two additional scripts in this repo: 'CodeBook.md' and 'run_analysis.R'.

## Course Project Description

The goal of the course project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

## The Code Book

'CodeBook.md' contains information on the study design, background of the dataset, description of the variables, list of variables, and a brief description of how the data was manipulated (using the run_analysis.R script).

## The Analysis Script

'run_analysis.R' contains the code used to generate the tidy data set submitted for the project, along with notes before each step. The code works as follows:

1. Loads the necessary packages: 'dplyr', 'reshape2', and 'data.table'.
2. Download and unzip the file.
3. Read the activity labels and feature names and assign them to a respective variable (i.e. ActivityLabels and FeatureNames).
4. Read the training and test sets for Subject, Features, and Activity, and assign them to a respective variable (i.e. SubjectTraining and SubjectTest).
5. Combine the training and test sets Subject, Features, and Activity and assign them to a respective variable (i.e. SubjectData).
6. Name the columns in each dataset (i.e. "Subject" for SubjectData)
7. Merage SubjectData, ActivityData, and FeaturesData into one dataset, ALLData.
8. Extract only measurements for the mean and standard deviation for each measurements.
9. Use activity labels from 'activity_labels.txt' to name the activities in the dataset.
10. Label the dataset with descriptive variable names by substituting abbreviations for the actual word (i.e. substitute 'Acc' for 'Accelerometer').
11. Create a second, independent tidy dataset with the average of each variable for each activity and each subject.
12. Create a text file using write.table() and row.name=FALSE to submit.
