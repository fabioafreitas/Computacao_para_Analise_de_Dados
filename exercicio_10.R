install.packages("dplyr")
install.packages("tidyr")

require(dplyr)
require(tidyr)

############### Exemplos ###############
aggregate(formula = Temp ~ Month,
          FUN = mean,
          subset = Wind < 10,
          data = airquality)


temp_by_month <- group_by(airquality, Month)
summarise(temp_by_month, maxfahrenheit=max(Temp))

############### Questoes comandos basicos DPLYR ##############

# Instale e carregue o pacote dplyr. Em seguida use o seguinte 
# comando para carregar os dados que irá trabalhar: 
#   df=data.frame(Theoph). Note que Wt: é o peso do sujeito 
# (kg); Dose: é a dose de teofilina administrada por via oral 
# ao indivíduo (mg / kg); Time: é o tempo desde a administração
# do medicamento quando a amostra foi coletada (h); e conc: é 
# concentração de teofilina na amostra(mg / L). Responda as 
# questões abaixo usando exclusivamente o pacote dplyr. Note que ao
# submeter a resposta remova todos os espaços em branco. Também 
# use um dos padrões a seguir: filter(dataset,<<>>) ou 
# dataset%>%filter(<<>>).
df=data.frame(Theoph)

#Qual o comando seleciona apenas a coluna Dose de df ? *
df%>%select(Dose)

#Qual o comando apresenta os dados para as doses maiores que 5 mg/kg ? *
df%>%filter(Dose>5)

#Qual o comando seleciona as linhas de 10-20 ?Dica: use o "slice". *
df%>%slice(c(10:20))

# Qual comando apresenta os dados para as doses maiores que 5
# e cujo o tempo desde a administração do medicamento (Time) 
# é maior que a média do mesmo? Use apenas um único comando. *
df%>%filter(Dose>5&Time>mean(Time))

#Qual comando organizar df por peso (decrescente) ? *
df%>%arrange(desc(Wt))

#Qual comando organizar df por peso (crescente) e tempo (decrescente) ? *
df%>%arrange(Wt&desc(Time))

#Qual comando cria uma nova coluna chamada "tendencia" que é igual à Time-mean(Time)? *
df%>%mutate(tendencia=Time-mean(Time))

#Qual comando apresenta a maior concentração de teofilina ? Não use nenhum nome para a coluna resultante. *
df%>%summarise(max(Dose))

############### DATASETS ATRASOS DE VOO ##############

# Para os exercícios abaixo, usaremos dois conjuntos de dados
# relacionados aos tempos de atraso de vôos do Bureau of 
# Transportation Statistics dos EUA 
# (X673598238_T_ONTIME_REPORTING e L_UNIQUE_CARRIERS.csv_). 
# Para carregar os dados é importante que vocês usem os seguintes
# argumentos: quote="\"", sep = "," . Note que a extensão ".csv_"
# está correta. O data frame do arquivo 
# (X673598238_T_ONTIME_REPORTING)  possui apenas informações da
# companhia aérea por código. No entanto, queremos saber os nomes
# das companhias aéreas. Assim, faça o merge dos datasets 
# "X673598238_T_ONTIME_REPORTING" e "L_UNIQUE_CARRIERS.csv_" 
# através das colunas "OP_UNIQUE_CARRIER" e "Code". Em seguida,
# responda as questões abaixo.

ONTIME_REPORTING_URL <- "https://www.dropbox.com/s/gi59a1nq3ga9gb7/673598238_T_ONTIME_REPORTING.csv?dl=1"
L_UNIQUE_CARRIERS_URL <- "https://www.dropbox.com/s/73bp8dl8nph6ufz/L_UNIQUE_CARRIERS.csv_?dl=1"
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
download.file(ONTIME_REPORTING_URL, "./datasets/673598238_T_ONTIME_REPORTING.csv")
download.file(L_UNIQUE_CARRIERS_URL, "./datasets/L_UNIQUE_CARRIERS.csv_")

Ontime_Reporting_Data <- read.csv(
  "./datasets/673598238_T_ONTIME_REPORTING.csv",
  header = T,
  strip.white = T,
  na.strings = "",
  quote="\"", 
  sep = ","
)

L_Unique_Carriers_Data <- read.csv(
  "./datasets/L_UNIQUE_CARRIERS.csv_",
  header = T,
  strip.white = T,
  na.strings = "",
  quote="\"", 
  sep = ","
)

Flight_Data <- merge(
  x=Ontime_Reporting_Data,
  y=L_Unique_Carriers_Data,
  by.x = "OP_UNIQUE_CARRIER",
  by.y = "Code",
  all=F
)
str(Flight_Data)
Flight_Data <- Flight_Data[c(1:5,7)]
Flight_Data$OP_UNIQUE_CARRIER <- as.factor(Flight_Data$OP_UNIQUE_CARRIER)
Flight_Data$ORIGIN <- as.factor(Flight_Data$ORIGIN)
Flight_Data$DEST <- as.factor(Flight_Data$DEST)

