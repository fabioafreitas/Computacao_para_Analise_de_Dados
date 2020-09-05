#Qual o resultado da função abaixo. *
y<-5
mult<- function(x,y) {
  return(x*y)
}
mult(10)




#Qual o resultado da função abaixo. *
y<-5
mult<- function(x) {
  return(x*y)
}
mult(10)





# Escreva uma função chamada 'prisoes' que calcula a soma das prisões em estados 
# americanos do dataset USArrests. A função 'prisoes' recebe dois argumentos: 
#   'estados' e 'tiposPrisoes'. Dado esses argumentos, a função retorna o total 
# de prisões. Se não existir nem o estado ou o tipo de prisão, então uma mensagem 
# de erro deve ser retornada. O protótipo dessa função é: 
#   prisoes <- function(estados, tiposPrisoes){}. As seguintes mensagens precisam
# ser apresentadas caso o estado ou o tipo de prisão estejam inválidos: 
#   "Estado Inválido" ou "Tipo de Prisão Inválida". De posse dessa função, 
# responda as questões abaixo.
prisoes_texto <- function(estados, tiposPrisoes, result) {
  text <- "o total de prisoes"
  text <- paste(
    text,
    ifelse(length(estados) > 1,"dos estados","do estado")
  )
  for(i in 1:length(estados)) {
    text <- paste(text, estados[i])
    text <- paste(text, ",")
  }
  text <- paste(text, "é")
  text <- paste(text, result)
  return(text)
}

prisoes <- function(estados, tiposPrisoes) {
  if(all(estados %in% rownames(USArrests))) {
    if(all(tiposPrisoes %in% colnames(USArrests))) {
      result <- sum(USArrests[estados,tiposPrisoes])
      print(prisoes_texto(estados, tiposPrisoes, result))
    } else {
      print("Tipo de Prisão Inválida")
    }
  } else {
    print("Estado Inválido")
  }
}

# Qual é o total de prisões do código a seguir?
prisoes(estados="Tennessee", tiposPrisoes=c("Rape","Murder"))

# Qual é o total de prisões do código a seguir?
prisoes(estados=c("California ","Miami", "Arizona"), tiposPrisoes=("Assault"))

# Qual é o total de prisões do código a seguir?
prisoes(estados=c("Pennsylvania","Mississippi", "Nebraska"), tiposPrisoes=c("Rape","UrbanPop","Assault"))

# Qual é o total de prisões do código a seguir?
prisoes(estados=c("Vermont","Wisconsin", "Texas"), tiposPrisoes=c("Rape","Assalto"))


################################################################################
# Escreva uma função chamada 'minhasNotas_1' que calcula a média das suas notas 
# para a disciplina de Computação para Análise de Dados. A função 'minhasNotas_1' 
# recebe 8 argumentos: 'Exe_1', "VA_1", 'Exe_2', "Proj" "VA_2", "VA_3", "Opt", e 
# "threshold". “Opt" pode receber três opções: 1 para retornar a média da 1 VA, 2
# para retornar a média da 2 VA e 3 para retornar a Média Final, incluindo a 3 VA.
# Note que a Média Final da UFRPE consiste de uma média aritmética das duas 
# maiores médias (1VA, 2VA e 3VA). Para a 1 e a 2 VA as notas de 'Exe_1', "VA_1", 
# "Exe_2", "Proj" e "VA_2" possuem os seguintes pesos,  respectivamente, 5, 5, 2, 
# 5, 3. O argumento "threshold" consiste da média mínima de aprovação. 
#
# A função  'minhasNotas_1' retorna a média do aluno de acordo com a opção 
# escolhida e também se a mesma está abaixo ou a cima do "threshold". Note que se
# a opção “3” for escolhida então uma mensagem será retornada informando a média 
# e se o aluno foi aprovado ou se está na final. Adicionalmente, uma mensagem de 
# erro deve ser apresentada caso notas acima de 10 ou menores que zero forem 
# passadas. O mesmo deve acontecer se for escolhido uma opção incorreta ou se o 
# aluno não tiver notas para uma determinada VA. Por fim, NAs devem ser tratado 
# como nota zero e a "VA_1", o "Proj", a "VA_2" e a "VA_3" devem receber apenas 
# um único valor. 
#
# O protótipo dessa função é descrito a seguir: minhasNotas_1 <- 
# function(Exe_1=0, VA_1=0, Exe2=0, Proj=0, VA_2=0, VA_3=0, Opt=1, threshold=7){}. 
# Por exemplo, a seguinte mensagem pode ser apresentada caso o aluno selecione a 
# nota da 1 VA (Opt=1):  "Média da 1VA: 9.0 - Acima da Média" ou “Aluno não possui 
# nota para a 1 VA”. Se Opt=3 for selecionada as seguintes mensagens poderão ser 
# apresentadas: “Aluno não possui nenhuma nota - Reprovado!!", “9,0 -- Aprovado!!" 
# ou “6,0 -- Na Final!!".
################################################################################

