rm(list=ls())


#Set working directory. The downlaoded data should be all kept with no modification in a folder called "UCI HAR Dataset" in the directory. 
wd<-"C:/Users/Y/Desktop/Coursera/Data Science/Data Cleaning/Week4/Project/"

#read in variable names (Features)
Features<-read.table(paste0(wd,"/UCI HAR Dataset/features.txt"))

#read in the testing data, the subject ID, and the testing lables  
TestingSet<-read.table(paste0(wd,"/UCI HAR Dataset/test/X_test.txt"))
TestingSubject<-read.table(paste0(wd,"/UCI HAR Dataset/test/subject_test.txt"))
TestingLables<-read.table(paste0(wd,"/UCI HAR Dataset/test/Y_test.txt"))

unique(TestingSubject)  # this shows the testing dataset from which subjects

#create a merged data frame for the testing data and names all the columns 
Testing<-cbind(TestingSubject,TestingLables,TestingSet)
colnames(Testing)<-c("Subject","ActivityLable",as.character(Features$V2))

#read in the training data, the subject ID, and the training lables  
TrainingSet<-read.table(paste0(wd,"/UCI HAR Dataset/train/X_train.txt"))
TrainingSubject<-read.table(paste0(wd,"/UCI HAR Dataset/train/subject_train.txt"))
TrainingLables<-read.table(paste0(wd,"/UCI HAR Dataset/train/Y_train.txt"))

unique(TrainingSubject)  # this shows the training dataset from which subjects

#merge the three datasets and name the all the columns 
Training<-cbind(TrainingSubject,TrainingLables,TrainingSet)
colnames(Training)<-c("Subject","ActivityLable",as.character(Features$V2))

###
#Answer to Step 1
###
#merge the training and the test sets to create one data set
#save the dataframe as data
data<-rbind(Training,Testing)

###
#Answer to Step 2
###
#Extract only the measurements on the mean and standard deviation, which contain "mean()" and "std()" in the columns names
#save the dataframe as data2, which Also include the columns for subject ID and activities  
data2<-data[,c(1,2,grep("mean\\(\\)|std\\(\\)", colnames(data)))]


#read in activities names 
Activity<-read.table(paste0(wd,"/UCI HAR Dataset/activity_labels.txt"))
colnames(Activity)<-c("ActivityLable","ActivityNames")

###
#Answer to Step 3
###
#Use descriptive activity names to name the activities 
#Add a column "Activity" to decripe the activies. Save result as data3. 
data3<-merge(Activity,data2)

###
#Answer to Step 4
###
#The column names were assigned using information the "Feature.txt" file when creating the testing and training datasets
#Remove the punctuations in the column names, and keep the information about mean and standard deviation
colnames(data3)<-gsub("mean","Mean",colnames(data3))  
colnames(data3)<-gsub("std","Std",colnames(data3))
colnames(data3)<-gsub("\\(|\\)|\\-","",colnames(data3))  
  
###
#Answer to step 5
###
#Get the mean of each variable for each activity and each subject
#Save result as data4 and output to a .txt file.
library(dplyr)
data4<-data3 %>%
  group_by(Subject,ActivityNames) %>%
  summarize_all(funs(mean))

write.table(data4,paste0(wd,"Mean.txt") ,row.name=FALSE)

check<-read.table(paste0(wd,"Mean.txt"),header=TRUE) #read in and check the output data

