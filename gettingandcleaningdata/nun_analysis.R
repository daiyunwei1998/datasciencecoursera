# Notify users file location
working_directory <- getwd()
download_directory <- file.path(working_directory,"data")
setwd(download_directory)
print(paste("your file will be download to",download_directory))

#create the folder automatically(if it does not exist)
if(!dir.exists(download_directory)){dir.create(download_directory)}

#downlaod data set and uzip
download.file(
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
destfile = paste0(download_directory,"/data.zip"),method = "curl")
unzip("data.zip")

featurenames <- read.table(file.path(download_directory,"UCI HAR Dataset","features.txt"),
                           stringsAsFactors = FALSE)[,2]
activity <- read.table(file.path(download_directory,"UCI HAR Dataset","activity_labels.txt"),
                             stringsAsFactors = FALSE)
activitylabels <- activity[,2]
activitylevels <- activity[,1]

xtest <- read.table(file.path(download_directory,"UCI HAR Dataset","test","X_test.txt"))
names(xtest) <-featurenames
y <- scan(file.path(download_directory,"UCI HAR Dataset","test","y_test.txt"),sep = " ")
subject <- scan(file.path(download_directory,"UCI HAR Dataset","test","subject_test.txt"))
datatest <- cbind(subject,xtest[,grepl("mean|std",featurenames)],y)
datatest$type <- "test"
datatest$y <-factor(datatest$y,levels = activitylevels,labels = activitylabels)
 
xtrain <- read.table(file.path(download_directory,"UCI HAR Dataset","train","X_train.txt"))
names(xtrain) <-featurenames
y <- scan(file.path(download_directory,"UCI HAR Dataset","train","y_train.txt"),sep = " ")
subject <- scan(file.path(download_directory,"UCI HAR Dataset","train","subject_train.txt"))
datatrain <- cbind(subject,xtrain[,grepl("mean|std",featurenames)],y)
datatrain$type <- "train"
datatrain$y <-factor(datatrain$y,levels = activitylevels,labels = activitylabels)

data <-rbind(datatest,datatrain)

library(dplyr)
summarydf <- data %>%
                group_by(data$subject,data$y) %>%
                summarize_all("mean")
summarydf$type <- NULL
summarydf$y <- NULL
summarydf$subject <- NULL
summarydf <-rename(summarydf,subject = "data$subject")
summarydf <-rename(summarydf,activity = "data$y")
write.table(summarydf, "output.txt",row.name=FALSE)