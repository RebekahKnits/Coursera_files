# filename: run_analysis.R
library(tidyverse)
library(plyr); library(dplyr)

#Extract the data

activity_l <- read.table("data/UCI HAR Dataset/activity_labels.txt", colClasses = "character") # chart linking activities to code 1:6
features <- read.table("data/UCI HAR Dataset/features.txt", colClasses = "character") # list that lables all the "features" being classified

test_X <- read.table("data/UCI HAR Dataset/test/X_test.txt", colClasses = "character") # list of data for each activity/subject pair
test_Y <- read.table("data/UCI HAR Dataset/test/y_test.txt", colClasses = "character") # identification of activity encoded (1:6)
test_sub <- read.table("data/UCI HAR Dataset/test/subject_test.txt", colClasses = "character") # identification of subjected 1:30

train_X <- read.table("data/UCI HAR Dataset/train/X_train.txt", colClasses = "character")
train_Y <- read.table("data/UCI HAR Dataset/train/y_train.txt", colClasses = "character")
train_sub <- read.table("data/UCI HAR Dataset/train/subject_train.txt", colClasses = "character")

# Transform the data

# 1.  merge the training and test sets to create one data set
X_data  <- rbind(test_X, train_X) 
Y_data  <- rbind(test_Y, train_Y)
sub_data <- rbind(test_sub, train_sub)


# 2. Extract only the measurements on the mean and standard deviation for each measurement

mean_std_features_indexes <- grep("mean\\(\\)-[XYZ]$|std\\(\\)-[XYZ]$", features$V2) # identifies column names that might have mean() or std() 
X_data <- X_data[, mean_std_features_indexes] # selecting just the columns indexed from the X data

# 3. use descriptive activity names to name the activities in the data set
colnames(Y_data) <- "act_code"
colnames(activity_l) <- c("act_code", "activity")
Y_data_act = merge(Y_data, activity_l, by ="act_code")
Y_data_act = select(Y_data_act, activity) # reducing down to just the word

# 4. appropriately label the data sets with descriptive variable names
features$V2 <- gsub("^t", "Time_", features$V2)
features$V2 <- gsub("^f", "Frequency_", features$V2)
features$V2 <- gsub("\\(\\)", "", features$V2)

colnames(X_data) <- features[mean_std_features_indexes, "V2"]

colnames(sub_data) <- "subjectID"

full_data  <- cbind(X_data, Y_data_act, sub_data) # would bind the column of activities and subjects with those of the data

# 5. from the data set above, create a second, independent tidy data set with average of each variable for each activity and each subject

DF <- full_data  %>% 
  mutate_at(vars(-activity, -subjectID), as.numeric) %>%
  group_by(activity, subjectID) %>%
  summarize_all(mean)  
write.csv(DF, "full_data.csv")
                                                                                                                                                  