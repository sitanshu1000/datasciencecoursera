dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")

list.files("diet_data")

andy <- read.csv('diet_data/Andy.csv')

length(andy$Day)
dim(andy)
str(andy)
summary(andy)
names(andy)

andy[1,"Weight"]
andy[30,"Weight"]
andy[which(andy[,"Day"]==30), "Weight"]
subset(andy$Weight, andy$Day==30)

andy_start <- subset(andy$Weight, andy$Day==1)
andy_end <- subset(andy$Weight, andy$Day==30)
andy_loss <- andy_end - andy_start

files <- list.files('diet_data/')
files[1]
head(read.csv(files[3]))
files_full <- list.files('diet_data/', full.names=TRUE)
files_full
head(read.csv(files_full[3]))

andy_david <- rbind(andy, read.csv(files_full[2]))
andy_david
day_25 <- subset(andy_david, andy_david$Day == 25)
day_25

for(i in 1:5)
  print(i)

dat <- data.frame()
for(i in 1:5)
  dat <- rbind(dat, read.csv(files_full[i]))
str(dat)

summary(dat)
median(dat$Weight, na.rm = TRUE)

dat_30 <- subset(dat, dat$Day==30)
median(dat_30$Weight)

weightmean <- function(directory, day)
{
  dir_items <- list.files(directory, full.names=TRUE)
  
  coll_dat <- data.frame()
  for(i in 1:5)
    coll_dat <- rbind(coll_dat,read.csv(dir_items[i]))
  str(coll_dat)
  dat_subset <- subset(coll_dat, coll_dat$Day == day)
  median(dat_subset$Weight, na.rm=TRUE)
  
}

weightmean('diet_data', 16)

