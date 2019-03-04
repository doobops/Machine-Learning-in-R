
install.packages('dummy')
library(dummy)

# https://cran.r-project.org/web/packages/dummy/dummy.pdf

#create toy data
(traindata <- data.frame(var1=as.factor(c("a","b","b","c")),
                         var2=as.factor(c(1,1,2,3)),
                         var3=c("val1","val2","val3","val3"),
                         stringsAsFactors=FALSE))

(dummies_train <- dummy(x=traindata))