# Crie os vetores a seguir: 
# ‘mouse.color' com os valores: ‘purple’, ‘red’, ‘yellow’,‘brown’; ‘mouse.weight’ 
# com os valores 23, 21, 18, 26. Crie um data frame chamado de ‘mouse.info’ com 
# esses vetores, formando 4 linhas e 2 colunas. Nomeie a primeira coluna para 
# ‘colour’ e a segunda para ‘weight’. De posse desse data frame, responda as 
# perguntas abaixo. OBS.: Ao submeter o comando, retire todos os espaço em branco. 

mouse.color <- c("purple", "red", "yellow", "brown")
mouse.weight <- c(23,21,18,26)
mouse.info <- data.frame("colour" = mouse.color, "weight" = mouse.weight)

#Qual comando imprima a estrutura do data frame no console ? *
str(mouse.info)

#Qual comando imprima apenas a linha 3 no console ? *
mouse.info[3,]

#Qual comando imprima apenas a coluna 1 no console ? *
mouse.info[,1]

#Qual comando imprima o item na linha 4 da coluna 1 ? *
mouse.info[4,1]


#Para as questões abaixo use o dataset airquality já incluído no RStudio.

#Qual foi o valor mínimo de ozônio no mês de maio ? *
airquality_maio <- airquality[airquality$Month == 5,]
aux <- airquality_maio[!is.na(airquality_maio$Ozone),]
min(aux$Ozone)

#Extraia o subconjunto do data frame em que os valores de Ozônio estão acima de
# 25 e os valores da temperatura (Temp) estão abaixo de 90. Qual é a média do 
# Solar.R nesse subconjunto? *
aux <- airquality[airquality$Ozone > 25 & airquality$Temp < 90,]
aux <- aux[!is.na(aux$Solar.R),]
mean(aux$Solar.R)

# Qual a quantidade de casos completos no dataset airquality ? Ou seja, 
# a quantidade de observação (linhas) sem NAs. *
nrow(airquality[complete.cases(airquality), ])


# Carregue o arquivo genomes.csv numa variável chamada genomas através do seguinte comando: 
# genomas <- as.data.frame(read.csv("https://www.dropbox.com/s/vgh6qk395ck86fp/genomes.csv?dl=1")). 
# De posse desse dado, responda as perguntas abaixo. 
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
genomas <- as.data.frame(read.csv("genomes.csv"))

# Selecione os organismos com mais de 40 cromossomos. *
aux <- genomas[genomas$Chromosomes > 40,]
aux[
  aux$Organism == "Carassius auratus" |
  aux$Organism ==  "Thymallus thymallus" |
  aux$Organism ==  "Abisko virus" |
  aux$Organism ==  "Absidia repens" |
  aux$Organism ==  "Abutilon Brazil virus",
]$Organism

#Selecione os organismos que contém plasmídeos e também possui mais de um cromossomo. *
aux <- genomas[genomas$Plasmids > 0 & genomas$Chromosomes > 1,]
aux[
  aux$Organism == "Yangia" |
  aux$Organism ==  "Vibrio tubiashii" |
  aux$Organism ==  "Acidipila" |
  aux$Organism ==  "Vibrio scophthalmi" |
  aux$Organism ==  "Acidimicrobiales bacterium",
]$Organism
      
#Quantos grupos diferentes existem?
length(levels(as.factor(genomas$Groups)))

# Carregue o arquivo cancer_stats.csv numa variável chamada cancer_stats através 
# do seguinte comando: 
# cancer_stats <- as.data.frame(read.csv("https://www.dropbox.com/s/g97bsxeuu0tajkj/cancer_stats.csv?dl=1")). 
# De posse desse dado, responda as perguntas abaixo.
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
cancer_stats <- as.data.frame(read.csv("cancer_stats.csv")) 

# Para qual local do câncer (site) do sistema digestivo (Digestive System) existem mais casos femininos do que masculinos? *
aux <- cancer_stats[cancer_stats$Class == "Digestive System",]
aux[aux$Female.Cases > aux$Male.Cases,]$Site

# Qual local do câncer tem a melhor taxa de sobrevivência para os homens? *
score_padronizado <- function(v) {
  return((v - mean(v))/sd(v))
}
aux <- cancer_stats[,c("Site","Male.Cases","Male.Deaths")]
aux <- aux[!is.na(aux$Male.Cases) | !is.na(aux$Male.Deaths),]
aux$score <- (score_padronizado(aux$Male.Cases)+score_padronizado(aux$Male.Deaths))/2
aux <- aux[
  aux$Site == "Eosophagus" | 
    aux$Site == "Prostate" | 
    aux$Site == "heart" | 
    aux$Site == "Testis",
]
aux[which.max(aux$score),]$Site

# Qual local do câncer tem a melhor taxa de sobrevivência para os homens? *
score_padronizado <- function(v) {
  return((v - mean(v))/sd(v))
}
aux <- cancer_stats[,c("Site","Female.Cases","Female.Deaths")]
aux <- aux[!is.na(aux$Female.Cases) | !is.na(aux$Female.Deaths),]
aux$score <- (score_padronizado(aux$Female.Cases)+score_padronizado(aux$Female.Deaths))/2
aux <- aux[
  aux$Site == "pancreas" | 
    aux$Site == "thyroid" | 
    aux$Site == "ureter" | 
    aux$Site == "breast",
]
aux[which.min(aux$score),]$Site

