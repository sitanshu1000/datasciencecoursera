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

weightmedian <- function(directory, day)
{
  dir_items <- list.files(directory, full.names=TRUE)
  
  coll_dat <- data.frame()
  for(i in 1:length(dir_items))
    coll_dat <- rbind(coll_dat,read.csv(dir_items[i]))
  str(coll_dat)
  dat_subset <- subset(coll_dat, coll_dat$Day == day)
  median(dat_subset$Weight, na.rm=TRUE)
  
}
weightmedian('diet_data', 16)

str(lapply(files_full, read.csv))

wt_mean <- function(directory, type, id)
{  

  files_full <- list.files(directory, full.names=TRUE)
  tmp <- vector(mode = "list", length = length(files_full))
  summary(tmp)
  
  for (i in seq_along(files_full)) {
    tmp[[i]] <- read.csv(files_full[[i]])
  }
  
  output <- do.call(rbind, tmp)
  str(output)
  output_subset = subset(output, output$ID %in% id)
  if(type == 'sulfate') {
    mean(output_subset$sulfate, na.rm=TRUE)
  } else if(type == 'nitrate'){
    mean(output_subset$nitrate, na.rm=TRUE)
  }
}

wt_mean('specdata','nitrate', 1:10)