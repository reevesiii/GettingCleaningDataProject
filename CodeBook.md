## Code Book

This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.

The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data:

Load library: plyr and dplyr

* Read the activity codes and feature codes and store them in activityCodes and featureCodes data sets
* Read subject_test.txt from the "./UCI HAR Dataset/test" folder and store them in testSubject data frame
* Read subject_test.txt from the "./UCI HAR Dataset/train" folder and store them in trainSubject data frame
* Read X_test.txt from the "./UCI HAR Dataset/test" folder and store them in testReadingRaw data frame
* Subset testReadingRaw into the first group of means and and standard deviation, could have left the other groups but reduced due to size
* Removed testReadingRaw to save space
* Renamed columns of the dataset based on the featurecodes data frame
* Read X_test.txt from the "./UCI HAR Dataset/train" folder and store them in trainReadingRaw data frame
* Subset trainReadingRaw into the first group of means and and standard deviation, could have left the other groups but reduced due to size
* Removed trainReadingRaw to save space
* Renamed columns of the dataset based on the featurecodes data frame
* Read y_test.txt from the "./UCI HAR Dataset/test" folder and store them in testActivity data frame
* Used left join with activityCodes data frame to get activities names
* Read y_test.txt from the "./UCI HAR Dataset/test" folder and store them in testActivityRaw data frame
* Used left join with activityCodes data frame to get activities names to create testActivity data frame
* Removed testActivityRaw to save space
* Read y_test.txt from the "./UCI HAR Dataset/train" folder and store them in trainActivityRaw data frame
* Used left join with activityCodes data frame to get activities names to create trainActivity data frame
* Removed trainActivityRaw to save space
* Combined testSubject, testActivity, testReading into testCombine data frame
* Combined trainSubject, trainActivity, trainReading into trainCombine data frame
* Combined testCombine and trainCombine into allDataRaw data frame
* Renamed column in allDataRaw to allData data fram
* Write the allData out to "tidy_data_set_course_project.txt" file in current working directory.
* Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, we get a 180x8 data frame.
* Write the result out to "tidy_data_set_course_project_summary.txt " file in current working directory.