# opt 1 = media 1va, 2 = media 2va, 3 = media final
minhasNotas_1 <- function(
  Exe_1, VA_1, Exe_2,  Proj, 
  VA_2, VA_3, Opt, threshold) {
  if(is.na(Opt) | is.na(threshold)) {
    return("Opção ou Threshold inválido!")
  }
  if(Opt < 1 | Opt > 3) {
    return("Opção de nota Inválida!")
  }
  if(threshold < 0 | threshold > 10) {
    return("Threshold Inválido!")
  }
  
  #exe1, va1, exe2, proj, va2
  pesos <- c(5,5,2,5,3) 
  notas <- c(NA,NA,NA)

  #Checando se existem notas invalidas: < 0 ou > 10
  aux <- c(VA_1, VA_2, VA_3, Proj)
  aux <- c(aux, Exe_1, Exe_2)
  aux[is.na(aux)] <- 0
  aux <- aux[aux < 0 | aux > 10]
  if(ifelse(length(aux) > 0, T, F)) {
    return("Notas Invalidas!")
  }
  
  Exe_1 <- c(Exe_1)
  VA_1 <- c(VA_1)
  Exe_2 <- c(Exe_2)
  Proj <- c(Proj)
  VA_2 <- c(VA_2)
  VA_3 <- c(VA_3)
  
  #Proj, 1va, 2va e 3va não podem ser lista
  if(length(VA_1) > 1 | length(Proj) > 1 | length(VA_2) > 1 | length(VA_3) > 1) {
    return("Quantidade de Notas Inválidas!")
  }
  
  ######## 1 VA ########
  #Checando se o aluno tem pelo menos uma nota na 1 va
  if((length(Exe_1[is.na(Exe_1)]) == length(Exe_1)) & is.na(VA_1)) {
    if(Opt == 1) {
      return("Aluno não possui nota para a 1 va")
    }
  } else {
    #se o if der falso, ele possui pelo meons uma nota na 1 va
    Exe_1[is.na(Exe_1)] <- 0
    VA_1[is.na(VA_1)] <- 0
    notas[1] <- (mean(Exe_1)*pesos[1] + VA_1*pesos[2])/(pesos[1]+pesos[2])
    if(Opt == 1) {
      text <- paste("Média da 1VA:",notas[1])
      if(notas[1] < threshold) {
        text <- paste(text, "- Abaixo da Média")
      } else {
        text <- paste(text, "- Acima da Média")
      }
      return(text)
    }
  }
  
  ######## 2 VA ########
  # nota[2] <- pesos[3]*Exe_2 + pesos[4]*VA_2 + pesos[5]*Proj
  #Checando se o aluno tem pelo menos uma nota na 2 va
  if((length(Exe_2[is.na(Exe_2)]) == length(Exe_2)) & is.na(VA_2) & is.na(Proj)) {
    if(Opt == 2) {
      return("Aluno não possui nota para a 2 va")
    }
  } else {
    #se o if der falso, ele possui pelo meons uma nota na 2 va
    Exe_2[is.na(Exe_2)] <- 0
    Proj[is.na(Proj)] <- 0
    VA_2[is.na(VA_2)] <- 0
    notas[2] <- (mean(Exe_2)*pesos[3] + Proj*pesos[4] + VA_2*pesos[5])/(pesos[3]+pesos[4]+pesos[5])
    if(Opt == 2) {
      text <- paste("Média da 2VA:",notas[2])
      if(notas[2] < threshold) {
        text <- paste(text, "- Abaixo da Média")
      } else {
        text <- paste(text, "- Acima da Média")
      }
      return(text)
    }
  }
  ######## 3 VA ########
  notas[3] <- VA_3
  if(all(is.na(notas))) {
    return("Aluno não possui nenhuma nota - Reprovado!!")
  }

  notas[is.na(notas)] <- 0
  notas <- sort(notas, decreasing = T)
  media_atual <- mean(c(notas[1],notas[2]))
  
  if(media_atual < threshold) {
    return(paste(media_atual, "-- Na Final!!"))
  }
  return(paste(media_atual, "-- Aprovado!!"))
}


