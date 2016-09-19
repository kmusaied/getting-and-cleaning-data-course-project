
#clearing all varibles from the env. 
rm(list=ls(all=TRUE))

#including dplyr libray
library(dplyr)

#reading training data
tx <- read.table("train/X_train.txt")
ty <- read.table("train/y_train.txt")        
train <- cbind(tx,ty)
train[,"DataType"] = "Train"
rm(tx,ty)

#reading test data
tsx <- read.table("test/X_test.txt")
tsy <- read.table("test/y_test.txt")
test <- cbind(tsx,tsy)
test[,"DataType"] = "Test"
rm(tsx,tsy)

#1.Merges the training and the test sets to create one data set.
x <- merge(train,test , all = TRUE)
rm(train,test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
x2 <- x[,c(1,2,3,4,5,6,562,563)]

#3.Uses descriptive activity names to name the activities in the data set
x2$V1.1[x2$V1.1 == "1"] <- "WALKING"
x2$V1.1[x2$V1.1 == "2"] <- "WALKING_UPSTAIRS"
x2$V1.1[x2$V1.1 == "3"] <- "WALKING_DOWNSTAIRS"
x2$V1.1[x2$V1.1 == "4"] <- "SITTING"
x2$V1.1[x2$V1.1 == "5"] <- "STANDING"
x2$V1.1[x2$V1.1 == "6"] <- "LAYING"

#4.Appropriately labels the data set with descriptive variable names.
colnames(x2) <- c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z", "Activity","DataType")

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
x3<- x2 %>%
        group_by(Activity) %>%
        summarise_each(funs(mean(., na.rm=TRUE)),-DataType)