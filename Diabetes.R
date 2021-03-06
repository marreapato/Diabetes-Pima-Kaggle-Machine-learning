

#PARA TODAS AS VARIAVEIS O MELHOR MODELO FOI O DE REGRESSAO LINEAR LOGISTICA
#A PEDIGREE FUNCTION FOI EXCLUIDA POIS NAO CONSEGUIMOS CALCULAR-LA
#SINTA SE LIVRE PARA USAR O CODIGO

#CONSIDERING ALL MODELS APPLIED TO THE FOLLOWING EXAMPLES THE BETTER ONE WAS THE LOGISTIC REGRESSION
#THE PEDIGREE FUNCTION WAS REMOVED CAUSE WE COULDN'T FIND A WAY TO CALCULATE AND APPLY IT TO REAL LIFE PROBLEMS
#FEEL FREE TO USE THE CODE

#reading the dataset

diabetes<-read.csv("diabetes.csv")

diabetes<-as.data.frame(diabetes)

#pacotes importantes
#important libraries
library(caret)
library(e1071)
library(corrplot)
#grafico de corr
#correlation plot
#down bellow

#caso deseje ver a correlacao com a pedigree
#In case you need to see the correlation with the pedigree function

corrplot(cor(diabetes),method="number")

#tirando a pedigree function
#taking out the pedigree function

diabetes <- diabetes[,-7]

#corr plot without the pedigree function

corrplot(cor(diabetes),method="number")

#separating data between test and training
#separando os dados entre treinamento e teste

indice<-createDataPartition(diabetes[["Outcome"]],list=FALSE,p=0.70)
treino<-diabetes[indice,]
teste <-diabetes[-indice,]

#treinando modelo
#training model

controle<-trainControl(method="repeatedcv",number=10,repeats = 5)

#treinando modelo knn
#training knn model

modeloknn <- train(factor(Outcome)~BMI+Age+Pregnancies,#na.action = Caso tenha na/in case there are NA values
               data = treino,method="knn",tuneLength=10)
modeloknn

pred <- predict(modeloknn,newdata = teste)

ver<-cbind(teste,pred)#creating a dataset with test and predicted values
ver#dataset

#testando observacao
#testing new observation
#novaob <- data.frame(BMI=34.5,Age=44)
#novaob
#pred <- predict(modeloknn,newdata = novaob)
#pred

#confusion matrix

cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm

#testando outros modelos ainda com o knn
#testing knn model with a different combination
#treinando modelo

attach(diabetes)#attaching the variables
#com as variaveis mais de maior correlacao
modeloknn <- train(factor(Outcome)~BMI+Age+Pregnancies+Glucose,
                   data = treino,method="knn",tuneLength=10)
modeloknn

pred <- predict(modeloknn,newdata = teste)

#new observation

#ver<-cbind(teste,pred)
#ver
#testando observacao
#testing new observation

novaob <- data.frame(Pregnancies=0,BMI=20.5,Age=16)
novaob
pred <- predict(modeloknn,newdata = novaob)
pred
cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm

#testando outros modelos regressao logistica
#testing other models, with logistic regression being the following bellow

modeloglm <- train(factor(Outcome)~BMI+Age+Pregnancies,#na.action = Caso tenha na
                   data = treino,method="glm",tuneLength=10)
modeloglm

pred <- predict(modeloglm,newdata = teste)

ver<-cbind(teste,pred)
ver#test and predicted dataset


#testando observacao
#testing a new observation

#novaob <- data.frame(BMI=43.5,Age=25)
#novaob
#pred <- predict(modeloglm,newdata = novaob)
#pred

#confusion matrix
cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm

#testando outros modelos lda/na questao do p valor esse foi melhor
#testing other models, with adl being the following bellow

modelolda <- train(factor(Outcome)~BMI+Age+Pregnancies+Glucose,#na.action = Caso tenha na
                   data = treino,method="lda",tuneLength=10)
modelolda

pred <- predict(modelolda,newdata = teste)

ver<-cbind(teste,pred)
ver#test and predicted values

#testando observacao
#testing a new observation
#novaob <- data.frame(BMI=34.5,Age=40)
#novaob
#pred <- predict(modeloknn,newdata = novaob)
pred

#confusion matrix

cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm#ADL was slightly better than glm

#qda modelo//nao foi mto bom
#adq model not quite good(for the following variables)
modeloqda <- train(factor(Outcome)~BMI+Age+Pregnancies+Glucose,#na.action = Caso tenha na
                   data = treino,method="qda",tuneLength=10)
modeloqda
pred <- predict(modeloqda,newdata = teste)

#ver<-cbind(teste,pred)
#ver
#testando observacao
#novaob <- data.frame(BMI=34.5,Age=40)
#novaob
#pred <- predict(modeloknn,newdata = novaob)

pred

cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm

#testando a arvore de decisao que n foi mto boa tbm
#testing the decision tree,also not quite good(for the following variables)

modelotree <- train(factor(Outcome)~BMI+Age+Pregnancies+Glucose,#na.action = Caso tenha na
                   data = treino,method="rpart",tuneLength=10)
modelotree

pred <- predict(modelotree,newdata = teste)

#ver<-cbind(teste,pred)
#ver
#testando observacao
#novaob <- data.frame(BMI=34.5,Age=40)
#novaob
#pred <- predict(modeloknn,newdata = novaob)

pred

cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm

#####################################################################################

#modelos bonus
#bonus models
#randomforest

modeloforest <- train(factor(Outcome)~BMI+Age+Pregnancies+Glucose,#na.action = Caso tenha na
                    data = treino,method="rf",tuneLength=10)
modeloforest
pred <- predict(modeloforest,newdata = teste)
#ver<-cbind(teste,pred)
#ver

#testando observacao
#testing a new observation

#novaob <- data.frame(BMI=34.5,Age=40)
#novaob
#pred <- predict(modeloknn,newdata = novaob)

pred

cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm# random forest nao foi muito interessante

#redes neurais
#Neural nets

modelonnet <- train(factor(Outcome)~BMI+Age+Pregnancies+Glucose,#na.action = Caso tenha na
                      data = treino,method="nnet",tuneLength=2)
modelonnet

pred <- predict(modelonnet,newdata = teste)

#ver<-cbind(teste,pred)
#ver
#testando observacao
#novaob <- data.frame(BMI=34.5,Age=40)
#novaob
#pred <- predict(modeloknn,newdata = novaob)

pred

cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm

modelongn <- train(factor(Outcome)~BMI+Age+Pregnancies+Glucose,#na.action = Caso tenha na
                    data = treino,method="rbf",tuneLength=10)
modelongn

pred <- predict(modelongn,newdata = teste)

#ver<-cbind(teste,pred)
#ver
#testando observacao
#novaob <- data.frame(BMI=34.5,Age=40)
#novaob
#pred <- predict(modeloknn,newdata = novaob)

pred

cm <- confusionMatrix(pred,factor(teste[["Outcome"]]))
cm

#ADL AND LOGISTIC REGRESSION WERE THE BEST MODELS









