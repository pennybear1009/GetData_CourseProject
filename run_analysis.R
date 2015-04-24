#load files into R
f <- read.table("features.txt")
a <- read.table("activity_labels.txt")
xtest <- read.table("test/x_test.txt")
ytest <- read.table("test/y_test.txt")
subtest <- read.table("test/subject_test.txt")
xtrain <- read.table("train/x_train.txt")
ytrain <- read.table("train/y_train.txt")
subtrain <- read.table("train/subject_train.txt")
#create a data frame and merge test and train x data
df <- xtest
df <- rbind(df,xtrain)
#change column names into features
names(df) <- f[,2] 
#merge other data and add them to the main data frame
subject <- subtest
subject <- rbind(subject,subtrain)
y <- ytest
y <- rbind(ytest,ytrain)
df <- cbind(df,subject,y) 
names(df)[[562]]<- c("subject")
names(df)[[563]]<- c("activity")  ## dataset merged, step 1 completed.

#select mean and standard deviation measurements
ms <- grep("mean|std",names(df))
msdf <- df[,ms]    
msdf <- cbind(msdf,subject,y)
names(msdf)[[80]]<- c("subject")
names(msdf)[[81]]<- c("activity")## mean and std extracted, step 2 completed.

#replace activity number with descriptive activity name
msdf$activity[grep("1",msdf$activity)]<-c("WALKING")  # or msdf$activity <- sub("1","WALKING",msdf$activity,)
msdf$activity[grep("2",msdf$activity)]<-c("WALKING_UPSTAIRS")
msdf$activity[grep("3",msdf$activity)]<-c("WALKING_DOWNSTAIRS")
msdf$activity[grep("4",msdf$activity)]<-c("SITTING")
msdf$activity[grep("5",msdf$activity)]<-c("STANDING")
msdf$activity[grep("6",msdf$activity)]<-c("LAYING")## descriptive name changed.step 3 completed.

#label data with descriptive variable names
#deal with "-" and change the word order
splitname1 <- strsplit(names(msdf),"\\-")
reorder1 <- function(x){paste(x[2],x[1],x[3])}
newname1 <- sapply(splitname1,reorder1)
splitname2 <- strsplit(newname1,"\\() ")
#deal with "()"
reorder2 <- function(x){paste(x[1],x[2])}
newname2 <- sapply(splitname2,reorder2)
newname2 <- gsub("NA","",newname2)
#deal with short items
newname3 <- gsub(" ","",newname2)
newname3 <- gsub("Acc","Acceleration",newname3)
newname3 <- gsub("Gyr","Gyroscope",newname3)
newname3 <- gsub("Mag","Magnitude",newname3)
#assign to colnames
names(msdf)<-newname3
names(msdf)[[80]]<- c("subject")
names(msdf)[[81]]<- c("activity") ## step 4 completed.

#get another tidy dataset 
library(dplyr)
tidydata <- msdf %>% group_by(subject,activity) %>% summarise_each(funs(mean)) ## step 5 completed.

        
        
        