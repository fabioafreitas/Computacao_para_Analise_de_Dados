#fatores, listas e matrizes

x <- c(1,2,3,3,5,3,2,4,NA)
fator <- factor(x)
levels(fator)

f <- factor(c("a","a","b","c","c","d"))
f[f == 'a']

#Um fator também pode ser gerado usando a função gl(). 
#Qual o comando cria um fator com 100 repetições tanto para"M" 
#quanto para "F" ? Note que o comando deve ser submetido no 
#seguinte formato: gl(x,k,labels = z). OBS.: Ao submeter o comando, 
#retire todos os espaço em branco.
gl(2,100,labels=c("M", "F"))

#Crie o fator drinks <- factor(c("beer","beer","wine","water")).
#Depois, submeta apenas o comando em R para calcular a proporção
#de cervejas (beer) no objeto fator de bebidas (drinks). 
#É obrigatório o uso da função mean para calcular a proporção.
#OBS.: Ao submeter o comando, retire todos os espaço em branco.
drinks <- factor(c("beer","beer","wine","water"))
mean(drinks=="beer")

#Crie o fator drinks <- factor(c("beer","beer","wine","water")).
#Depois, altere o primeiro nível do fator com o seguinte 
#comando: levels(drinks)[1] <- "water". Qual o fator resultante
#quando acessar os elementos do mesmo?
drinks <- factor(c("beer","beer","wine","water"))
levels(drinks)[1] <- "water"
drinks #water water wine water

#Considere os vetores: 
#nomes=[João, Paula, Maria, Ingrid, José, Marcos], 
#pesos=[80, 65, 70, 58, 78, 70] e 
#alturas=[1.70, 1.66, 1.65, 1.60, 1.76, 1.70]. Crie uma lista
#com esses vetores chamada de lista_pessoas. Depois, crie 
#um quarto objeto chamado IMC de acordo coma equação 
#IMC=pesos/alturas^2. Por fim, adicione o vetor IMC a 
#lista_pessoas (ao final da lista) e responda as questões 
#abaixo:
lista_pessoas <- list(
  nomes=c("João", "Paula", "Maria", "Ingrid", "José", "Marcos"),
  pesos=c(80, 65, 70, 58, 78, 70),
  alturas=c(1.70, 1.66, 1.65, 1.60, 1.76, 1.70)
)

calcular_imc <- function(peso, altura) {
  return(peso/(altura^2))
}

for (i in 1:6) {
  lista_pessoas$IMC[i] <- calcular_imc(lista_pessoas$pesos[i], lista_pessoas$alturas[i])
}
#nome do primeiro elemento da lista de nomes
lista_pessoas$nomes[1]

#o que retorna? R:25.71166
lista_pessoas[[4]][3]

#A partir do dateset ‘airquality’, crie uma variável ‘lista’ com
#o seguinte comando: lista<-lapply(airquality, function(x){mean(x)}).
#A função lapply() retorna um objeto do tipo lista com os valores das
#médias de cada uma das colunas do dataset ‘airquality’. Usando o RStudio,
#análise o dataset ChickWeight e a variável ‘lista’. Em seguida,
#escreva o comando que apenas apresenta a média das temperaturas 
#contida na variável ‘lista’ . *
lista<-lapply(airquality, function(x){mean(x)})
lista$Temp


#Para responder as questão abaixo, faça download do arquivo disponível em 
#https://www.dropbox.com/s/luxinhu8d1hmc1j/chuvas.RData?dl=1 
#e mova-o para o seu diretório. Em seguida leia-o com o comando
#load("chuvas.RData"). A matriz chuvas possui dados (em mm) sobre
#precipitações em 100 municípios do Brasil, durante um período de 
#30 dias. Os municípios estão representados em códigos através das 
#linhas e os dias através das colunas. Diante de tais dados,resolva
#as questões abaixo.
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
load("chuvas.RData")

#Qual a média do volume diário de chuvas do período observado? 
mean(rowMeans(chuvas))

#Qual município teve o maior volume de chuvas considerando os 30 dias observados? *
sort(rowMeans(chuvas)) #mun_60

#Considerando o volume de todos os municípios observados, em qual dia menos choveu? *
sort(colMeans(chuvas),decreasing = T) #dia_12

#Quais comandos abaixo calculam o volume de chuvas do 
#município 81 (mun_81) nos primeiros 10 dias observados? *

aux<-chuvas["mun_81" , ]; aux<-sum(aux[1:10]) #sim
aux<-chuvas[81 , ]; aux<-sum(aux[1:10])       #sim
aux<-chuvas[81 , ]; aux<-sum(aux[seq(1,10,1)]) #sim
aux<-chuvas["mun_81" ]; aux<-sum(aux[1:10]) #nao
aux<-chuvas["mun_81" , ]; aux<-sum(aux[c(1:10)]) #sim
aux

