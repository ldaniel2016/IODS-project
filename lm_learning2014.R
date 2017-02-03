# Laila Daniel 03.02.2017
# Rstudio exercise 2: Regression and model validation


## Analysis 
# Loading the libraries for the plots

library(GGally)
library(ggplot2)

# loading the data from the file learn2014.txt created by the Rscript 
#in the Data wrangling part from the local folder

learn2014 <- read.table("learn2014.txt", sep="\t", header=TRUE)

# the dataframe learn2014 has 166 observations and 7 variables

str(learn2014)

dim(learn2014)

head(learn2014)

# The graphical overview of the data variables, their distributions and relationships. 
# the colours in the plot is based on gender

p <- ggpairs(learn2014, mapping = aes(col = gender), lower = list(combo = wrap("facethist", bins = 20)))

# show  the plot
p



# model fitting with three variables.
# The three variables which have highest absolute correlation values with 
# points are chosen from the plot p. These variables are attitude, stra and surf.
# The summary of my_model_var3 gives
# Residual standard error: 5.296 on 162 degrees of freedom
# Multiple R-squared:  0.2074,	Adjusted R-squared:  0.1927 
# F-statistic: 14.13 on 3 and 162 DF,  p-value: 3.156e-08
# From the summary the t value for surf is quite small compared to
# the t values of the other two variables

my_model3 <- lm(points ~ attitude + stra + surf, data = learn2014)
summary(my_model3)


# model fitting with two variables: attitude and stra
# The summary of the model gives
# Residual standard error: 5.289 on 163 degrees of freedom
# Multiple R-squared:  0.2048,	Adjusted R-squared:  0.1951 
# F-statistic: 20.99 on 2 and 163 DF,  p-value: 7.734e-09

my_model2 <- lm(points ~ attitude + stra, data = learn2014)
summary(my_model2)

# We plot the graphs  Residuals vs Fitted values, Normal QQ-plot and Residuals vs Leverage.
par(mfrow = c(2,2))
plot(my_model2, which = c(1,2,5), caption = list("Residuals vs Fitted values", "Normal QQ-plot", "Residuals vs Leverage"))