#Testando exemplo de saídas da função

print(minhasNotas_1(
  Exe_1 = c(10,7,NA), VA_1  = 7,  Exe_2 = 7,
  Proj  = 7,  VA_2  = 7,  VA_3  = 10, Opt   = 1,  threshold = 7
))

print(minhasNotas_1(
  Exe_1 = c(10,7,11), VA_1  = 7,  Exe_2 = 7,
  Proj  = 7,  VA_2  = 7,  VA_3  = 10, Opt   = 1,  threshold = 8
))

print(minhasNotas_1(
  Exe_1 = c(10,7,NA),   VA_1  = 7,  Exe_2 = c(7,9,10),
  Proj  = 7,  VA_2  = 7,  VA_3  = 10, Opt   = 2,  threshold = 8
))

print(minhasNotas_1(
  Exe_1 = NA, VA_1  = NA, Exe_2 = c(7,9,10),
  Proj  = 7,  VA_2  = 7,  VA_3  = 10, Opt   = 1,  threshold = 8
))

print(minhasNotas_1(
  Exe_1 = NA, VA_1  = NA, Exe_2 = c(7,9,10),
  Proj  = 7,  VA_2  = 7,  VA_3  = 10, Opt   = 3,  threshold = 8
))

print(minhasNotas_1(
  Exe_1 = NA, VA_1  = NA, Exe_2 = c(7,9,10),
  Proj  = c(7,8), VA_2  = 7,VA_3  = 10, Opt   = 3, threshold = 8
))


#### Questões ####

# Qual o retorno da seguinte função? 
minhasNotas_1(Exe_1=c(10,9,7,1,11,10), VA_1=8, Exe_2=7, Proj=7, VA_2=7, VA_3=10, Opt=1, threshold=7)

# Qual o retorno da seguinte função? 
minhasNotas_1(Exe_1=c(10,9,5,1,5,10), VA_1=8, Exe_2=7, Proj=7, VA_2=7, VA_3=10, Opt=1, threshold=7)

# Qual o retorno da seguinte função?
minhasNotas_1(Exe_1=NA, VA_1=8, Exe_2=c(10,1,5), Proj=10, VA_2=8, VA_3=10, Opt=2, threshold=8)

# Qual o retorno da seguinte função?
minhasNotas_1(Exe_1=c(10,9,7,1,NA,NA), VA_1=NA, Exe_2=7, Proj=7, VA_2=7, VA_3=10, Opt=1, threshold=7)

# Qual o retorno da seguinte função?
minhasNotas_1(Exe_1=NA, VA_1=8, Exe_2=NA, Proj=10, VA_2=8, VA_3=10, Opt=2, threshold=8)

# Qual o retorno da seguinte função?
minhasNotas_1(Exe_1=c(5,8), VA_1=8, Exe_2=c(10,1,5), Proj=10, VA_2=8, VA_3=2, Opt=3, threshold=8) 

# Qual o retorno da seguinte função?
minhasNotas_1(Exe_1=NA, VA_1=8, Exe_2=c(10,1,5), Proj=10, VA_2=8, VA_3=10, Opt=3, threshold=8)

# Qual o retorno da seguinte função?
minhasNotas_1(Exe_1=c(5,8), VA_1=8, Exe_2=c(10,1,5), Proj=c(2,4), VA_2=8, VA_3=2, Opt=3, threshold=8)

