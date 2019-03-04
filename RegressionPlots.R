
# These are approximate for the sake of presenting the intuition

# 1 Residuals vs Fitted
# Do the residuals evenly disburse around 0?
# Are there no patterns?
plot(fit,which = 1)
plot(fit$fitted.values,fit$residuals)

# 2 Normal QQ
# Do the points follow a straight line?
plot(fit,which = 2)
plot(qnorm(((1:n)-.5)/n),sort(fit$residuals)/sd(fit$residuals))
abline(0,1)

# 3 Scale-Location
# Is there a pattern in variance?
plot(fit,which = 3)
plot(fit$fitted.values,rstandard(fit, infl = influence(fit, do.coef = FALSE)))

# 4 Residuals vs Leverage
plot(fit,which = 5)
# Leverage
# https://en.wikipedia.org/wiki/Leverage_(statistics)
# The sensitivity of the prediction of a point to its predictors.
# Found from the diagonals of the hat matrix.
# Cooks Distance
# https://www.mathworks.com/help/stats/cooks-distance.html?requestedDomain=true
# https://en.wikipedia.org/wiki/Cook%27s_distance
# The standardized sum of the change of all prediction values the results from removing a particular point.  
# The sum is standardized by dividing by number of predictors, p, and by the residual standard error, RSE = sqrt(RSS/df).