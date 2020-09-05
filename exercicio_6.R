#Quais comandos no R retornam um vetor das médias das variáveis 
#'Sepal.Length', 'Sepal.Width', 'Petal.Length' e 'Petal.Width' 
#do dataset iris (já incluído no R) ? *

apply(iris[ , 1:4], 1, FUN = mean)  #nao
apply(iris, 2, FUN = mean)          #nao
colMeans(iris)                      #nao
apply(iris[ , 1:4], 2, FUN = mean)  #sim
sapply(iris[ , 1:4], 2, FUN = mean) #sim
mapply(iris[ , 1:4], mean)          #nao
apply(iris[1:4, ], 2, FUN = mean)   #nao




# Quias comandos calcula a média do tamanho das pétalas (Petal.Length) de 
# acordo com as especies de iris (Species)? *
tapply(iris$Petal.Length, iris$Species, mean)    #sim
tapply(iris[,3], iris$Species, mean)             #sim
with(iris, tapply(Petal.Length, Species, mean))  #sim
sapply(iris, 2, mean)                            #nao
mapply(iris$Petal.Length, iris$Species, mean)    #nao
mean(iris$Petal.Length, iris$Species)            #nao

#Qual dos seguintes loops não necessita de uma condição no R? *
#Repeat

#Quantas vezes um loop while (T) {} é executado? *
#infinitas

#Qual é o valor de i após o loop for? for (i in 1:4){ } *
for (i in 1:4){ }
i #4

#Qual é o valor de i após o loop for? for (i in 1:4){ break } *
for (i in 1:4){ break }
i #1


#Qual é o valor de i após o loop for? for (i in 1:4 {next } *
for (i in 1:4){ next }
i #4


# Use o 'mapply' para obter uma lista de 10 elementos. A lista é uma alternação
# entre 'Rural' e 'Amo'. O comprimento desses 10 elementos diminuem de 10 para 1 
# (ver abaixo a saída). OBS.: Ao submeter o comando, retire todos os espaço em 
# branco. *
mapply(rep,c("Rural","Amo"),10:1)


# Qual deve ser o código em print para que as seguintes sequências sejam 
# impressas: 1:10, 2:11 e 3:12(ver abaixo a saída)? OBS.: Ao submeter o código, 
# retire todos os espaço em branco e não use parênteses. *
for(i in 1:length(1:3)) {
  for(j in 1:10) {
    print(i+j-1)
  }
}

# Crie o data frame 'student.df' com os dados fornecidos a seguir: 
#   student.df = data.frame (
#     nome= c ("Sue", "Eva", "Henry", "Jan"), 
#     sexo= c ("f", "f", "m", "m"), 
#     anos= c (21,15,17,19)). 
# Use a função "ifelse" para adicionar os elementos de uma nova coluna chamada 
# de "menor". Essa coluna, que deve ser adicionada ao data frame, é uma coluna 
# lógica, indicando "V" se a observação for um homem ("m") com menos de 18 anos. 
# Caos contrário, atribua "F" (veja o resultado esperado abaixo). Digite apenas 
# uma linha de código correspondente a toda essa ação. Note que você deve tirar 
# todos os espaços em branco e a coluna "menor" deve ser atribuída ao data frame 
# através do operador "$". Além disso, as colunas do data frame devem ser 
# acessadas pelo nome e usem aspas duplas. *
  
student.df = data.frame (
    nome= c ("Sue", "Eva", "Henry", "Jan"), 
    sexo= c ("f", "f", "m", "m"), 
    anos= c (21,15,17,19)
)

student.df$menor<-ifelse(student.df["sexo"]=="m"&student.df["anos"]<18,T,F)


# Qual o comando usando a família apply você consegue obter a soma de cada um dos
# crimes contido no dataset USArrests(já incluído no R) com a saída igual a 
# apresentada abaixo? OBS.: Ao submeter o código, retire todos os espaço em branco. *
apply(USArrests,2,sum)


# Qual o resultado do código abaixo ? *
x = 0
a = 0
b = -5
if(a>0) {
  if(b<0) {
    x = x + 5
  } else if (a > 5) {
    x = x + 4
  } else {
    x = x + 3
  }
} else {
  x = x + 2
}
print(x)



# Qual a resposta correta ? *
x = 0
while(x < 100) {
  x=x+2
}
print(x)
