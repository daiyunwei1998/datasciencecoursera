#Coursework project by daiyunwei1998@qq.com
#Coursera, Getting and cleanning data

#Step1: download files into workingdirectory/data
note that this folder is automatically created

#step2:loading feature names, activity levels and corresponding labels

#step3: handling traning set
3.0 loading data of training set into two variable, xtest and y
3.1 using feature names loaded to rename variable names in xtest, to make
variable name understandable
3.2 loading subject id into varible Subject
3.3 subsetting dataset to those with "mean" or "std"
3.4 adding a column denoting that these records are from the training subsetting
3.5 label y with avtivity, using activity labels and levels loded previously in step 3.0

#step4 handling test set
(similar steps with sep3, except for keyword change from "train" to "test")

#step5 bind two dataset together using rbind()

#step6 group dataset by subject id and activity, then summarize usign mean function

the following three lines drop three columns, for it is useless for now
summarydf$type <- NULL
summarydf$y <- NULL
summarydf$subject <- NULL

the following two lines renaming variables to be descriptive
summarydf <-rename(summarydf,subject = "data$subject")
summarydf <-rename(summarydf,activity = "data$y"

#step7 write the new data set into txt files 
