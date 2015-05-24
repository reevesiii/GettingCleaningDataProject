# getwd()
setwd("C:/Users/Administrator/Documents/RStudio/Projects")

library(plyr)
library(dplyr)

activityCodes <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ", col.names= c("ActivityCode", "ActivityName"), stringsAsFactors=FALSE)
# names(activityCodes)  <- c("ActivityCode", "ActivityName")

featureCodes <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ", col.names = c("FeatureCode", "FeatureName"), stringsAsFactors=FALSE)
# names(featureCodes) <- c("FeatureCode", "FeatureName")

# Load Data

testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", col.names = c("SubjectCode"), stringsAsFactors=FALSE)
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", col.names = c("SubjectCode"), stringsAsFactors=FALSE)

testReadingRaw <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
testReading <- testReadingRaw[,1:6]

# Remove/Delete Raw dataset because of space
rm(testReadingRaw)

# Appropriately labels the data set with descriptive variable names for feature codes 
names(testReading) <- featureCodes[1:6,2]

trainReadingRaw <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
trainReading <- trainReadingRaw[,1:6]

# Remove/Delete Raw dataset because of space
rm(trainReadingRaw)

# Appropriately labels the data set with descriptive variable names for feature codes 
names(trainReading) <- featureCodes[1:6,2]

testActivityRaw <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", col.names = c("ActivityCode"), stringsAsFactors=FALSE)

# Add descriptive activity names to name the activities in the data set
testActivity <- left_join(testActivityRaw, activityCodes, by = "ActivityCode", stringsAsFactors=FALSE)

# Remove/Delete Raw dataset because of space
rm(testActivityRaw)

trainActivityRaw <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", col.names = c("ActivityCode"), stringsAsFactors=FALSE)

# Add descriptive activity names to name the activities in the data set
trainActivity <- left_join(trainActivityRaw, activityCodes, by = "ActivityCode")

# Remove/Delete Raw dataset because of space
rm(trainActivityRaw)

testCombine <- cbind("DataSet"=c("Test"), testSubject, testActivity, testReading)
trainCombine <- cbind("DataSet"=c("Train"), trainSubject, trainActivity, trainReading)

allDataRaw <- rbind(testCombine, trainCombine)
allDataRaw <- rename(allDataRaw, replace = c("tBodyAcc-mean()-X"="meanX", "tBodyAcc-mean()-Y"="meanY", "tBodyAcc-mean()-Z"="meanZ","tBodyAcc-std()-X"="stdX", "tBodyAcc-std()-Y"="stdY", "tBodyAcc-std()-Z"="stdZ"))

allData <- allDataRaw[,c(2, 4, 5, 6, 7, 8, 9, 10)]

# Remove/Delete datasets because of space
rm(allDataRaw)
rm(testSubject)
rm(trainSubject)
rm(testReading)
rm(trainReading)
rm(testActivity)
rm(trainActivity)
rm(testCombine)
rm(trainCombine)
rm(activityCodes)
rm(featureCodes)

# write out data set
write.table(allData, file = "./UCI HAR Dataset/tidy_data_set_course_project.txt", row.name=FALSE)

allSummary <- allData %>% 
  dplyr::group_by(SubjectCode, ActivityName) %>% 
  dplyr::summarise(average_meanX = mean(meanX), average_meanY = mean(meanY), average_meanZ = mean(meanZ), average_stdX = mean(stdX), average_stdY = mean(stdY), average_stdZ = mean(stdZ))

write.table(allSummary, file = "./UCI HAR Dataset/tidy_data_set_course_project_summary.txt", row.name=FALSE)
