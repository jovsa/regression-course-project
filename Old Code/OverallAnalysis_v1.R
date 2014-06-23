wd <- "C:/Users/jsardinha/Documents/GitHub/RegressionModels_CourseProject"
setwd(wd)
install.packages("MASS")
install.packages("gvlma")
install.packages("car")
library(MASS)
library(ggplot2)
library(gvlma)
library(car)

# Downloading the data
data(mtcars)

#Analyzing data set
str(mtcars)
summary(mtcars)

#Searching for missing values
table(is.na(mtcars))

#creating tidy data set
tidy <- mtcars

#CREATE a matrix scatter plot to show the relationships

# creating factor variables
tidy$am <- as.factor(mtcars$am)
tidy$cyl <- as.factor(mtcars$cyl)
tidy$gear <- as.factor(mtcars$gear)
tidy$carb <- as.factor(mtcars$carb)
tidy$vs <- as.factor(mtcars$vs)


# Analyzing if automatic vs manual is better for MPG
with(tidy, tapply(mpg,am, FUN=mean))
#We see that miles per gallon is better as estimate = 24.39 and both are significant terms.

fit1 <- stepAIC(lm(data=tidy,mpg~.),direction="both",test="F")
summary(fit1)
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit1)









# Playground
png(filename="plot4.png")
# par(mfrow=c(1,1))
# par(mfcol=c(1,1))
# par()   
# scatterplotMatrix(tidy, spread=FALSE, lty.smooth=2,
#                   main="Scatter Plot Matrix")
# dev.off()

cor(mtcars)
par(mfrow = c(11,11))
scatterplotMatrix(mtcars, spread=FALSE, lty.smooth=2,
                                     main="Scatter Plot Matrix")
dev.off()



#AIC(fit1)
#summary(lm(formula = mpg ~ cyl + hp + wt + am, data = tidy))$coef

summary(lm(mpg~., data = tidy))

summary(step(lm(data=tidy,mpg~.),direction="backward",test="F"))

summary(stepAIC(lm(data=tidy,mpg~.),direction="both",test="F"))

# Playing
fit2 <- (lm(formula = mpg ~ cyl + hp + wt + am, data = tidy))
summary(fit2)$coef
gvmodel<- gvlma(fit2)
summary(gvmodel)

extractAIC(lm(formula = mpg ~ cyl + hp + wt + am, data = tidy))[2]


# Analyzing if automatic vs manual is better for MPG
fit1 <- lm(mpg~am-1, data = tidy)
summary(fit1)$coef
#We see that miles per gallon is better as estimate = 24.39 and both are significant terms.
gvmodel<- gvlma(fit1)
summary(gvmodel)
plot(fit1)
