## Lesson 7 Discussion ##

# Loads libraries
library(ggplot2)

# Loads dataset
dataset1 <- read.csv("Dataset1_Lesson7.csv")

# Explore dataset
names(dataset1)
dim(dataset1)
str(dataset1)
summary(dataset1)

# Identifying missing data
sum(is.na(dataset1)) # Number of missing in dataset
rowSums(is.na(dataset1)) # Number of missing per variable

# Create new dataset without missing data
dataset1_clean <- na.omit(dataset1)

# Check that missing values were removed
sum(is.na(dataset1_clean))

# Identify duplicate values
sum(duplicated(dataset1_clean))

# Convert nominal variables into factors
dataset1_clean$Survived = factor(dataset1_clean$Survived)
dataset1_clean$Pclass = factor(dataset1_clean$Pclass)
dataset1_clean$Sex = factor(dataset1_clean$Sex)

summary(dataset1_clean)

# Create plots of survived by sex, age, and class
qplot(Survived, data = dataset1_clean,
      fill = Sex,
      color = I("black"),
      main = "Frequency of Survived by Sex")

qplot(Survived, data = dataset1_clean,
      fill = Pclass,
      color = I("black"),
      main = "Frequency of Survived by PClass")

# Two histogram are stacked.
ggplot(data = dataset1_clean, aes(Age)) + 
  geom_histogram(aes(fill = Survived), 
                 position = "stack", bins = 20, color = "black")

# Export clean dataset
write.csv(dataset1_clean, file = "Dataset1_Clean.csv", row.names = TRUE)


## Loading R libraries needed for EDA.
library(readr)
library(stringr) 
library(doBy)
library(ggplot2)
library(scales)
library(RColorBrewer)
library(corrplot)
library(dplyr)
library(randomForest)
library(gridExtra)

# Read data into R:
data = read.csv("Dataset1_Lesson7.csv")
## Categorical casting:
data$Name = as.factor(data$Name)
data$Sex = as.factor(data$Sex)
data$Survived = as.factor(data$Survived)
data$Pclass = as.factor(data$Pclass)
data$Embarked= as.factor(data$Embarked)
data$Cabin = as.factor(data$Cabin)
# Summary of data:
summary(data)


# Addressing PROBLEM 1
data[data$Embarked == '', "Embarked"] <- 'S'
summary(data$Embarked)

# Addressing PROBLEM 2
hist(data$Age, na.rm = TRUE, col="lime green", main="Histogram of Non-Missing Values of Age", xlab="Age")
data[is.na(data$Age), "Age"] <- median(data$Age,na.rm=TRUE)
summary(data$Age)


# Addressing PROBLEM 3
## Define DECK variable that can be obtained from passenger's cabin:
data$Deck <- sapply(data$Cabin, function(x) strsplit(x, NULL)[[1]][1])
# Drop Cabin variable from dataset:
data$Cabin <- NULL
# Replace missing values of Deck
data$Deck[is.na(data$Deck)] <- "U"
# Make it a factor
data$Deck <- as.factor(data$Deck)
# Create summary of Deck variable
summary(data$Deck)


# Addressing PROBLEM 4
# Create new variables TravelGroup and GroupSize and add them to dataset.
data$TravelGroup <- NA
data <- (transform(data, TravelGroup = match(Ticket, unique(Ticket))))

data <- data %>% 
  group_by(TravelGroup) %>% 
  mutate(GroupSize = n()) %>%
  ungroup()


# Addressing PROBLEM 5
PassengerTitle <- data$Name
PassengerTitle <- gsub("^.*, (.*?)\\..*$", "\\1", PassengerTitle)
data$PassengerTitle <- PassengerTitle
# Prints the unique titles in the data-set.
unique(data$PassengerTitle)


# Addressing PROBLEM 6
par(mfrow = c(1, 2))
boxplot(data$Age, main ="Boxplot of Age", col = "orange", xlab = "Age")
boxplot(data$Fare, main = "Boxplot of Fare", col="purple", xlab = "Fare")

## Export data to .csv file
write.csv(data,"C:\\Users\\gus21\\OneDrive\\Desktop\\DAAN 822\\CleanData_Lesson7.csv", row.names = FALSE)
