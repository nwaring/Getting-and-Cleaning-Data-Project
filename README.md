

#README

This assignment is based on data from the [Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) from the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html).

To quote the site's abstract: 

>Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The following steps were performed on the original data source (taken from the [Coursera project page](https://class.coursera.org/getdata-031/human_grading/view/courses/975115/assessments/3/submissions)) to produce a [new data set](https://s3.amazonaws.com/coursera-uploads/user-a07d30466c3b025842de7e96/975115/asst-3/cd6f19b049a511e587f73d59c5a829d9.txt):

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Data

(From the [repository site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#):)


###Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset. 

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link]


Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


##Algorithm

The analysis script performs the following task: 

1. Include the required libraries

```
library(data.table)
library(dplyr)
library(tidyr)
```
The actual work of tidying the data relies heavily on the 'dplyr' and 'tidyr' libraries.


2. Set the working directory for all subsequent file reads and writes

```
setwd('~/data/UCI HAR Dataset/')
```
The purpose of this is to reduce the size of subsequent file paths and so enhancing code readability.


3. Define a helper function to read the three associated files for each data set type (train or test) and combine them into a single data frame:

```
load.data <- function(type, features) {
  data.file <- gsub('type', type, './type/X_type.txt')                   # Create file names for the three files to load per data set
  subjects.file <- gsub('type', type, './type/subject_type.txt')
  activities.file <- gsub('type', type, './type/y_type.txt')
  
  data <- read.table(data.file, col.names=features)                      # Attach descriptive column names (for requirement #4)
  subjects <- read.table(subjects.file, col.names=c('Subject'))          # Load the subject numbers for this data set
  activities <- read.table(activities.file, col.names=c('Activity'))     # Load the associated activities for this data set
  bind_cols(data, subjects, activities)                                  # Combine the columns into a new data frame table
}
```
Note that the descriptive column names, 'features' are passed and assigned to the main training/test data file.
I decided to combine these steps into a function because they need to be repeated for the two different data sets (and supporting files) to be loaded.  Hence, code reuse, and not duplicating code were my main motivations.


4. Define a helper function to transform elements of a character vector

```
replace.all <- function(patt, repl, char.vec) {
  for (i in 1:length(patt)) char.vec <- gsub(patt[i], repl[i], char.vec) # Match and replace elements at index i in the character vector
  char.vec
}
```
This is used to 'clean up' the variable names (i.e. column headings) to make them more readable.  It is included purely to make the code more readable by abstracting away this descrete task into its own function.


5. Load the files containing feature names and activity names

```
fnames <- read.csv('./features.txt', sep=' ', header=FALSE, stringsAsFactors=FALSE)$V2    # Feature names
activity.names <- read.table('./activity_labels.txt')$V2                                  # Activity names
```
The former is used in the previously defined function, 'load.data' to set the column headings.
The latter is used in next step to provide descriptive labels to the activity data.


6. Fulfill the first three requirements from the project instructions

```
all.data <- bind_rows(load.data('train', fnames), load.data('test', fnames)) %>%   # "1. Merges the training and the test sets to create one data set"
  select(contains(".mean.."), contains("std"), Subject, Activity) %>%              # "2. Extracts only the measurements on the mean and standard deviation..."
  mutate(Activity=activity.names[Activity])                                        # "3. Uses descriptive Activity names to name the activities in the data set"
```
This section of code performs several steps:
a. The two datasets are loaded using the 'load.data()' function defined above, and combined into a single data frame using 'bind_rows()'.
b. A 'select()' call is used to include only column names that include the required mean and standard deviation values.  Also, the two columns 'Subject' and 'Activity' are preserved too.
c. A call to 'mutate()' overwrites the original 'Activity' numeric value with its descriptive counterpart.
d. These data transformations are finally stored in the variable 'all.data'.


7. Fulfill the fourth requirement from the project instructions

```
patt <- c('^t', '^f', '\\.\\.', 'mean', 'std')     # patterns to match
repl <- c('Time.', 'Freq.', '', 'Mean', 'Std')     # replacement strings
names(all.data) <- replace.all(patt, repl, names(all.data))                        # "4. Appropriately labels the data set with descriptive variable names."
```
As the original feature (i.e. column) names have already been assigned, the only task here is to clean up the names to make them more readable.
Character vectors of search patterns and replacement text are defined and passed to the 'replace.all()' function, along with the existing variable names (i.e. column names) which are in turn replaced by the result of the call.


8. Fulfill the fifth requirement from the project instructions

```
tidy.data <- all.data %>%
  gather(Variable, Value, -Subject, -Activity) %>%     # Create a narrow data set by separating out each reading into a separate row
  group_by(Subject, Activity, Variable) %>%            # Prepare to create averages for each reading by grouping on Subject number, Activity for each each Variable
  summarise(Average = mean(Value))                     # Add a new column, Average, for each grouping from previous line

```
A (narrow) 'tidy' data set is created by separating out each individual reading into its own row, using a call to 'gather()'.  This produces a dataset of the format: 'Subject', 'Activity', 'Sensor' and 'Value', changing the data frame dimensions from 10299 rows of 68 columns, to 679734 rows of 4 columns.  This format then facilities the next stage.
The tidy data set is then passed to 'group_by()' and 'summarise()' to create a new column, Average, that is the mean of all readings grouped by Subject and Activity for each unique Variable.


## Importing The Tidy Data File Into R

The tidy data file was created using the R command:
```
write.table(tidy.data, file = './tidy_data.txt', row.names = FALSE)
```
Similarly, it can be read into R directly from the Coursera site using the following code (taken from [here](https://class.coursera.org/getdata-031/forum/thread?thread_id=113)):
```
address <- "https://s3.amazonaws.com/coursera-uploads/user-a07d30466c3b025842de7e96/975115/asst-3/cd6f19b049a511e587f73d59c5a829d9.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE)
View(data)
```


