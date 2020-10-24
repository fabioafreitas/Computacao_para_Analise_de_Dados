##### 5 #####

#Suponha que a variável escolhida num estudo seja o peso dos gatos da Ruralinda e que a população é composta de 300 gatos. Pelo um estudo prévio dos pesos, o desvio-padrão é de 0.5 kg. Admitindo-se um nível de confiança de 99% e um erro amostral de 0.1 kg, calcule o tamanho da amostra para estimar o peso médio dos gatos da Ruralinda. Use apenas duas casas decimais para submeter sua resposta (sem arredondamento). Ex.:123.239586 -> 123.23. *

sd <- 0.5
erro <- 0.1
nc <- (1-0.99)/2
N <- 300

n <- (qnorm(nc, lower.tail = F)^2*sd^2*N)/ ((erro^2*(N-1))+(qnorm(nc, lower.tail = F)^2*sd^2))
n

##### 6 #####

install.packages("MASS")
require(MASS)
attach(anorexia)
anorexia
##### 7 #####


##### 8 #####


##### 9 #####


##### 10 #####

#Para esta questão, usaremos o conjunto de dados "bdims". Este conjunto de dados contém medidas de 247 homens e 260 mulheres, a maioria dos quais foram considerados adultos jovens saudáveis. Determine o intervalo de confiança de 98.5% da média de alturas (hgt) das mulheres (sex == 0). Para carregar o conjunto de dados primeiro baixe o arquivo "bdims.RData" e coloque-o no diretório apontado pelo RStudio. Após isso, use o comando load("bdims.RData"). Submeta a resposta com duas casas decimais e sem espaço. Por exemplo: [ 23.4051 - 34.44589 ] -> [23.40-34.44]. *

load("bdims.RData")

f <- bdims[bdims$sex == 0,]
hgt <- f$hgt

#Desvio padrão
d <- sd(f$hgt)
#Média da amostra
x <- mean(hgt)
#Tamanho da amostra
n <- length(hgt)
#Nível de confiança
nc <- (1-0.985)/2
#Erro
error <- d/sqrt(n)
#Limite inferior
left <- x-(qnorm(nc, lower.tail = F)*error)
#Limite superior
right <- x+(qnorm(nc, lower.tail = F)*error)
cat("[",left, "-", right,"]")