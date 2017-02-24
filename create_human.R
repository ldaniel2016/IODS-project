# Laila Daniel.  Data Wrangling for exercise 5 - Dimensionality Reduction

# Create a dataset "human" from the human_development and gender inequality datasets.

# Read the “Human development” and “Gender inequality” data into R.

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
dim(hd)

str(gii)
dim(gii)



# Rename the columns of hd and gii with shorter names

colnames(hd) <- c("hdir", "country", "hdi", "le", "exp.edu", "mean.edu", "gni","gnir-hdir")
colnames(gii) <- c("giir", "country", "gii", "mmr", "abr", "prp", "edu2F", "edu2M", "labF", "labM")

library(dplyr)

# Add a new column "edu2", the ratio of female and male populations with secondary education in each country.
gii <- mutate(gii, edu2 = edu2F / edu2M)

# Add a second column "lab", the ratio of labour force participation of females and males in each country 
gii <- mutate(gii, lab = labF / labM)

# Create a  new dataset "human" by joining together the two datasets, hd and gii  using the variable Country as the identifier
human <- inner_join(hd, gii, by = "country")

# The "human" dataframe now has 155 observations of 8 variables.
# write this dataframe to the file "human.csv" in the project directory
setwd("/home/daniel/lstudies/IODS2017/IODS-project/data")
write.csv(human, file = "human_ex4.csv", row.names = TRUE)
