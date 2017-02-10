# Download the alc dataframe from http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt

alc <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt", 
                  sep = ",", header=TRUE)

# access the tidyverse libraries tidyr, dplyr, ggplot2, GGally
library(tidyr); library(dplyr); library(ggplot2); library(GGally)

# use gather() to gather columns into key-value pairs and then glimpse() at the resulting data
gather(alc) %>% glimpse

# draw a bar plot of each variable
gather(alc) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()

library(randomForest)

# removing the Dalc, walc, G1, G2, alc_use coulumns from alc
alcnew <- alc[-c(27,28,31,32,34)]
fit=randomForest(factor(high_use)~., data=alc_new)
(VI_F=importance(fit))

alc %>% group_by(sex, high_use) %>% summarise(count = n())

m <- glm(high_use ~ goout + failures + absences + G3 + sex, data = alc, family = "binomial")

m <- glm(high_use ~ goout + failures + absences + sex, data = alc, family = "binomial")
m <- glm(high_use ~ G3 + failures + absences + sex, data = alc, family = "binomial")
m <- glm(high_use ~ failures + absences + sex, data = alc, family = "binomial")
# compute odds ratios (OR)
OR <- coef(m) %>% exp

# compute confidence intervals (CI)
CI <- confint(m) %>% exp

# print out the odds ratios with their confidence intervals
cbind(OR, CI)

m <- glm(high_use ~ failures + absences  + sex, data = alc, family = "binomial")
# predict() the probability of high_use
probabilities <- predict(m, type = "response")

# add the predicted probabilities to 'alc'
alc <- mutate(alc, probability = probabilities)

# use the probabilities to make a prediction of high_use
alc <- mutate(alc, prediction = probability > 0.5)

# tabulate the target variable versus the predictions
table(high_use = alc$high_use, prediction = alc$prediction)


g <- ggplot(alc, aes(x = probability, y = high_use))
g +  geom_point()
# define the geom as points and draw the plot
g <- ggplot(alc, aes(x = probability, y = high_use, col = prediction))
g +  geom_point()
# tabulate the target variable versus the predictions
table(high_use = alc$high_use, prediction = alc$prediction) %>% prop.table %>% addmargins

# initialize a plot of 'high_use' versus 'probability' in 'alc'
g <- ggplot(alc, aes(x = probability, y = high_use))
g +  geom_point()
# define the geom as points and draw the plot
g <- ggplot(alc, aes(x = probability, y = high_use, col = prediction))
g +  geom_point()
# tabulate the target variable versus the predictions
table(high_use = alc$high_use, prediction = alc$prediction) %>% prop.table %>% addmargins


loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

# call loss_func to compute the average number of wrong predictions in the (training) data
loss_func(class = alc$high_use, prob = 0)
loss_func(class = alc$high_use, prob = 1)
loss_func(class = alc$high_use, prob = alc$probability)


m <- glm(high_use ~ failures + absences + sex + G3 + reason + famrel, data = alc, family = "binomial")
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

# compute the average number of wrong predictions in the (training) data

loss_func(class = alc$high_use, prob = alc$probability)

# K-fold cross-validation
library(boot)
cv <- cv.glm(data = alc, cost = loss_func, glmfit = m, K = nrow(alc))

# average number of wrong predictions in the cross validation
cv$delta[1]
# 10-fold cross validation
cv<- cv.glm(data = alc, cost = loss_func, glmfit = m, K = 10)

cv$delta[1]

cv.vars <- NULL

alc_vars <- c("sex", "absences", "failures" , "goout", "famrel", "G3","freetime","health", "school", 
              "age","address","famsize","Pstatus","Medu","Fedu",
              "Mjob","Fjob","reason","nursery","internet","guardian","traveltime","studytime",
              "schoolsup", "famsup","paid","activities","higher","romantic")


library(boot)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
for (i in 1:29) {
PredictorVariables <- paste(alc_vars[1:i], sep="")

formula_Vars <- formula(paste("high_use ~ ", 
                         paste(PredictorVariables, collapse=" + ")))


m <- glm(formula_Vars, data = alc, family = "binomial")


# compute the average number of wrong predictions in the (training) data

loss_func(class = alc$high_use, prob = alc$probability)

# K-fold cross-validation

# 10-fold cross validation
cv<- cv.glm(data = alc, cost = loss_func, glmfit = m, K = 10)

cv$delta[1]
cv.vars <- rbind(cv.vars, cv$delta[1])
}

plot(cv.vars)
g <- ggplot(cv.vars[1:29], xlab= "no. of. variables", ylab = "cv error")
g+geom_point()

colnames(alc)
names(alc)

alc_vars <- c("absences", "failures" , "sex", "goout", "famrel", "G3","freetime","health", "school", 
              "age","address","famsize","Pstatus","Medu","Fedu",
              "Mjob","Fjob","reason","nursery","internet","guardian","traveltime","studytime",
              "schoolsup", "famsup","paid","activities","higher","romantic")




m <- glm(high_use ~ goout + failures + absences + sex, data = alc, family = "binomial")

# compute odds ratios (OR)
OR <- coef(m) %>% exp

# compute confidence intervals (CI)
CI <- confint(m) %>% exp

# print out the odds ratios with their confidence intervals
cbind(OR, CI)

m1 <- glm(high_use ~ goout + failures + absences + sex, data = alc, family = "binomial")
m2 <- glm(high_use ~ goout + failures + absences , data = alc, family = "binomial")

anova(m1, m2, test="LRT")
