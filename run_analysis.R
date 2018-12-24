
##Question 1
## File unzip will be done mannually 
## Unzip file in our R Working Directory

##The file is unziped directly in the folder "UCI HAR Dataset"


# We will create a path to to have the possibility to read them all

chemin <- file.path(getwd(),"UCI HAR Dataset")
library(data.table)
library(dplyr)

way <- function(rep,fil)
{
  file.path(chemin,rep,fil)
}

tableSubjectTrain <- fread(way("train", "subject_train.txt"))
tableTrainY <- fread(way("train", "y_train.txt"))
tableTrainX <- data.table (read.table(way("train", "X_train.txt")))


tableSubjectTest <- fread(way("test", "subject_test.txt"))
tableTestY <- fread(way("test", "y_test.txt"))
tableTestX <- data.table (read.table(way("test", "X_test.txt")))

subjectTable <- rbind(tableSubjectTrain,tableSubjectTest)
yTable <- rbind(tableTrainY,tableTestY)
xTable <- rbind(tableTrainX,tableTestX)


completeTable <- cbind (cbind(subjectTable,yTable),xTable)
names(completeTable)[1] <- "subject"
names(completeTable)[2] <- "activity"


##The generate table Name is completeTable
##The table conains 2 variables more than the base.. The two variable are renamed in the last part
## column "subject" and column "activity"


##Question2
## Reading  Features files 
## Will permit to rename the variables

tableFeatures <- fread(file.path(chemin, "features.txt"))
setnames(tableFeatures, c("rang", "Nom"))

NamedFeatures <- c("subject", "activity",as.character(tableFeatures$Nom))
setnames(completeTable,NamedFeatures)

NamedFeatures1 <- c("subject", "activity",as.character(tableFeatures$Nom[grep("mean\\(\\)|std\\(\\)", tableFeatures$Nom)]))
MeanStandardDEVIATION <- completeTable[,NamedFeatures1,with=FALSE]


##Question3
## Reading  activity_labels files 
## Will permit to replace activity column by a real description

tableActivityLabel <- fread(file.path(chemin, "activity_labels.txt"))
setnames(tableActivityLabel, c("activity", "Nom"))

MeanStandardDEVIATION$activity <- tableActivityLabel[MeanStandardDEVIATION$activity,2]

##Question4
## In the way to clear the dataset incoherent name

names(MeanStandardDEVIATION)<-gsub("Acc", "accelerometer", names(MeanStandardDEVIATION))
names(MeanStandardDEVIATION)<-gsub("Gyro", "gyroscope", names(MeanStandardDEVIATION))
names(MeanStandardDEVIATION)<-gsub("BodyBody", "body", names(MeanStandardDEVIATION))
names(MeanStandardDEVIATION)<-gsub("Mag", "magnitude", names(MeanStandardDEVIATION))
names(MeanStandardDEVIATION)<-gsub("^t", "time", names(MeanStandardDEVIATION))
names(MeanStandardDEVIATION)<-gsub("^f", "frequency", names(MeanStandardDEVIATION))
names(MeanStandardDEVIATION)<-gsub("tBody", "timeBody", names(MeanStandardDEVIATION))
names(MeanStandardDEVIATION)<-gsub("-mean()", "mean", names(MeanStandardDEVIATION), ignore.case = TRUE)
names(MeanStandardDEVIATION)<-gsub("-std()", "std", names(MeanStandardDEVIATION), ignore.case = TRUE)
names(MeanStandardDEVIATION)<-gsub("-freq()", "frequency2", names(MeanStandardDEVIATION), ignore.case = TRUE)


##Question5
## Creates a second,independent tidy data set and ouput it

IndTidyData<- MeanStandardDEVIATION %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

write.table(IndTidyData, file = "tidydata.txt")

