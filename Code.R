TrainingSet <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
TrainingLabels <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
SubjectTrain <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")

TestSet <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
TestLabel <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
SubjectTest <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")

Features <- read.table(file = "UCI HAR Dataset/features.txt")
ActivityLabels <- read.table(file = "UCI HAR Dataset/activity_labels.txt")

df <- rbind(cbind(subject_test, test_set, test_label), cbind(subject_train, training_set, training_labels))
colnames(df[2:562]) <- features[,2]
colnames(df[1]) <- "subject"
colnames(df[563]) <- "activity"

Indices <- grep(pattern = "mean|std", colnames(df))
Newdf <- df[,indices]

Activity <- df[,563]

Labels <- c()
for(i in activity){
  x <- activity_labels[i,2]
  labels <- c(labels, x)
}
Newdf <- cbind(subject = df[1], new_df)
Newdf <- cbind(new_df, activity = activity)
Newdf <- cbind(new_df, activity_labels = labels)

colnames_df <- colnames(new_df)[2:80]
colnames_df <- gsub(pattern = "[()]|[-]", replacement = "", x = colnames_df)
colnames_df <- gsub(pattern = "^f", replacement = "FrequencyDomain", x = colnames_df)
colnames_df <- gsub(pattern = "^t", replacement = "TimeDomain", x = colnames_df)
colnames_df <- gsub(pattern = "mean", replacement = "Mean", x = colnames_df)
colnames_df <- gsub(pattern = "std", replacement = "StandardDeviation", x = colnames_df)
colnames_df <- gsub(pattern = "BodyBody", replacement = "Body", x = colnames_df)
colnames(new_df)[2:80] <- colnames_df

x <- new_df %>% group_by(subject, activity_labels) %>% summarise_each(mean)

write.table(x, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)
