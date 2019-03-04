
#Set Up
help(state.x77)
state.x77 #Investigating the state.x77 dataset.

states = as.data.frame(state.x77) #Forcing the state.x77 dataset to be a dataframe.

#Cleaning up the column names so that there are no spaces.
colnames(states)[4] = "Life.Exp"
colnames(states)[6] = "HS.Grad"

#Creating a population density variable.
states[,9] = (states$Population*1000)/states$Area
colnames(states)[9] = "Density"

#Basic numerical EDA for states dataset.
summary(states)
sapply(states, sd)
cor(states)

#Creating a saturated model (a model with all variables included).
model.saturated = lm(Life.Exp ~ ., data = states)

plot(model.saturated) #Assessing the assumptions of the model.

library(car)

avPlots(model.saturated) 

## Manual AVPlot

nopop_y = lm(Life.Exp ~ . - Population, data = states)
nopop_X = lm(Population ~ . - Population, data = states)
plot(nopop_X$residuals,nopop_y$residuals)
