
#  First approach - QUESTION1

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


# Second Approach - QUESTION 2
TidyCompleteTable <- select(completeTable, -subject,-activity)





tableFeatures <- fread(file.path(chemin, "features.txt"))
setnames(tableFeatures, c("rang", "Nom"))
setnames(TidyCompleteTable,tableFeatures$Nom)
difference <- tableFeatures[grepl("mean\\(\\)|std\\(\\)",Nom)]

MeanStandardDEVIATION <- TidyCompleteTable[,difference$Nom,with=FALSE]


# THIRD approach  - QUESTION3 dataset of activity

tableActivityLabel <- fread(file.path(chemin, "activity_labels.txt"))
setnames(tableActivityLabel, c("activity", "Nom"))

# 4th TIDY DATASET APPROPRIATLY NAMED

## we will try first to split the table 
## Part1 is already named
Part1 <- select(complete1Table, activity:subject)

##Part2 will now be named through another dataset
Part2 <- select(complete1Table,-(activity:subject))
Part2 <- setnames(Part2,tableFeatures$Nom)

## We will now simply merge the two part for the requested result
completeTidyTABLE <- cbind(Part1,Part2)