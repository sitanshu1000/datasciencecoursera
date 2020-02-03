getwd()
baseDir <- "~\Users\C146846\Documents\data"
setwd(baseDir)

dataSrc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- "data"
zipFile <- "Dataset.zip"

if (!file.exists(dataDir)) {
  dir.create(dataDir)
}
setwd(dataDir)
download.file(dataSrc, destfile = zipFile, method = "curl")
date()

list.files(pattern = zipFile)
unzip(zipFile)
dataBaseDir <- "UCI HAR Dataset"

setwd(baseDir)
getwd()

testDataDir <- paste(dataDir, "/", dataBaseDir, "/test", sep = "")
trainingDataDir <- paste(dataDir, "/", dataBaseDir, "/train", sep = "")

colNamesRaw <- read.table(paste(dataBaseDir, "/features.txt", sep = ""))
dim(colNamesRaw)
colNames <- t(colNamesRaw[-1])

train1 <- read.table(paste("UCI HAR Dataset/train", "/", "X_train.txt", sep = ""))
dim(train1)

train1subject <- read.table(paste("UCI HAR Dataset/train", "/", "subject_train.txt", sep = ""))
dim(train1subject)

train1activity <- read.table(paste("UCI HAR Dataset/train", "/", "y_train.txt", sep = ""))
dim(train1activity)

train <- cbind(train1, train1subject, train1activity)
dim(train)

test1 <- read.table(paste("UCI HAR Dataset/test", "/", "X_test.txt", sep = ""))
dim(test1)

test1subject <- read.table(paste("UCI HAR Dataset/test", "/", "subject_test.txt", sep = ""))
dim(test1subject)

test1activity <- read.table(paste("UCI HAR Dataset/test", "/", "y_test.txt", sep = ""))
dim(test1activity)

test <- cbind(test1, test1subject, test1activity)
dim(test)

data <- rbind(train, test)
dim(data)



# Extraction

usedCols <- colNamesRaw[which(grepl(pattern = "std\\(\\)|mean\\(\\)", x = colNamesRaw[, 2])), ]
dim(usedCols)

data2 <- data[, c(usedCols[, 1], 562, 563)]
dim(data2)

activityLabels <- read.table(paste(dataBaseDir, "/activity_labels.txt", sep = ""), col.names = c("id", "activity.label"))
activityLabels

colnames(data2) <- t(usedCols[, 2])
names(data2)[67] <- "subject.id"
names(data2)[68] <- "activity.id"
data3 <- merge(data2, activityLabels, by.x = "activity.id", by.y = "id")
table(data3[, c("activity.id", "activity.label")])

# just checking:
str(data3)
names(data3)[2:67]

# Chk
head(aggregate(data3[, 2:4], by = list(data3$subject.id, data3$activity.label), FUN = mean))
tail(aggregate(data3[, 2:4], by = list(data3$subject.id, data3$activity.label), FUN = mean))

tidyData <- aggregate(data3[, 2:67], by = list(data3$subject.id, data3$activity.label), FUN = mean)


names(tidyData)[1] <- "subject"
names(tidyData)[2] <- "activity"


# Export

RESULT <- "tidydata.txt"
getwd()
write.table(tidyData, file = RESULT, row.names = TRUE)
list.files()
dim(tidyData)
View(read.table(RESULT, header = TRUE))
