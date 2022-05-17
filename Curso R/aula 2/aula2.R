dados <- load(url(description = "https://www.ime.usp.br/~pam/dados.RData"))
attach(tab15_1)
tab15_1

acuidade_Z
idade_X
sexo_W
tempo_Y

# Estat�sticas descritivas para o grupo dos homens:
summary2(tempo_Y[sexo_W=="H"])

# Estat�sticas descritivas para o grupo das mulheres:
summary2(tempo_Y[sexo_W=="M"])

# Uma maneira mais elegante � utilizar a fun��o sapply:
## Estat�sticas descrtivas do tempo de reacAo por sexo
summary_sexo<-sapply(levels(sexo_W),function(sex){summary2(tempo_Y[sexo_W==sex])})
summary_sexo

## Estat�sticas descrtivas do tempo de reacAo por idade
summary_idade<-sapply(levels(idade_X),function(age){summary2(tempo_Y[idade_X==age])})
summary_idade


###Constru��o do Boxplot (TEMPO - Sexo)
boxplot(tempo_Y~sexo_W)
###  Adicionando informa��es no Boxplot
boxplot(tempo_Y~sexo_W,
        names = c("Masculino", "Feminino"),
        col = c("khaki", "seagreen1"),
        xlab="Sexo", ylab="Tempo")


###Constru��o do Boxplot (TEMPO - idade)
boxplot(tempo_Y~idade_X)
###  Adicionando informa��es no Boxplot
boxplot(tempo_Y~idade_X,
        names = c("20 anos", "25 anos", "30 anos", "35 anos", "40 anos" ),
        col = c("khaki", "seagreen1", "salmon", "paleturquoise3", "thistle"),
        xlab="Idade", ylab="Tempo")

############Ajuste do modelo
modelo<-lm(tempo_Y~acuidade_Z)
modelo
summary(modelo)

anova(modelo)