# Qual o retorno da seguinte função?
minhasNotas_1(Exe_1=10, VA_1=NA, Exe_2=7, Proj=7, VA_2=7, VA_3=10, Opt=1, threshold=7)







 
#################### Goddamnit >:( minhasNotas_2 ###############################
# Altere a função da questão anterior (chame “minhasNotas_2”) e determine as notas
# dos alunos de mestrado. As notas da 1 VA, 2VA e Média Final tem que ser dada de
# acordo com a descrição abaixo. Ou seja, a função deve retornar uma das seguintes
# notas: “A”, “B”, “C” ou” D”. Além disso, o “threshold” também é dado pelas siglas
# “A”, “B”, “C” e” D”. Considere o seguinte racional para as notas: “A”( Excelente)
# de 9,0 até 10,0; “B” (Bom) de 7,5 até 8,9;  “C” (Regular) de 6,0 até 7,4; e  “D”
# ( Reprovado) de 0,0 até 5,9. 
# 
# O protótipo dessa função é o seguinte: 
# minhasNotas_2 <- function(Exe_1=0, VA_1=0, Exe2=0, Proj=0, VA_2=0, 
# VA_3=0, Opt=1,threshold=”C”){}. Note que os erros devem ser tratado conforme 
# explicado anteriormente para a função "minhasNotas_1" (e.x.: opções ou notas
# inválidas). Porém, as mensagens de retorno dessa nova função devem seguir o 
# padrão explicado a seguir.  Por exemplo,  caso o aluno selecione a nota da 1 
# VA (Opt=1) as seguintes mensagens poderão ser apresentadas:  "Média da 1VA:  
# A - Acima da Média" ou “Aluno não possui nota para a 1 VA”. Se Opt=3 for 
# selecionada as seguintes mensagens poderão ser apresentadas: “Aluno não possui 
# nenhuma nota - Reprovado!!", “A - Aprovado!!" ou "D - Na Final!!". 
################################################################################


formatar_nota_mestrado <- function(nota) {
  nota_letra <- "D"
  if(nota >= 9 & nota <= 10) {
    nota_letra <- "A"
  }
  else if(nota >= 7.5 & nota <= 8.9) {
    nota_letra <- "B"
  }
  else if(nota >= 6 & nota <= 7.4) {
    nota_letra <- "C"
  }
  return(nota_letra)
}

minhasNotas_2 <- function(
  Exe_1, VA_1, Exe_2, Proj, 
  VA_2, VA_3, Opt, threshold){
  if(is.na(Opt) | is.na(threshold)) {
    return("Opção ou Threshold inválido!")
  }
  if(Opt < 1 | Opt > 3) {
    return("Opção de nota Inválida!")
  }
  aux <- c("A","B","C","D")
  if(length(aux[aux == threshold]) == 0) {
    return("Threshold Inválido!")
  }
  
  #exe1, va1, exe2, proj, va2
  pesos <- c(5,5,2,5,3) 
  notas <- c(NA,NA,NA)
  enum_notas <- data.frame(A=4,B=3,C=2,D=1)
  
  #Checando se existem notas invalidas: < 0 ou > 10
  aux <- c(VA_1, VA_2, VA_3, Proj)
  aux <- c(aux, Exe_1, Exe_2)
  aux[is.na(aux)] <- 0
  aux <- aux[aux < 0 | aux > 10]
  if(ifelse(length(aux) > 0, T, F)) {
    return("Notas Invalidas!")
  }
  
  Exe_1 <- c(Exe_1)
  VA_1 <- c(VA_1)
  Exe_2 <- c(Exe_2)
  Proj <- c(Proj)
  VA_2 <- c(VA_2)
  VA_3 <- c(VA_3)
  
  #Proj, 1va, 2va e 3va não podem ser lista
  if(length(VA_1) > 1 | length(Proj) > 1 | length(VA_2) > 1 | length(VA_3) > 1) {
    return("Quantidade de Notas Inválidas!")
  }
  
  ######## 1 VA ########
  #Checando se o aluno tem pelo menos uma nota na 1 va
  if((length(Exe_1[is.na(Exe_1)]) == length(Exe_1)) & is.na(VA_1)) {
    if(Opt == 1) {
      return("Aluno não possui nota para a 1 va")
    }
  } else {
    #se o if der falso, ele possui pelo meons uma nota na 1 va
    Exe_1[is.na(Exe_1)] <- 0
    VA_1[is.na(VA_1)] <- 0
    notas[1] <- (mean(Exe_1)*pesos[1] + VA_1*pesos[2])/(pesos[1]+pesos[2])
    if(Opt == 1) {
      nota <- formatar_nota_mestrado(notas[1])
      text <- paste("Média da 1VA:",nota)
      if(enum_notas[nota] < enum_notas[threshold]) {
        text <- paste(text, "- Abaixo da Média")
      } else if (enum_notas[nota] == enum_notas[threshold]) {
        text <- paste(text, "- Na Média")
      } else {
        text <- paste(text, "- Acima da Média")
      }
      return(text)
    }
  }
  
  ######## 2 VA ########
  # nota[2] <- pesos[3]*Exe_2 + pesos[4]*VA_2 + pesos[5]*Proj
  #Checando se o aluno tem pelo menos uma nota na 2 va
  if((length(Exe_2[is.na(Exe_2)]) == length(Exe_2)) & is.na(VA_2) & is.na(Proj)) {
    if(Opt == 2) {
      return("Aluno não possui nota para a 2 va")
    }
  } else {
    #se o if der falso, ele possui pelo meons uma nota na 2 va
    Exe_2[is.na(Exe_2)] <- 0
    Proj[is.na(Proj)] <- 0
    VA_2[is.na(VA_2)] <- 0
    notas[2] <- (mean(Exe_2)*pesos[3] + Proj*pesos[4] + VA_2*pesos[5])/(pesos[3]+pesos[4]+pesos[5])
    if(Opt == 2) {
      nota <- formatar_nota_mestrado(notas[2])
      text <- paste("Média da 2VA:",nota)
      if(enum_notas[nota] < enum_notas[threshold]) {
        text <- paste(text, "- Abaixo da Média")
      } else if (enum_notas[nota] == enum_notas[threshold]) {
        text <- paste(text, "- Na Média")
      } else {
        text <- paste(text, "- Acima da Média")
      }
      return(text)
    }
  }
  ######## 3 VA ########
  notas[3] <- VA_3
  if(all(is.na(notas))) {
    return("Aluno não possui nenhuma nota - Reprovado!!")
  }
  
  notas[is.na(notas)] <- 0
  notas <- sort(notas, decreasing = T)
  media_atual <- mean(c(notas[1],notas[2]))
  nota <- formatar_nota_mestrado(media_atual)
  if(enum_notas[nota] < enum_notas[threshold]) {
    return(paste(nota, "-- Na Final!!"))
  }
  return(paste(nota, "-- Aprovado!!"))
}

