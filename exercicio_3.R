#primeiro
xx <- c(TRUE, 2)
xx
 
#segundo lista, caracter e dataframe

#terceiro
x <- 1:4
y <- 2:3
x*y

#quarto
escore_padronizado <- function(v) {
  return((v - mean(v))/sd(v))
}

nomes <- c("Maria", "Joana")
a <- escore_padronizado(c(42, 38))    #Abdominal
b <- escore_padronizado(c(102, 173))  #Salto
c <- escore_padronizado(c(38, 71))    #Suspensao
d <- escore_padronizado(c(2149, 1554))#Corrida
e <- escore_padronizado(c(97, 70))    #Conhecimento

score = (a+b+c+d+e)/5
vencedor <- nomes[which.max(score)]
vencedor

#quinto "vetor.RData precisa estar no mesmo folder deste script"
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
load("./datasets/vetor.RData")

x <- vetor01[c(!is.na(vetor01))] #lista apenas dos alunos com nota
mean(x)           #media
median(x)         #mediana
sd(x)             #desvio padrao
length(which(is.na(vetor01))) #numero de alunos que faltaram
mean(is.na(vetor01))  #procentagem dos alunos que faltaram
length(x[x > 7.0 & x < 8.0]) #numero de alunos com notas entre 7 e 8
length(x[x > 9.0 | x < 1.0]) #numero de alunos com notas menor que 1 ou maior que 9


#vetor01[is.na(vetor01)] <- 0 #substituindo os NA por 0
vetor01 <- vetor01[!is.na(vetor01)] #sim
vetor01 <- vetor01[is.na(vetor01)]  #nao
vetor01 <- !is.na(vetor01)          #nao
vetor01[!is.na(vetor01)] -> vetor01 #sim
vetor01 <- vetor01[-which(is.na(vetor01))] #sim
vetor01 <- vetor01[which(is.na(vetor01))]  #

