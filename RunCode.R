# set path to data
pathToData="UCI HAR Dataset"

# read data
activity_labels<-read.table(file.path(pathToData,"activity_labels.txt"),header=FALSE)
features<-read.table(file.path(pathToData,"features.txt"),header=FALSE)

X_train<-read.table(file.path(pathToData,"train","X_train.txt"),header=FALSE)
y_train<-read.table(file.path(pathToData,"train","y_train.txt"),header=FALSE)

X_test<-read.table(file.path(pathToData,"test","X_test.txt"),header=FALSE)
y_test<-read.table(file.path(pathToData,"test","y_test.txt"),header=FALSE)

subject_train<-read.table(file.path(pathToData,"train","subject_train.txt"),header=FALSE)
subject_test<-read.table(file.path(pathToData,"test","subject_test.txt"),header=FALSE)

# merge

X=rbind(X_train,X_test)
y=rbind(y_train,y_test)

subject<-rbind(subject_train,subject_test)

colnames(X)<-features$V2
colnames(y)<-c("Activity")
colnames(subject)<-c("Subject")

all_data<-cbind(subject,cbind(X,y))

# extract mean/std

subFeatures<-features$V2[grep("-mean\\(\\)|-std\\(\\)", features$V2)]

names<-c("Subject",as.character(subFeatures),"Activity")

sel_data<-subset(all_data,select=names)

# describe

sel_data$Activity <- factor(sel_data$Activity, labels = activity_labels$V2)
 
#label
names(sel_data)<-gsub("Acc", "Accelerometer", names(sel_data))
names(sel_data)<-gsub("BodyBody", "Body", names(sel_data))
names(sel_data)<-gsub("Gyro", "Gyroscope", names(sel_data))
names(sel_data)<-gsub("Mag", "Magnitude", names(sel_data))
names(sel_data)<-gsub("^t", "time", names(sel_data))
names(sel_data)<-gsub("^f", "frequency", names(sel_data))

# summarize
library(dplyr)
sum_data<-aggregate(. ~Subject + Activity, sel_data, mean)
sum_data<-sum_data[order(sum_data$Subject,sum_data$Activity),]

