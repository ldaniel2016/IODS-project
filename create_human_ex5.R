# Rstudio exercise 5
# Laila Daniel
# Data wrangling exercise. Create the "human" data from UNDP's  
# “Human development” and “Gender inequality” data
# The link to datawrangling exercise done as a part of exercise 4 is
# https://github.com/ldaniel2016/IODS-project/blob/master/create_human.R

# As a part of exercise 4, I created the file "human_ex4.csv"" file and is available 
# at https://github.com/ldaniel2016/IODS-project/blob/master/data/human_ex4.csv.
# The "human_ex4.csv" has 195 observations and 19 columns.

# As the names i gave for the columns are different from the names in the meta file 
# I use the data from the amazon aws for this exercise.

library(tidyr)
library(stringr)
library(dplyr)

# Read the "human" data fro amazon aws
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt",
                    sep =",", header = T)
# "human" dataset has 195 observations of 9 variables
str(human)
dim(human)

# mutate the human$GNI variable to numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

# keep  only the following columns in "human" data 
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))

# Remove all rows with missing values which are indicated in the data as "NA"
# complete.cases  gives an indicator TRUE/FALSE for each value, then we select fro "human"
# only those values which are TRUE
complete_obs <- complete.cases(human)
human <- human[complete_obs,]

# human_ has 162 rows and 9 columns. The last 7 rows relate to the regions, so we remove these rows
# define the last indice we want to keep. Deleteing the rows correspond to the regions we get 
# human_ with 155 observations of 7 variables
last <- nrow(human) - 7
# choose everything until the last 7 observations
human <- human[1:last, ]

dim(human)

# Add coutry name as the row names
rownames(human) <- human$Country
# Remove the country name column from human data
human <- human[-1]

# The "human" dataframe now has 155 observations of 8 variables.
# write this dataframe to the file "human.csv" in the project directory
setwd("/home/daniel/lstudies/IODS2017/IODS-project/data")
write.csv(human, file = "human.csv", row.names = TRUE)

# The "human.csv" file is also in my github data directory https://github.com/ldaniel2016/IODS-project/blob/master/data/human.csv