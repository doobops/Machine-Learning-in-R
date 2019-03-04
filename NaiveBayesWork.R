# Get Data ####
library(readxl)
d <- read_excel("NaiveBayesData.xlsx", 
                col_types = c("text", "text"), sheet = "train")
d = as.data.frame(d)
d$type = as.factor(d$type)
dtrain = d

d <- read_excel("NaiveBayesData.xlsx", 
                col_types = c("text", "text"), sheet = "test")
d = as.data.frame(d)
d$type = as.factor(d$type)
dtest_ = d

# Create Document Term Matrix ####

library(tm)
sms_corpus_train = Corpus(VectorSource(dtrain$text))
sms_dtm_train = DocumentTermMatrix(sms_corpus_train, control = list(
  tolower = TRUE,
  removeNumbers = TRUE,
  stopwords = TRUE,
  removePunctuation = TRUE,
  stemming = TRUE
))

sms_corpus_test_ = Corpus(VectorSource(dtest_$text))
sms_dtm_test_ = DocumentTermMatrix(sms_corpus_test_, control = list(
  tolower = TRUE,
  removeNumbers = TRUE,
  stopwords = TRUE,
  removePunctuation = TRUE,
  stemming = TRUE
))


ConvertCounts = function(x) {
  x = ifelse(x > 0, "Yes", "No")
}


sms_mat_train = as.matrix(sms_dtm_train)
sms_mat_test_ = as.matrix(sms_dtm_test_)

sms_mat_train = apply(sms_dtm_train, 2, ConvertCounts)
sms_mat_test_ = apply(sms_dtm_test_, 2, ConvertCounts)

library(e1071)
sms_classifier = naiveBayes(sms_mat_train, dtrain$type)
sms_classifier

#Evaluating the model performance by predicting the test observations.
sms_test_pred = predict(sms_classifier, sms_mat_test_,type = "raw")
sms_test_pred

openxlsx::write.xlsx(x = sms_test_pred, file = 'temp.xlsx'  )
