################# INICIO ################# 

# Carregue o dataset do link abaixo. Esse dataset contém informações do peso do 
# coração e corporal de 97 gatos adultos que foram usados para experimentos com
# a droga "digitalis". Com posse desses dados responda as perguntas abaixo. Qual
# foi a média do peso dos gatos (Bwt) ?
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
catsM <- as.data.frame(read.csv("./datasets/catsM.csv"))
mean(catsM$Bwt) #2.9

################# CHECAGEM E LIMPEZA DE DADOS ################# 

# Para as questões abaixo considere o dataset 
# "Caracol_data_checked.csv". Note que para você 
# obter esse dataset você precisa executar todos 
# os passos apresentado na aula de Manipulação Básica.
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
download.file(
  url = "https://www.dropbox.com/s/c6nhu4v7yq9pyto/Snail_feeding.csv?dl=1", 
  destfile = "./datasets/Snail_feeding.csv"
)
Caracol_data <- read.csv(
  file = "./datasets/Snail_feeding.csv",
  header = T,
  strip.white = T,
  na.strings = ""
)   

#retirando colunas desnecessárias
str(Caracol_data)
Caracol_data <- Caracol_data[,1:7]

#corrigindo coluna sex
Caracol_data$Sex <- as.factor(Caracol_data$Sex)
Caracol_data$Size <- as.factor(Caracol_data$Size)
Caracol_data$Distance <- as.factor(Caracol_data$Distance)

unique(Caracol_data$Sex)
levels(Caracol_data$Sex)

    #os index vao se ajustando a medida que levels
    #repetidos vão sendo adicionados
levels(Caracol_data$Sex)[2] <- "female"
levels(Caracol_data$Sex)[3] <- "male"
levels(Caracol_data$Sex)[3] <- "male"

#convertento a coluna distance de factor para numeric 
#e corrigindo os NAs por coeção
Caracol_data[682, "Distance"] <- 0.58
Caracol_data[755, "Distance"] <- 0.356452
Caracol_data$Distance <- as.character(Caracol_data$Distance)
Caracol_data$Distance <- as.numeric(Caracol_data$Distance)

#localizando e removento dados duplicados
which(duplicated(Caracol_data))
index <- which(duplicated(Caracol_data))
Caracol_data <- Caracol_data[-index,]

#corridindo informações discrepantes
summary(Caracol_data)
Caracol_data[which(Caracol_data$Depth > 2),]
Caracol_data[8,"Depth"] <- 1.62




################# QUESTOES CARACOL DATA ################# 

#Qual a média da profundidade (depth) dos caracóis marinhos? *
mean(Caracol_data$Depth)

#Qual foi a maior distância coletada para o Caracol Marinho Pequeno e Feminino ? *
query <- which(Caracol_data$Size == "small" & Caracol_data$Sex == "female")
max(Caracol_data[query,]$Distance)

################# QUESTOES DO DATASET SPARROW ################# 

#Para as questões abaixo carregue os dados do dataset Sparrows.csv.
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
download.file(
  url = "https://www.dropbox.com/s/jci311cfsj6uva7/Sparrows.csv?dl=1", 
  destfile = "./datasets/Sparrows.csv"
)


#questao 1
# O arquivo de dados Sparrows.csv contém medidas de asa, tarso, 
# cabeça e bico de duas espécies de pardal. Use 
# read.table(file = "Sparrows.csv", header = TRUE) para carregar
# os dados para um objeto chamado Sparrows. Depois, use a função 
# View () para exibir os dados. Note que algo deu errado! Todas 
# as variáveis foram combinadas em uma grande coluna. Qual foi o
# problema ?
Sparrow <- read.table(file = "./datasets/Sparrows.csv", header = TRUE)
View(Sparrow)

#Resposta: Faltou o argumento sep=",".
Sparrow <- read.table(file = "./datasets/Sparrows.csv", header = TRUE, sep = ',')
View(Sparrow)



# Qual o tamanho mínimo e máximo da cabeça da especie "SSTS" ? *
min(Sparrow_data[Sparrow_data$Species == "SSTS",]$Head) #29.2
max(Sparrow_data[Sparrow_data$Species == "SSTS",]$Head) #33.5



# Durante a entrada de dados, três linhas foram inseridas duas vezes. 
# Quais são essas linhas duplicadas? *
Sparrow <- read.csv(
  file = "./datasets/Sparrows.csv",
  header = T,
  strip.white = T,
  na.strings = "",
) 
which(duplicated(Sparrow))


# Exiba os níveis do fator Sex. Veja que os níveis estão bagunçados. 
# Altere de modo que a variável sexo contenha apenas os níveis
# "Male" e "Female". Por exemplo, "Femal" deve ser "Female". Após
# isso, determine qual é a media do tarso dos pardais femininos 
# e masculinos. *
Sparrow$Species <- as.factor(Sparrow$Species)
Sparrow$Sex <- as.factor(Sparrow$Sex)
levels(Sparrow$Sex)[1] <- "Female"
levels(Sparrow$Sex)[2] <- "Female"
levels(Sparrow$Sex)[3] <- "Male"

mean(Sparrow[Sparrow$Sex == "Female",]$Tarsus)
mean(Sparrow[Sparrow$Sex == "Male",]$Tarsus)




# Digite o comando que verifica quais linhas na variável Wing contém NAs.
# Use a função which. OBS.: Remova todos os espaços em branco. *
which(is.na(Sparrow$Wing))



#Substitua todos os NAs da questão anterior pelos valores 59, 56.5 e 57 
# (nessa ordem). Qual a média das asas dos pardais ? *
Sparrow$Wing[64] <- 59
Sparrow$Wing[250] <- 56.5
Sparrow$Wing[806] <- 57
mean(Sparrow$Wing)



#Qual o comando ordena o data frame pelas colunas Wing e Head e crie um novo 
#objeto chamado de Sparrows_Ordenado ? *
Sparrows_Ordenado<-Sparrow[order(Sparrow$Wing,Sparrow$Head),]
