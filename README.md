# GetData_CourseProject
##Course project submission of getting and cleaning data

*This repo includes three files: 
- run_analysis.R which is an R script producing tidydata submitted in this project;
- code_book.pdf which describes the variables;
- README.md which describes how the R script works;

*About Raw Data
The raw data of this project is from "Human Activity Recognition Using Smartphones Dataset" which has several seperate files stored different records. I picked the following in this project:
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt'and'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

*STEP 1:Merge Training and Test Sets 
- Load all the data mentioned above to R;
- There are 6 files to be merged: x_test, x_train, y_test, y_train, subject_test, subject_train.
- First, create a data frame df with data x_test in it, and add rows of x_train into this data frame.
- Assign features.txt to names of the data frame.
- Then, add column of subject and activity to complete the merge.

*STEP 2:Extract Mean and Standard Deviation Features
- Use grep() to extract mean and std, and subset df by this vectors as msdf.
- Because subject and activity were lost in last step, so re-add them again here.

*STEP 3:Name Activities with Descriptive Name
- Pick up certain number of activity column using grep(), and assign them with descriptive activity name like "WALKING".
- Repeat last step for five time to change all six activities.

*STEP 4:Label the Data Set with Descriptive Variable Names
- Split names with '-' returning a list variable of three items in each list, and reorder the three part in each list, and then paste them together as newname.
- Repeat the last step, this time remove '()' and 'NA'(in last step some lists don't have the third part,so when it comes to run the function of reorder, it produce NA).
- In order to make a descriptive names, spaces need to be removed and abbreviation need to be returned to original work.
- Rename subject and activity seperately.

*STEP 5:Create Another Tidy Dateset
- load dplyr package
- Group by subject and activity, and then summarise the mean of all variables to get 180-row tidy data frame.

