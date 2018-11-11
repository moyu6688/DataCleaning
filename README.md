# DataCleaning
This code tidy the datasets from Human Activity Recognition database record by the Samsung Galaxy S smartphone. The recordings are from 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

## Step 1 Building one dataset combining the training and the test sets
The code first read in the the test dataset and its corresponding subjact and activity lables, and generate a merge file containing all the information. The column names are assigned using the feature information. Then a merged dataset for the training data is created in the same way. Then the two dataframes are merged into one dataframe. 

The key functions used in this step are read.table(), cbind(), rbind(), and colnames().

## Step 2 Extracting only the measurements on the mean and standard deviation
The code looks for the columns with "mean()" and "std" in their names, and extarct the columns. 

The key function used in this step is grep().

## Step 3 Using descriptive activity names to name the activities
The code first read in the acitivity names associated with the lales from the "activit_lablels.txt" file. And then merge the dataset with the earlier with according to the lables. 

The key function used in this step is merge(). 

## Step 4 Labeling the data set with descriptive variable names
This code tidy up the column names with more discriptive term. 

The key function used in this step is gsub(). 

## Step 5 Creating a new dataframe for the mean of each variable for each activity and each subject
This code group the earlier dataset set by subject and activity names, and the get the mean of all the variables. 

The key functions used in this step are %>%, group_by(), and summarize_all() from the library dplyr. 
