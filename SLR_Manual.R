
# Data
x = cars$speed
y = cars$dist

beta1 = sum((x-mean(x))*(y-mean(y))) / sum((x-mean(x))^2)
beta0 = mean(y)-beta1*mean(x)

yhat = beta0 + beta1*x
e = y-yhat
RSS = sum(e^2)
TSS = sum((y-mean(y))^2)
ESS = TSS - RSS
RSq =  ESS / TSS

# Equalities:
cor(x,y)
cov(x,y)/(sd(x)*sd(y))
beta1 * sd(x)/sd(y)
sqrt(RSq)



fit = lm(y~x)
X = stats::model.matrix(y ~ x)
n = dim(X)[1]
p = dim(X)[2]-1

df = n-(p+1)
sqrt(sum(e^2)/df)

residuals = y - X %*% fit$coefficients

RSS = sum((fit$residuals)^2)
RSE = sqrt(RSS/fit$df.residual)
RSE

TSS = sum((y-mean(y))^2)
F_stat = ((TSS-RSS)/p) / (RSS/(n-p-1))
pf(F_stat,p,n-p-1,lower.tail = F)

RSq = 1-RSS/TSS
multRSq = 1 - (RSS/(n-p-1)) / (TSS/(n-1))

VCV = vcov(fit)
SDs = sqrt(diag(VCV))
SDs
(summary(fit))$coefficients[,2]

b = solve(t(X)%*%X) %*% t(X) %*% y
b
(summary(fit))$coefficients[,1]

t = b / SDs
t

p = 2*pt(-abs(t),df=n-p-1)
p
(summary(fit))$coefficients[,4]


