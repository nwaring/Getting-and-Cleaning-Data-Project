
# CODE BOOK


## Subject
	Subject identifier
		1..30			Unique identifier of the subject who carried out the experiment


## Activity
	Activity undertaken for sensor readings
		WALKING
		WALKING_UPSTAIRS
		WALKING_DOWNSTAIRS
		SITTING
		STANDING
		LAYING


## Variable
	Variable is derived from sensor signals (see Notes)
		Time.BodyAcc.Mean.X
		Time.BodyAcc.Mean.Y
		Time.BodyAcc.Mean.Z
		Time.GravityAcc.Mean.X
		Time.GravityAcc.Mean.Y
		Time.GravityAcc.Mean.Z
		Time.BodyAccJerk.Mean.X
		Time.BodyAccJerk.Mean.Y
		Time.BodyAccJerk.Mean.Z
		Time.BodyGyro.Mean.X
		Time.BodyGyro.Mean.Y
		Time.BodyGyro.Mean.Z
		Time.BodyGyroJerk.Mean.X
		Time.BodyGyroJerk.Mean.Y
		Time.BodyGyroJerk.Mean.Z
		Time.BodyAccMag.Mean
		Time.GravityAccMag.Mean
		Time.BodyAccJerkMag.Mean
		Time.BodyGyroMag.Mean
		Time.BodyGyroJerkMag.Mean
		Freq.BodyAcc.Mean.X
		Freq.BodyAcc.Mean.Y
		Freq.BodyAcc.Mean.Z
		Freq.BodyAccJerk.Mean.X
		Freq.BodyAccJerk.Mean.Y
		Freq.BodyAccJerk.Mean.Z
		Freq.BodyGyro.Mean.X
		Freq.BodyGyro.Mean.Y
		Freq.BodyGyro.Mean.Z
		Freq.BodyAccMag.Mean
		Freq.BodyBodyAccJerkMag.Mean
		Freq.BodyBodyGyroMag.Mean
		Freq.BodyBodyGyroJerkMag.Mean
		Time.BodyAcc.Std.X
		Time.BodyAcc.Std.Y
		Time.BodyAcc.Std.Z
		Time.GravityAcc.Std.X
		Time.GravityAcc.Std.Y
		Time.GravityAcc.Std.Z
		Time.BodyAccJerk.Std.X
		Time.BodyAccJerk.Std.Y
		Time.BodyAccJerk.Std.Z
		Time.BodyGyro.Std.X
		Time.BodyGyro.Std.Y
		Time.BodyGyro.Std.Z
		Time.BodyGyroJerk.Std.X
		Time.BodyGyroJerk.Std.Y
		Time.BodyGyroJerk.Std.Z
		Time.BodyAccMag.Std
		Time.GravityAccMag.Std
		Time.BodyAccJerkMag.Std
		Time.BodyGyroMag.Std
		Time.BodyGyroJerkMag.Std
		Freq.BodyAcc.Std.X
		Freq.BodyAcc.Std.Y
		Freq.BodyAcc.Std.Z
		Freq.BodyAccJerk.Std.X
		Freq.BodyAccJerk.Std.Y
		Freq.BodyAccJerk.Std.Z
		Freq.BodyGyro.Std.X
		Freq.BodyGyro.Std.Y
		Freq.BodyGyro.Std.Z
		Freq.BodyAccMag.Std
		Freq.BodyBodyAccJerkMag.Std
		Freq.BodyBodyGyroMag.Std
		Freq.BodyBodyGyroJerkMag.Std


## Average
	Sensor readings averaged by Subject, Activity and Variable
		-0.9976661..0.9745087		Average sensor reading value



# NOTES

- Created as part of the project for the Coursera/Johns Hopkins 'Getting and Cleaning Data' MOOC
- Data was derived from the UCI's Machine Learning Repository: 'Human Activity Recognition Using Smartphones Data Set' (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)
- All Variable names are found in the file 'features.text' in the above named repository and are transformed so that those beginning with 'f' appear as 'Freq.' here and those beginning with 't' apprear as 'Time'.  This was done in order to aid clarity.
- The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc.XYZ and tGyro.XYZ. These time domain signals (prefix 'Time.') were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc.XYZ and tGravityAcc.XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
- Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (Time.BodyAccJerk.XYZ and Time.BodyGyroJerk.XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (Time.BodyAccMag, Time.GravityAccMag, Time.BodyAccJerkMag, Time.BodyGyroMag, Time.BodyGyroJerkMag).
- A Fast Fourier Transform (FFT) was applied to some of these signals producing Freq.BodyAcc.XYZ, Freq.BodyAccJerk.XYZ, Freq.BodyGyro.XYZ, Freq.BodyAccJerkMag, Freq.BodyGyroMag, Freq.BodyGyroJerkMag.
- These signals were used to estimate variables of the feature vector for each pattern: 'X', 'Y' and 'Z' are used to denote the 3-axial signals in the X, Y and Z directions, respectively.
- Finally, from the original dataset, only mean (denoted with '.Mean' here) and standard deviation (denoted with '.Std') values where kept, the rest being discarded.




