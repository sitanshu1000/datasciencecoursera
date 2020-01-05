print('Hello World')
print('Trying to hide my personal Email')

x <- 1
print(x)
y <-2
msg <- "hello"
z <- x+y
z 
z<-1:64
z
## I am having so much fun

x <- matrix(1:6,2,3)
x
x<-4
class(x)
x<- c(4,TRUE)
x
class(x)
x<-c(1,3,5)
y<-c(3,2,10)
cbind(x,y)

x <- list(2, "a", "b", TRUE)
x
x[[1]]
class(x[[1]])
c(TRUE,x[[1]])

x <- c(17, 14, 4, 5, 13, 12, 10)
x[x>10] <- 4
x

x<-1:4
y<-2:3
x+y
class(x+y)

read.table("hw1_data")
getwd()
ls()
data <- read_csv("hw1_data_copy.csv")
data
data[152:153,]
data[47,1]
is.na(data$Ozone)

summary.data.frame(data)

Ozone <- na.omit(data$Ozone)
as.numeric(Ozone)
mean(Ozone)

data.subO <- data[data$Ozone > 31, , drop = FALSE]
data.subTO <- data.subO[data.subO$Temp > 90, , drop = FALSE]
data.subTOO <- na.omit(data.subTO)
mean(data.subTOO$Solar.R)

data.sub1 <- data[data$Month==6, , drop = FALSE]
mean(data.sub1$Temp)

data.sub2 <- data[data$Month==5, , drop = FALSE]
data.sub2 <- na.omit(data.sub2)
data.sub2
max(data.sub2$Ozone)

