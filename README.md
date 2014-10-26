


**Course project for getting and cleaning** 

Assumptions for script to work
1. The Samsung smartphone data is available in current working directory and it's layout is preserved. i.e common files are under current working directory and its training data is under train folder and test data under test folder respectively.
2. Requires reshape library since it uses melt function to summarize the data.

The script summarizes data for each activity and each subject of Samsung smartphone data by following these steps
1. Read the column names from features.txt
2. Merge features training and test data and bind the column names by using a common merge function. The merge function takes the directory, file prefix and column names, it reads data from training and test folder and uses rbind() to merge the data.
3. Preserve only the columns which as std and mean values, this filtering is done as follows
   a. Create logical vector to identify column names ending with -mean() and -std().
   b. Drop the column as per logical vector created in step 3a. 
4. Merge activity training and test data and bind the column name "activity" by using common merge function.
5. Replace activity labels by descriptive name for merged activity in step 5. In this step label names are read from "activity_labels.txt", then replace the label by their equivalent descriptive name by sub-setting according to label.
6. Merge subject training and test data and bind the column name "subject" by using common merge function.
7. Activity, subject and features data are merged in the mentioned order by using cbind.
8. Now that we have tidy data, it is summarized for each activity and subject. This summary is based on melt function which is available in reshape library.
9. Write the summarized data into a file by name "summarized_tidy_data.txt", note that as per the instruction the row names are omitted.



