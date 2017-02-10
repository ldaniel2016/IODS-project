# Download the alc dataframe from http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt

alc <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt", 
                  sep = ",", header=TRUE)