#Testando exemplo de saídas da função

minhasNotas_2(Exe_1 = 8, VA_1  = 9,  Exe_2 = 9, Proj  = 5,VA_2  = 4,  VA_3  = 1, Opt = 1,  threshold = "B")

minhasNotas_2(Exe_1 = 8, VA_1  = 9,  Exe_2 = 9, Proj  = 5,VA_2  = 4,  VA_3  = 1, Opt = 1,  threshold = "A")

minhasNotas_2(Exe_1 = NA, VA_1  = c(9,1),  Exe_2 = 9, Proj  = 5,VA_2  = 4,  VA_3  = 1, Opt = 1,  threshold = "A")

minhasNotas_2(Exe_1 = NA, VA_1  = 9,  Exe_2 = 9, Proj  = 5,VA_2  = 9,  VA_3  = 10, Opt = 3,  threshold = "C")

minhasNotas_2(Exe_1 = NA, VA_1  = 9,  Exe_2 = 9, Proj  = 5,VA_2  = 9,  VA_3  = 10, Opt = 3,  threshold = "A")




#### Questões ####

# Qual o retorno da seguinte função? 
minhasNotas_2(Exe_1=c(8,9,NA), VA_1=5, Exe_2=9, Proj=5, VA_2=4, VA_3=1, Opt=1, threshold="C")

# Qual o retorno da seguinte função? 
minhasNotas_2(Exe_1=c(8,9,10,9,9,8,6), VA_1=4, Exe_2=c(8,3,11,9,9,5), Proj=4, VA_2=4, VA_3=1, Opt=1, threshold="C")

# Qual o retorno da seguinte função? 
minhasNotas_2(Exe_1=c(8,9,10,9,9,8,6), VA_1=7, Exe_2=c(8,3,10,9,9,5), Proj=8, VA_2=3, VA_3=1, Opt=3, threshold="B")

# Qual o retorno da seguinte função? 
minhasNotas_2(Exe_1=c(8,9,10,9,9,8,6), VA_1=7, Exe_2=c(8,3,10,9,9,5), Proj=8, VA_2=8, VA_3=1, Opt=2, threshold="B") 

# Qual o retorno da seguinte função? 
minhasNotas_2(Exe_1=c(8,9,10,9,9,8,6), VA_1=7, Exe_2=c(8,3,10,9,9,5), Proj=5, VA_2=5, VA_3=10, Opt=4, threshold="B")
