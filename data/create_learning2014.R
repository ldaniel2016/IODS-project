# Laila Daniel 03.02.2017
# Rstudio exercise 2: Regression and model validation

## Data wrangling

# Access the dplyr library
library(dplyr)

# Read the full learning2014 data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt into R 
# (the separator is a tab ("\t") and the file includes a header) 

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Structure and dimensions of learning2014
str(learning2014)
dim(learning2014)


# The questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06","D15","D23","D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Select the columns related to deep learning and create column 'deep' by taking the mean 
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

# Select the columns related to strategic learning and create column 'stra' by taking the mean 
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

# Select the columns related to surface learning and create column 'surf' by taking the mean 
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

# Creating a column 'attitude' by scaling the column 'Attitude' by the number of questions, i.e., 10
learning2014$attitude <- learning2014$Attitude /10

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points 
# by combining questions in the learning2014 data
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# filetrout the entries with point variable equal to 0
learn2014 <- filter(df <- select(learning2014, one_of(keep_columns)), Points > 0)

# Rename the columns "Age" to "age" and "Points" to "points"
# Use str() or head() to see if the column names have changed

colnames(learn2014)[2] <- "age"
colnames(learn2014)[7] <- "points"
str(learn2014)

# See that Tthe resulting dataframe has 166 observations and 7 variables
dim(learn2014)

# Set the working directory to the project folder 'data'
setwd("/home/daniel/lstudies/IODS2017/IODS-project/data")

# Write the table to a file learn2014.txt in the project folder
write.table(learn2014, "learn2014.txt", sep="\t")

# Read the saved file to see the structure of the dataframe is correct
lrn2014 <- read.table("learn2014.txt", sep="\t", header=TRUE)
str(lrn2014)
dim(lrn2014)
head(lrn2014)