#Qual companhia teve o maior atraso ? *
Flight_Data %>% 
  filter(!is.na(DEP_DELAY_NEW)) %>% 
  filter(max(DEP_DELAY_NEW) == DEP_DELAY_NEW) %>% 
  select(Description)


#Qual companhia atrasa mais na média ? *
Flight_Data %>% 
      group_by(OP_UNIQUE_CARRIER) %>%
      filter(!is.na(DEP_DELAY_NEW)) %>% 
      summarise(media=mean(DEP_DELAY_NEW)) %>%
      arrange(media)

Flight_Data[
  Flight_Data$OP_UNIQUE_CARRIER == "B6",
]$Description[1]   #"JetBlue Airways"


#Qual companhia atrasa menos na média ? *
Flight_Data %>% 
  group_by(OP_UNIQUE_CARRIER) %>%
  filter(!is.na(DEP_DELAY_NEW)) %>% 
  summarise(media=mean(DEP_DELAY_NEW)) %>%
  arrange(desc(media))

Flight_Data[
  Flight_Data$OP_UNIQUE_CARRIER == "HA",
]$Description[1]   #"Hawaiian Airlines Inc."


#Qual companhia teve a maior proporção de atrasos ? *
#questoa anulada


################# DADOS TUBERCULOSE ################

# Você está encarregado de analisar um conjunto de 
# dados que contém casos de tuberculose (TB) relatados
# entre 1995 e 2013, ordenados por país, idade e sexo.
# O recurso mais exclusivo desses dados é o seu sistema
# de codificação. As colunas de três a vinte e três 
# codificam quatro partes separadas de informações em
# seus nomes de coluna: (i) As três primeiras letras 
# de cada coluna indicam se a coluna contém casos novos
# ou antigos de TB. (ii) As próximas duas letras 
# descrevem os tipos de casos que estão sendo contados.
# (iii) A sexta letra descreve o sexo dos pacientes 
# com tuberculose. Os números restantes descrevem a 
# faixa etária dos pacientes com TB. Carregue o conjunto
# de dados de http://stat405.had.co.nz/data/tb.csv 
# como um novo dataframe chamado TB. Observe que o 
# conjunto de dados TB é desordenado de várias maneiras.
# Primeiramente, mova os valores das colunas 3 até 23
# para uma única coluna chamada de “Informacao”. Dica
# use o gather (). Divida os conteúdos da variável 
# “informacao” em cada sublinhado(”_”). Dica use o 
# separate () e chame as colunas resultantes de "caso",
# "tipo” e "sexofaixa”. Por fim, divida a variável que 
# contém o sexo e a faixa etária 
# ("sexofaixa”) de modo a criar uma coluna de "sexo" 
# e uma coluna de "faixa". 
# De posse do data frame resultante, responda as 
# questões abaixo.

# http://stat405.had.co.nz/lectures/18-tidy-data.pdf
# What are the variables in this dataset?
# Discuss with your neighbour for 1 minute
# Hint: f = female, u = unknown, 1524 = 15-24
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
download.file("http://stat405.had.co.nz/data/tb.csv","./datasets/tb.csv")
Tb_data <- read.csv(
  file = "./datasets/tb.csv",
  na.strings = ""
)

Tb_data <- Tb_data %>%
  gather(key = "informacao", value = "valor", 3:23) %>%
  separate(col = informacao, into = c("caso","tipo","sexofaixa"), sep = "_") %>%
  separate(col = sexofaixa, into = c("sexo","faixa"), sep = 1)

#Qual foi a quantidade de casos para a Tailândia (TH) de pessoas do sexo Masculino? *
aux <- Tb_data %>% filter(iso2 == "TH" & sexo == "m")
sum(aux$valor, na.rm=T)

#questoa anulada
#Qual a proporção de casos para os estados unidos (US) ? Não considerar valores NAs. *
total <- sum(Tb_data$valor, na.rm=T)
total_eua <- sum(Tb_data[Tb_data$iso2 == "US",]$valor, na.rm=T)
total_eua/total  

#Qual a quantidade de casos para a faixa etária 2534 do sexo feminino? *
sum(Tb_data[Tb_data$faixa == "2534" & Tb_data$sexo == 'f',]$valor, na.rm = T)

#Qual foi a quantidade de casos para a década de 2000 ? A 
# década de 2000, também referida como anos 2000, 
# compreende o período de tempo entre 1 de janeiro de 2000
# e 31 de dezembro de 2009. *
sum(Tb_data[
    Tb_data$year == "2000" |
    Tb_data$year == "2001" |
    Tb_data$year == "2002" |
    Tb_data$year == "2003" |
    Tb_data$year == "2004" |
    Tb_data$year == "2005" |
    Tb_data$year == "2006" |
    Tb_data$year == "2007" |
    Tb_data$year == "2008" |
    Tb_data$year == "2009"
    ,
  ]$valor, 
  na.rm = T
)



