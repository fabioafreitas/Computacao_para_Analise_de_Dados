list.of.packages <- c("dplyr", "tidyr", "ggplot2", "AER", "readr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

require("dplyr")
require("tidyr")
require("ggplot2")
require("AER")
require("readr")
library(stringr)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

gambler_url   <- "https://www.dropbox.com/s/ed4kb56305t1udj/gambler.txt?dl=1"
catfish_url   <- "https://www.dropbox.com/s/mqc1x7sc4cuukv0/Catfish.csv?dl=1"
forbes_url    <- "https://www.dropbox.com/s/rl86524vniqb8fh/Forbes2000_V2.csv?dl=1"
treatment_url <- "https://www.dropbox.com/s/0heut39hfpwf7jc/Treatment.csv?dl=1"
tb_url        <- "https://www.dropbox.com/s/nm0pvzv07444c4u/tb.csv?dl=1"

download.file(gambler_url, "./datasets/gambler.txt")
download.file(catfish_url, "./datasets/Catfish.csv")
download.file(forbes_url, "./datasets/Forbes2000_V2.csv")
download.file(treatment_url, "./datasets/Treatment.csv")
download.file(tb_url, "./datasets/tb.csv")


#1º
strg <- c("Voda 30", "bylinky 25", "ZEM 23", "zlAto 22")
paste(tolower(strg),'%',sep='')


#2º
grep(pattern="^([0-9][[:punct:]][a-z])",x="5!eAZ")        #sim
grep(pattern="^([0-9][[:punct:]][a-z])",x="!6!rrrrDFGT")     
grep(pattern="^([0-9][[:punct:]][a-z])",x="R99Tf34!RR")   
grep(pattern="^([0-9][[:punct:]][a-z])",x="123?aSd")


#3º
gambler <- read_file("./datasets/gambler.txt")
nchar(gambler) #2569

#4º
urls <- c ("www.dogman.com", "http://rotterdam.com", "https://facebook.com", "httpx://sims.com", "fungame.http")
urls[grep(pattern="https?:",urls)]


ds<- read.csv(
  "./datasets/Forbes2000_V2.csv",
  header = T,
  strip.white = T,
  na.strings = "",
  quote="\"", 
  sep = ","
)

ranqueamento <- function(ranque, categoria=NULL, opcao){
  switch(opcao, 
         arrange(ds, desc(ds$marketvalue))[ranque,],
         filter(arrange(ds, desc(ds$marketvalue)), arrange(ds, desc(ds$marketvalue))$category %in% categoria)[ranque,]
  )
}

#5º
View(ranqueamento(ranque=1234, opcao=1) )

#6º
View(ranqueamento(ranque=198, opcao=1))

#7º
View(ranqueamento(ranque=45, categoria="Technology hardware & equipment", opcao=2))

#8º (porém resposta é categoria nao existe)
View(ranqueamento(ranque=7, categoria="Bancos", opcao=2))

#9º
6512
#10º
"H"

#11º
0.25567297


data("Fertility")
#12º
Fertility%>%slice(35:50)%>%select(age,work)     


#13º
0.103191

#14º
0.5036608

aux <- read.csv("https://www.dropbox.com/s/mqc1x7sc4cuukv0/Catfish.csv?dl=1")
aux2 <- read.csv("https://www.dropbox.com/s/0heut39hfpwf7jc/Treatment.csv?dl=1")
head(aux)
head(aux2)

df <- merge(x=aux, y=aux2, by.x = "Tank", by.y = "Tank")

df <- mutate(df,Weight=March+April)

df <- mutate(df, Species=paste(Genus, ".", Species, ".", sep = ""))

Catfish_Treatment <- df

summary(Catfish_Treatment%>%filter(Sex =="Male" & Food == "Treatment2"))
#15º
72.1

#16º
Catfish_Treatment$AcimaMedia<-ifelse(Catfish_Treatment$Weight>mean(Catfish_Treatment$Weight),"V","F")

#17º
"todos os tankes possuem a mesma media"

#18º
Joaquina

#19º
111

#20º
aux <- read.csv("./datasets/tb.csv")
aux <- aux%>%slice(1348:4954)
nrow(aux[complete.cases(aux),])

