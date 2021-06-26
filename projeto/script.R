##### DOWNLOAD E IMPORTAÇÃO DE BIBLIOTECAS ####
#Download packages if not installed
list.of.packages <- c("kableExtra","viridis", "ggplot2", "rmdformats", "rmarkdown", "dplyr", "tidyr", "readr", "knitr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Import packages from list
lapply(list.of.packages, require, character.only = TRUE)

##### DOWNLOAD DO DATASET #####

#Dataset Urls e filenames
dataset <- data.frame(
  "url"=c(
    "http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/5eaed1e8-aa7f-48d7-9512-638f80874870/download/sedec_chamados.csv",   
    "http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/bb4b8cdb-122b-491a-80f7-b028b66108e1/download/sedec_vistorias.csv",
    "http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/48dd7535-329c-4a6a-bb2d-f26ebb1ab531/download/sedec_lonas.csv",
    "http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/fa35d810-b291-4e74-9282-3c4db1aca312/download/sedec_solicitacoes.csv",
    "http://dados.recife.pe.gov.br/dataset/45dbabee-0352-411a-b289-66fccde8942a/resource/7a22d871-250e-419a-9b5a-1cab19db7be5/download/sedec_tipo_ocorrencias.csv"
  ),
  "filename"=c(
    "sedec_chamados.csv",
    "sedec_vistorias.csv",
    "sedec_lonas.csv",
    "sedec_solicitacoes.csv",
    "sedec_tipo_ocorrencias.csv"
  )
) 

#Setting path to current directory "./"
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#create folders if not exists
dir.create("./dataset")

#Download the dataset files if not exists
for (i in 1:nrow(dataset)) {
  url <- dataset$url[i]
  filepath <- paste("./dataset/", dataset$filename[i], sep='')
  if(!file.exists(filepath)) {
    download.file(url, filepath)
  }
}

##### OPENING DATASET CSVS #####

data_chamados <- read_csv2("./dataset/sedec_chamados.csv")
data_vistorias <- read_csv2("./dataset/sedec_vistorias.csv")
data_lonas <- read_csv2("./dataset/sedec_lonas.csv")
data_solicitacoes <- read_csv2("./dataset/sedec_solicitacoes.csv")
data_tipo_ocorrencias <- read_csv2("./dataset/sedec_tipo_ocorrencias.csv")

data_solicitacoes$processo_solicitacao <- as.factor(data_solicitacoes$processo_solicitacao)
levels(data_solicitacoes$processo_solicitacao)


data_chamados <- data_chamados %>% select(                       
  "processo_numero",            
  "solicitacao_data",         
  "solicitacao_bairro",
  "solicitacao_vitimas",        
  "solicitacao_vitimas_fatais",
  "processo_situacao",          
  "processo_tipo",
  "processo_status",            
  "processo_data_conclusao"
)

data_chamados$solicitacao_bairro <- as.factor(data_chamados$solicitacao_bairro)
levels(data_chamados$solicitacao_bairro)

data_chamados$processo_situacao <- as.factor(data_chamados$processo_situacao)
levels(data_chamados$processo_situacao)

data_chamados$processo_tipo <- as.factor(data_chamados$processo_tipo)
levels(data_chamados$processo_tipo)

data_chamados$processo_status <- as.factor(data_chamados$processo_status)
levels(data_chamados$processo_status)[2] <- "CONCLUÍDO"
levels(data_chamados$processo_status)[4] <- "TRAMITAÇÃO"
levels(data_chamados$processo_status)[6] <- "TRAMITAÇÃO"
levels(data_chamados$processo_status)

data_chamados[c(1, 100,300,5000,9000,30000),c(
  "solicitacao_data", 
  "solicitacao_bairro",
  "solicitacao_vitimas",
  "solicitacao_vitimas_fatais",
  "processo_status",            
  "processo_data_conclusao"
)]

aux_chamados <- read_csv2("./dataset/sedec_chamados.csv", col_types = cols())
rows_chamados <- colnames(aux_chamados)
rows_solicitacoes <- colnames(data_solicitacoes)
data_solicitacoes <- data_solicitacoes %>% select("processo_numero", setdiff(rows_solicitacoes, rows_chamados))

data_chamados <- merge(
  x=data_chamados,
  y=data_solicitacoes,
  by="processo_numero",
  all=F
)

#verificar se todos os chamados estão em data vistorias

levels(as.factor(data_chamados$processo_status))
colnames(data_chamados)
colnames(data_vistorias)

levels(as.factor(data_tipo_ocorrencias$processo_ocorrencia))
colnames(data_solicitacoes)
colnames(data_tipo_ocorrencias)
colnames(data_lonas)
##### tipos de solicitações de processos #####

levels(as.factor(data_solicitacoes$processo_solicitacao))

##### todas as vistorias estão contidas em solicitações ? #####

aux <- merge(
  x=data_vistorias,
  y=data_solicitacoes,
  by="processo_numero",
  all=F
)
nrow(aux)
nrow(data_vistorias)

##### analisando data_chamados #####

aux <- data_chamados %>% select("solicitacao_origem_chamado",             
                         "solicitacao_vitimas"    ,    
                         "solicitacao_vitimas_fatais",
                         "processo_localizacao"  ,    
                         "processo_status"     ,       
                         "processo_data_conclusao" ,
                         "latitude"    ,               
                         "longitude" )

##### contar numero de chamados por categoria de ocorrencia #####

data_tipo_ocorrencias %>% count(processo_ocorrencia)

##### contar numero de vitimas por categoria de ocorrencia #####

aux <- merge(
  x=data_chamados,
  y=data_tipo_ocorrencias,
  by="processo_numero",
  all=F
)
aux
##### contar numero de vitimas fatais por categoria de ocorrencia #####

##### dentre os chamados que existem em solicitações, quais sãos os tipos de chamados aplicados? ####

aux <- merge(
  x=data_chamados,
  y=data_solicitacoes,
  by="processo_numero",
  all=F
)
nrow(aux)
levels(as.factor(
  aux$processo_solicitacao
))



for(i in 1:length(rows_chamados)) {
  
}