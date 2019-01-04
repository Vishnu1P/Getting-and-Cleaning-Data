##################################################################################
# Script - run_analysis.R
# Purpose - Get and clean data sets from a study to create a final readable tidy 
#           dataset.
# Final dataset - Avgdata.txt
##################################################################################



Below are the summaries of tranformations/joins completed for the final data set.

#### Install and load this package for summarizing at the end.
 library(dplyr)

#### Import datasets from file.
#### Combine (rbind) all the corresponding test and train files)
#### Import column names (from features) so that we can filter mean/std dev columns.
#### Import Activity labels for mapping them to code in Y.
#### Rename y dataset column to "Activity" and subject column to "Subject"
#### Combine all x,y,subject datasets. 
    
#### Extract only mean/std dev columns from x and repeat combing x_tidy,y,subject.
  
   
#### Map the activity code to description from combine_tidy to 
#### activity_labels since codes are matching the row numbers, we can just use them as selected rows.
  
#### Uses descriptive activity names to name the activities in the data set
#### Create a function cleannames to substitute the dewcription of columns

#### Use summarize_all and group_by to group and summarize and create Avgdata.  
  
 Variables - 

Subject (raw : from Subject_train + Subject_test datasets) - Refers to the volunteer. Used as number codes from 1 - end.
Activity (from y_train + y_test datasets) - Character describes the activity while the device is calculating the measurements.

Below variables all are from ( x_test,x_train datasets). Just the names changed.

Columns containing the the follwing words were changed from raw datasets ---

^Time[^t originally] 
^FFT[^f originally] 
Accelerometer [Acc originally] 
Gyroscope [Gyro originally]
Magnitute [Mag originally]
MeanValue - [mean() originally]
Standard Deviation - [std() originally]


