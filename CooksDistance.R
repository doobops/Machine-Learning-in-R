
library(car)
model = lm(dist ~ speed, data = cars)
sSq = sum(model$residuals^2)/model$df.residual
p = 2
newdata = data.frame(speed=cars$speed)
yhat = predict(object = model, newdata = newdata)

cooksD = cooks.distance(model = model)

n = dim(cars)[1]
cooksD1 = vector(mode = 'numeric', length = n)
df_mini = data.frame(speed = NA)

i=1
for (i in 1:n){
  df_mini[1] = cars$speed[i] 
  mycars = cars[-i,]
  modelx = lm(dist ~ speed, data = mycars)
  yhatx = predict(object = modelx, newdata = newdata)
  cooksD1[i] = sum((yhatx-yhat)^2) / (p*sSq)
}

max(abs(cooksD1-cooksD))

order(cooksD)
