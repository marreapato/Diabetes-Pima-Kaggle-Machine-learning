#analise exploratoria
#2000 observacões
#exploratory analysis
#2000 observations


#fazendo ajustes
#making some adjustments
library(tidyverse)
library(ggthemes)
diabetes$Outcome<-as.factor(diabetes$Outcome)
diabetes$Outcome <-  str_replace_all(diabetes$Outcome,"1","Com diabetes")
diabetes$Outcome <-  str_replace_all(diabetes$Outcome,"0","Sem diabetes")
#?str_replace_all


#summary dos dados separados entre quem tem e quem n tem diabetes
#data summary splitted between those who have and don't have diabetes

#olhem a media da glucose/glicose
#average glucose
comdiabe<-diabetes %>% filter(Outcome=="Com diabetes")#grupo diabetico
semdiabe<-diabetes %>% filter(Outcome=="Sem diabetes")#grupo nao diabetico

summary(comdiabe)
summary(semdiabe)

#realizando graficos
#plotting
tabdia<-table(diabetes$Outcome)#tabela de frequencia
tabdia<-as.data.frame(tabdia)

#grafico da proporçao de diabeticos e n diabeticos na amostra
#plotting the proportion of individuals who have diabetes and the ones who don't
ggplot(tabdia,aes(y=Freq,x=Var1,fill=Var1))+geom_col()+labs(fill="Diagnóstico",x="Diagnóstico",y="Proporção")+
  theme_fivethirtyeight()+scale_fill_tableau()+ geom_text(aes(label=Freq),vjust=-0.1)



#fazendo boxplot
#building a boxplot
#vejam os outliers(porem os mesmos sao veridicos)
#take a look at the outliers(although they are veridic)
means <- aggregate(BMI ~  Outcome,data = diabetes,mean)
means$BMI<-round(means$BMI)
ggplot(diabetes,aes(x=Outcome,y=BMI,fill=Outcome))+geom_boxplot()+scale_fill_tableau()+theme_tufte()+
  labs(fill="Diagnóstico",y="IMC",x="Diagnóstico") + 
  geom_text(data = means, aes(label = BMI, y = BMI +2))+stat_summary(fun.y=mean, colour="darkred", geom="point", 
                                                                     shape=18, size=3,show_guide = FALSE)
#o ponto no meio e o imc medio no grafico acima
#the middle point is the BMI 

#HISTOGRAMA DE IDADE
#age histogram
ggplot(diabetes,aes(x=Age,fill=Outcome))+geom_histogram(bins=18,position = "dodge")+labs(x="Idade",y="Proporção de indivíduos",fill="Diagnóstico")+
scale_fill_tableau()+theme_hc()



#HISTOGRAMA DE Glicose
#glucosis histogram
ggplot(diabetes,aes(x=Glucose,fill=Outcome))+geom_histogram(bins=18,position = "dodge")+labs(x="Nível de glicose",y="Proporção de indivíduos",fill="Diagnóstico")+
  scale_fill_tableau()+theme_hc()

#HISTOGRAMA DE Insulina
#insulin histogram
ggplot(diabetes,aes(x=Insulin,fill=Outcome))+geom_histogram(bins=18,position = "dodge")+labs(x="Nível de insulina",y="Proporção de indivíduos",fill="Diagnóstico")+
  scale_fill_tableau()+theme_hc()




