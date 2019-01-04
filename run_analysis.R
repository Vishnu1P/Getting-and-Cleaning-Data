# Script - run_analysis.R

# Purpose - Get and clean data sets from a study to create a final readable tidy 
#           dataset.

library(dplyr)


######################
## STEP 01 ::>> Merges the training and the test sets to create one data set
######################

# Combine X_train and X_test
  x_train <-read.table("./UCI HAR Dataset/train/X_train.txt")
  x_test <-read.table("./UCI HAR Dataset/test/X_test.txt")
  x <- rbind(x_train,x_test)
  
    features <-read.table("./UCI HAR Dataset/features.txt")
    colnames(x) <- features[,2]
    #head(x)
    
  
    

# Combine Y_train and Y_test
  y_train <-read.table("./UCI HAR Dataset/train/y_train.txt")
  y_test <-read.table("./UCI HAR Dataset/test/y_test.txt")
  y <- rbind(y_train,y_test)
  colnames(y) <- c("Activity")
    #head(y)
    
  
  subject_train <-read.table("./UCI HAR Dataset/train/subject_train.txt")
  subject_test <-read.table("./UCI HAR Dataset/test/subject_test.txt")
  subject <- rbind(subject_train,subject_test)
    #head(subject)
  
  colnames(subject) <- c("Subject")
  
  activity_labels <-read.table("./UCI HAR Dataset/activity_labels.txt")
  
  
  combine_all <- cbind(subject,y,x)

  ######################
  ## STEP 02 ::>>  Extract measurements only with means and std dev.
  ## Assuming this doesn't include meanfreq
  ######################
  
  
  tidy_var<- features[grep("mean\\(|std\\(",features[,2]),1]
  x_tidy <- x[,tidy_var]  
  
  combine_tidy <- cbind(subject,y,x_tidy)
  
  #head(combine_tidy)
  
  
  ######################
  ## STEP 03 ::>>  Uses descriptive activity names to name the activities in the data set
  ######################
  
  ## Since codes are matching the row numbers, we can just use them as selected rows.
  
  combine_all[,2] <- activity_labels[combine_all[,2],2] 
  combine_tidy[,2] <- activity_labels[combine_tidy[,2],2] 
    #head(combine_all)
    #head(combine_tidy)
  
  
  ######################
  ## STEP 04 ::>>  Uses descriptive activity names to name the activities in the data set
  ######################
  
  cleannames <- function (ds,old,new)
    {
    return (gsub(old,new, colnames(ds)))
  }

  
 # colnames(combine_tidy) <-gsub("Acc","Accelerometer", colnames(combine_tidy))
  colnames(combine_tidy) <- cleannames (combine_tidy,"Acc","Accelerometer")
  colnames(combine_tidy) <- cleannames (combine_tidy,"Gyro","Gyroscope")
  colnames(combine_tidy) <- cleannames (combine_tidy,"mean()","Mean-Value")
  colnames(combine_tidy) <- cleannames (combine_tidy,"Mag","Magnitude")
  colnames(combine_tidy) <- cleannames (combine_tidy,"^f","FFT")
  colnames(combine_tidy) <- cleannames (combine_tidy,"^t","Time")
  colnames(combine_tidy) <- cleannames (combine_tidy,"std()","Standard-deviation")
  colnames(combine_tidy) <- cleannames (combine_tidy,"\\(\\)","")
  
  #head(combine_tidy)

  Avgdata <- combine_tidy %>%group_by(Subject, Activity) %>%summarise_all(funs(mean))
  #Not sure SUbject,Activity or Activity,Subject?
  
  
  
  
  #colnames(Avgdata)

  #head(Avgdata)
  write.table(Avgdata, "Avgdata.txt", row.name=FALSE)



