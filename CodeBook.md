Codebook

Code book that describes the variables, the data and any transformations or work that you performed to clean up the data called
Data Set Information

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
Files & Variables

The dataset includes the following files:

    'README.txt'
    'features_info.txt': Shows information about the variables used on the feature vector.
    'features.txt': List of all features.
    'activity_labels.txt': Links the class labels with their activity name.
    'train/X_train.txt': Training set.
    'train/y_train.txt': Training labels.
    'test/X_test.txt': Test set.
    'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

    'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
    'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
    'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

For each record it is provided:

    Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    Triaxial Angular velocity from the gyroscope.
    A 561-feature vector with time and frequency domain variables.
    Its activity label.
    An identifier of the subject who carried out the experiment.


Transformations

The run_analysis.R script performs the following actions and transformations to the dataset to create the tidy summarized data file summaryData.txt.

    Download the Zipped file to "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    Unpack the Zipped file to our working directory
    The necessaries files to create our dataset are in train directory and in test directory 
     extract the data set from text files :

    FROM train repository
    tableSubjectTrain created from subject_train.txt
    tableTrainY	created from y_train.txt
    tableTrainX	created from X_train.txt

    FROM test repository
    tableSubjectTest created from subject_test.txt
    tableTestY created from y_test.txt
    tableTestX created from X_test.txt"

    1) Binding by row 
	tableSubjectTrain and tableSubjectTest  for subjectTable
	tableTrainY and tableTestY for yTable
	tableTrainX and tableTestX for xTable
    2) Binding by column
	(subjectTable and yTable) and xTable to build "completeTable"
    The first two variables of "completeTable"will be named "subject" and "activity"

 FILTERING THE OBTAINED DATASET
   From the "completeTable" we will need only column name containing "mean" or "std"
   the resulting table "MeanStandardDEVIATION", not so tidy (missing columns name)

SET COLUMNAMES FOR THE REST OF THE DATASET  
   From the parent directory "UCI HAR Dataset", the file "features.txt" contains the features (names) of each colum of the new dataset
   "NamedFeatures"
   We can now use SETNAMES function to rename the last colums of our dataset. The result is still "MeanStandardDEVIATION" in a way to be tidy. 

LABELING THE VARIABLE ACTIVITY # Question 3
   From the parent directory "UCI HAR Dataset", the file "activity_labels.txt" contains the label, categories of each number on the column "activity".
   File  "activity_labels.txt" will form the new dataset "tableActivityLabel".

RENAMING OUR TABLE VARIABLE # Question 4
    In the way to clear the dataset incoherent name...we are renaming columns names by the meaning of each abbreviations.
    No change on the datas.
    
PUBLISHING THE TIDY DATASET
    Group the data in "IndTidyData" by subject and activity with the average of each variables for the grouped values.
    The result is write in the file output called "tidydata.txt".

