
library(data.table)
library(dplyr)
library(tidyr)

setwd('~/data/UCI HAR Dataset/')


# Function to load a dataset (type must be 'train' or 'test', features are the desciptive column names)

load.data <- function(type, features) {
  data.file <- gsub('type', type, './type/X_type.txt')                   # Create file names for the three files to load per data set
  subjects.file <- gsub('type', type, './type/subject_type.txt')
  activities.file <- gsub('type', type, './type/y_type.txt')
  
  data <- read.table(data.file, col.names=features)                      # Attach descriptive column names (for requirement #4)
  subjects <- read.table(subjects.file, col.names=c('Subject'))          # Load the subject numbers for this data set
  activities <- read.table(activities.file, col.names=c('Activity'))     # Load the associated activities for this data set
  bind_cols(data, subjects, activities)                                  # Combine the columns into a new data frame table
}


# Function to repeatedly find and replace elements from the given character vectors

replace.all <- function(patt, repl, char.vec) {
  for (i in 1:length(patt)) char.vec <- gsub(patt[i], repl[i], char.vec) # match and replace elements at index i in the character vector
  char.vec
}


# Load the feature (i.e. column) names, and the activity names

fnames <- read.csv('./features.txt', sep=' ', header=FALSE, stringsAsFactors=FALSE)$V2
activity.names <- read.table('./activity_labels.txt')$V2


# Create a new dataset that satisfies requirements 1 - 4 of the project

all.data <- bind_rows(load.data('train', fnames), load.data('test', fnames)) %>%   # 1. Merges the training and the test sets to create one data set
  select(contains(".mean.."), contains("std"), Subject, Activity) %>%              # 2. Extracts only the measurements on the mean and standard deviation...
  mutate(Activity=activity.names[Activity])                                        # 3. Uses descriptive Activity names to name the activities in the data set

patt <- c('^t', '^f', '\\.\\.', 'mean', 'std')     # patterns to match
repl <- c('Time.', 'Freq.', '', 'Mean', 'Std')     # replacement strings
names(all.data) <- replace.all(patt, repl, names(all.data))                        # 4. Appropriately labels the data set with descriptive variable names.

names(all.data)    # Outputs the following:

# [1] "Time.BodyAcc.Mean.X"           "Time.BodyAcc.Mean.Y"           "Time.BodyAcc.Mean.Z"           "Time.GravityAcc.Mean.X"        "Time.GravityAcc.Mean.Y"        "Time.GravityAcc.Mean.Z"       
# [7] "Time.BodyAccJerk.Mean.X"       "Time.BodyAccJerk.Mean.Y"       "Time.BodyAccJerk.Mean.Z"       "Time.BodyGyro.Mean.X"          "Time.BodyGyro.Mean.Y"          "Time.BodyGyro.Mean.Z"         
# [13] "Time.BodyGyroJerk.Mean.X"      "Time.BodyGyroJerk.Mean.Y"      "Time.BodyGyroJerk.Mean.Z"      "Time.BodyAccMag.Mean"          "Time.GravityAccMag.Mean"       "Time.BodyAccJerkMag.Mean"     
# [19] "Time.BodyGyroMag.Mean"         "Time.BodyGyroJerkMag.Mean"     "Freq.BodyAcc.Mean.X"           "Freq.BodyAcc.Mean.Y"           "Freq.BodyAcc.Mean.Z"           "Freq.BodyAccJerk.Mean.X"      
# [25] "Freq.BodyAccJerk.Mean.Y"       "Freq.BodyAccJerk.Mean.Z"       "Freq.BodyGyro.Mean.X"          "Freq.BodyGyro.Mean.Y"          "Freq.BodyGyro.Mean.Z"          "Freq.BodyAccMag.Mean"         
# [31] "Freq.BodyBodyAccJerkMag.Mean"  "Freq.BodyBodyGyroMag.Mean"     "Freq.BodyBodyGyroJerkMag.Mean" "Time.BodyAcc.Std.X"            "Time.BodyAcc.Std.Y"            "Time.BodyAcc.Std.Z"           
# [37] "Time.GravityAcc.Std.X"         "Time.GravityAcc.Std.Y"         "Time.GravityAcc.Std.Z"         "Time.BodyAccJerk.Std.X"        "Time.BodyAccJerk.Std.Y"        "Time.BodyAccJerk.Std.Z"       
# [43] "Time.BodyGyro.Std.X"           "Time.BodyGyro.Std.Y"           "Time.BodyGyro.Std.Z"           "Time.BodyGyroJerk.Std.X"       "Time.BodyGyroJerk.Std.Y"       "Time.BodyGyroJerk.Std.Z"      
# [49] "Time.BodyAccMag.Std"           "Time.GravityAccMag.Std"        "Time.BodyAccJerkMag.Std"       "Time.BodyGyroMag.Std"          "Time.BodyGyroJerkMag.Std"      "Freq.BodyAcc.Std.X"           
# [55] "Freq.BodyAcc.Std.Y"            "Freq.BodyAcc.Std.Z"            "Freq.BodyAccJerk.Std.X"        "Freq.BodyAccJerk.Std.Y"        "Freq.BodyAccJerk.Std.Z"        "Freq.BodyGyro.Std.X"          
# [61] "Freq.BodyGyro.Std.Y"           "Freq.BodyGyro.Std.Z"           "Freq.BodyAccMag.Std"           "Freq.BodyBodyAccJerkMag.Std"   "Freq.BodyBodyGyroMag.Std"      "Freq.BodyBodyGyroJerkMag.Std" 
# [67] "Subject"                       "Activity"                     


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each Activity and each Subject.

tidy.data <- all.data %>%
  gather(Variable, Value, -Subject, -Activity) %>%     # Create a narrow data set by separating out each reading into a separate row
  group_by(Subject, Activity, Variable) %>%            # Prepare to create averages for each reading by grouping on Subject number, Activity for each each Variable
  summarise(Average = mean(Value))                     # Add a new column, Average, for each grouping from previous line

head(tidy.data)    # Outputs the following:

# Subject Activity                 Sensor     Average
# 1       1   LAYING    Time.BodyAcc.Mean.X  0.22159824
# 2       1   LAYING    Time.BodyAcc.Mean.Y -0.04051395
# 3       1   LAYING    Time.BodyAcc.Mean.Z -0.11320355
# 4       1   LAYING Time.GravityAcc.Mean.X -0.24888180
# 5       1   LAYING Time.GravityAcc.Mean.Y  0.70554977
# 6       1   LAYING Time.GravityAcc.Mean.Z  0.44581772





