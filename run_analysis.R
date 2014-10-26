##This function merges training and test data for samsung smartphone data and summarizes
##standard deviation and mean for all the features by each activity and each subject.
##For detailed comments read README.md
run_analysis <- function() {
    directory <- getwd()
    
    ##read column names from features
    colNames <- read.table("features.txt")[[2]]
    
    ##Merge training and test data
    mergedFeatures <- mergeTrainingAndTestData(directory, "X", colNames)
    
    ##filter unnecessary columns
    shouldIncludeCols <- grepl("-mean\\(\\)|\\-std\\(\\)", colNames)
    colsRemovedCount <- 0
    for(i in seq_along(shouldIncludeCols)){
        if(!shouldIncludeCols[i]) {
            mergedFeatures[,(i-colsRemovedCount)] <- NULL
            colsRemovedCount <- colsRemovedCount + 1
        }
    }
    
    ##merge training and test activity labels
    mergedActivity <- mergeTrainingAndTestData(directory, "y", c("activity"))
    
    ##replace activity label by their equivalent descriptive name
    activityNames <- read.table("activity_labels.txt", colClasses = "character")[[2]]
    for(i in seq_along(activityNames)) {
        mergedActivity$activity[mergedActivity$activity == i] <- activityNames[i]
    }
    
    ##merge training and test activity labels
    mergedSubject <- mergeTrainingAndTestData(directory, "subject", c("subject"))
    
    ##append activity and subjects with data
    tidyData <- cbind(cbind(mergedActivity, mergedSubject), mergedFeatures)
    
    ##summarize data of each variable by activity and subject, this is
    ##done by using melt function from reshape library
    library(reshape)
    moltenData <- melt(tidyData, id=c("activity", "subject"))
    summarizedTidyData <- cast(moltenData, activity + subject ~ variable, mean)
    write.table(summarizedTidyData, "summarized_tidy_data.txt", row.names=FALSE)
}

##Reads training and test data and merges and returns the combined data
##given the location of top level directory and the prefix of the file name.
##It assigns the column names as per the passed in value.
##It assumes the existence of test and training data under test and train
##folder respectively.
mergeTrainingAndTestData <- function(directory, filePrefix, colNames) {
    trainingFile <- sprintf("%s/train/%s_train.txt", directory, filePrefix)
    testFile <- sprintf("%s/test/%s_test.txt", directory, filePrefix)
    training <- read.table(trainingFile)
    test <- read.table(testFile)
    combinedData <- rbind(training, test)
    colnames(combinedData) <- colNames
    combinedData
}
