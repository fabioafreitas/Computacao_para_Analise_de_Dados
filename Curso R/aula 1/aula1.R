 ################ Introdução ao R    ###################
 
#________________ Criando vetores________________________________
 
 variavel1<-c(1,2,3,4,4,3,2,1)
 variavel2<-c(5,6,7,8,4,3,12,1)
 variavel3<-c(9,10,11,12,10,10,14,12)
 variavel4<-c(24,31,33,15,10,10,24,27)
 
 
 #Forma correta de criar vetor não numérico
 opiniao<-c("sim", "sim", "Não", "Não", "Não")
 opiniao

 #Forma errada de criar vetor não numérico 
 vetorerrado<-c(sim,sim,não,não,não)
 
 
 
#________________ Criando matrizes_______________________________
 
 banco_de_dados<-matrix(c(variavel1,variavel2,variavel3,variavel4)
                        ,ncol=4,byrow = F )
 banco_de_dados=cbind(variavel1,variavel2,variavel3,variavel4)
 
 banco_de_dados
 

 
#________________ Importando um banco de dados utilizando atalho do RStudio

install.packages("readxl")
require("readxl")

#Usar o atalho "Import Dataset" na sessão "Environment"
#Ler o banco de dados "Exemplo1"

Exemplo1 <- read_excel("C:\\Users\\fbioa\\Desktop\\Curso R\\aula 1\\Exemplo1.xlsx")


#Lendo uma variável do banco de dados
Exemplo1$X
Exemplo1$Y
plot( Exemplo1$X,
     Exemplo1$Y)

 
 
#________________ Pacote Rcmdr
 
 install.packages("Rcmdr")#Caso não tenha o pacote instalado
 
 require(Rcmdr)
 
 #################################################################
 