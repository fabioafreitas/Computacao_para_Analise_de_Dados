install.packages("tm")
install.packages("readr")
install.packages("wordcloud")

library(tm)
library(readr)
library(wordcloud)

###################### VIDEO AULA 1 ##############################

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#importação que já corrige os acentos e caracteres especiais
motivos <- read_csv("./datasets/motivos.csv")

#juntar todos os dados ca coluna 2019.1
motivos <- paste(motivos$"2019.1", collapse = " ")

#converter a nuvem de palavras para um corpus (para a lib tm)
VS <- VectorSource(motivos)
corpus <- Corpus(VS)
inspect(corpus)

#
#   limpeza dos dados
#

#convertendo tudo para minúsculo
corpus <- tm_map(corpus, content_transformer(tolower))

#removendo pontuação
corpus <- tm_map(corpus, removePunctuation)

#removendo espaços extras em branco
corpus <- tm_map(corpus, stripWhitespace)

#removendo números
corpus <- tm_map(corpus, removeNumbers)

#removendo palavras ruido (stopwords)
corpus <- tm_map(corpus, removeWords, stopwords('portuguese'))

inspect(corpus)

#convertendo em matriz para indicar a frequencia de cada palavras
tdm <- as.matrix(TermDocumentMatrix(corpus))

#ordenando pela frequencia
fre <- sort(rowSums(tdm), decreasing = T)

#escolhendo um subconjunto de dados
aux <- subset(fre, fre>2)

#plota um gráfico de barras dos termos mais frequentes
barplot(aux, las=2, col=rainbow(10))


#nuvem de palavras
wordcloud(
  corpus, 
  min.freq = 1,
  max.words=60,
  random.order=F,
  rot.per=0.35,
  colors=brewer.pal(8, "Dark2")
)


###################### EXERCICIO MARTIN LUTHER KING #####

library(tm)
library(wordcloud)
library(readr)

discurso <- "Eu estou contente em unir-me com vocês no dia que entrará para a história como a maior demonstração pela liberdade na história de nossa nação.

Cem anos atrás, um grande americano, na qual estamos sob sua simbólica sombra, assinou a Proclamação de Emancipação. Esse importante decreto veio como um grande farol de esperança para milhões de escravos negros que tinham murchados nas chamas da injustiça. Ele veio como uma alvorada para terminar a longa noite de seus cativeiros.
Mas cem anos depois, o Negro ainda não é livre.
Cem anos depois, a vida do Negro ainda é tristemente inválida pelas algemas da segregação e as cadeias de discriminação.
Cem anos depois, o Negro vive em uma ilha só de pobreza no meio de um vasto oceano de prosperidade material. Cem anos depois, o Negro ainda adoece nos cantos da sociedade americana e se encontram exilados em sua própria terra. Assim, nós viemos aqui hoje para dramatizar sua vergonhosa condição.

De certo modo, nós viemos à capital de nossa nação para trocar um cheque. Quando os arquitetos de nossa república escreveram as magníficas palavras da Constituição e a Declaração da Independência, eles estavam assinando uma nota promissória para a qual todo americano seria seu herdeiro. Esta nota era uma promessa que todos os homens, sim, os homens negros, como também os homens brancos, teriam garantidos os direitos inalienáveis de vida, liberdade e a busca da felicidade. Hoje é óbvio que aquela América não apresentou esta nota promissória. Em vez de honrar esta obrigação sagrada, a América deu para o povo negro um cheque sem fundo, um cheque que voltou marcado com fundos insuficientes.

Mas nós nos recusamos a acreditar que o banco da justiça é falível. Nós nos recusamos a acreditar que há capitais insuficientes de oportunidade nesta nação. Assim nós viemos trocar este cheque, um cheque que nos dará o direito de reclamar as riquezas de liberdade e a segurança da justiça.

Nós também viemos para recordar à América dessa cruel urgência. Este não é o momento para descansar no luxo refrescante ou tomar o remédio tranqüilizante do gradualismo.
Agora é o tempo para transformar em realidade as promessas de democracia.
Agora é o tempo para subir do vale das trevas da segregação ao caminho iluminado pelo sol da justiça racial.
Agora é o tempo para erguer nossa nação das areias movediças da injustiça racial para a pedra sólida da fraternidade. Agora é o tempo para fazer da justiça uma realidade para todos os filhos de Deus.

Seria fatal para a nação negligenciar a urgência desse momento. Este verão sufocante do legítimo descontentamento dos Negros não passará até termos um renovador outono de liberdade e igualdade. Este ano de 1963 não é um fim, mas um começo. Esses que esperam que o Negro agora estará contente, terão um violento despertar se a nação votar aos negócios de sempre

. Mas há algo que eu tenho que dizer ao meu povo que se dirige ao portal que conduz ao palácio da justiça. No processo de conquistar nosso legítimo direito, nós não devemos ser culpados de ações de injustiças. Não vamos satisfazer nossa sede de liberdade bebendo da xícara da amargura e do ódio. Nós sempre temos que conduzir nossa luta num alto nível de dignidade e disciplina. Nós não devemos permitir que nosso criativo protesto se degenere em violência física. Novamente e novamente nós temos que subir às majestosas alturas da reunião da força física com a força de alma. Nossa nova e maravilhosa combatividade mostrou à comunidade negra que não devemos ter uma desconfiança para com todas as pessoas brancas, para muitos de nossos irmãos brancos, como comprovamos pela presença deles aqui hoje, vieram entender que o destino deles é amarrado ao nosso destino. Eles vieram perceber que a liberdade deles é ligada indissoluvelmente a nossa liberdade. Nós não podemos caminhar só.

E como nós caminhamos, nós temos que fazer a promessa que nós sempre marcharemos à frente. Nós não podemos retroceder. Há esses que estão perguntando para os devotos dos direitos civis, Quando vocês estarão satisfeitos?

Nós nunca estaremos satisfeitos enquanto o Negro for vítima dos horrores indizíveis da brutalidade policial. Nós nunca estaremos satisfeitos enquanto nossos corpos, pesados com a fadiga da viagem, não poderem ter hospedagem nos motéis das estradas e os hotéis das cidades. Nós não estaremos satisfeitos enquanto um Negro não puder votar no Mississipi e um Negro em Nova Iorque acreditar que ele não tem motivo para votar. Não, não, nós não estamos satisfeitos e nós não estaremos satisfeitos até que a justiça e a retidão rolem abaixo como águas de uma poderosa correnteza.

Eu não esqueci que alguns de você vieram até aqui após grandes testes e sofrimentos. Alguns de você vieram recentemente de celas estreitas das prisões. Alguns de vocês vieram de áreas onde sua busca pela liberdade lhe deixaram marcas pelas tempestades das perseguições e pelos ventos de brutalidade policial. Você são o veteranos do sofrimento. Continuem trabalhando com a fé que sofrimento imerecido é redentor. Voltem para o Mississippi, voltem para o Alabama, voltem para a Carolina do Sul, voltem para a Geórgia, voltem para Louisiana, voltem para as ruas sujas e guetos de nossas cidades do norte, sabendo que de alguma maneira esta situação pode e será mudada. Não se deixe caiar no vale de desespero.

Eu digo a você hoje, meus amigos, que embora nós enfrentemos as dificuldades de hoje e amanhã. Eu ainda tenho um sonho. É um sonho profundamente enraizado no sonho americano.

Eu tenho um sonho que um dia esta nação se levantará e viverá o verdadeiro significado de sua crença - nós celebraremos estas verdades e elas serão claras para todos, que os homens são criados iguais.

Eu tenho um sonho que um dia nas colinas vermelhas da Geórgia os filhos dos descendentes de escravos e os filhos dos desdentes dos donos de escravos poderão se sentar junto à mesa da fraternidade.

Eu tenho um sonho que um dia, até mesmo no estado de Mississippi, um estado que transpira com o calor da injustiça, que transpira com o calor de opressão, será transformado em um oásis de liberdade e justiça.

Eu tenho um sonho que minhas quatro pequenas crianças vão um dia viver em uma nação onde elas não serão julgadas pela cor da pele, mas pelo conteúdo de seu caráter. Eu tenho um sonho hoje!

Eu tenho um sonho que um dia, no Alabama, com seus racistas malignos, com seu governador que tem os lábios gotejando palavras de intervenção e negação; nesse justo dia no Alabama meninos negros e meninas negras poderão unir as mãos com meninos brancos e meninas brancas como irmãs e irmãos. Eu tenho um sonho hoje!

Eu tenho um sonho que um dia todo vale será exaltado, e todas as colinas e montanhas virão abaixo, os lugares ásperos serão aplainados e os lugares tortuosos serão endireitados e a glória do Senhor será revelada e toda a carne estará junta.

Esta é nossa esperança. Esta é a fé com que regressarei para o Sul. Com esta fé nós poderemos cortar da montanha do desespero uma pedra de esperança. Com esta fé nós poderemos transformar as discórdias estridentes de nossa nação em uma bela sinfonia de fraternidade. Com esta fé nós poderemos trabalhar juntos, rezar juntos, lutar juntos, para ir encarcerar juntos, defender liberdade juntos, e quem sabe nós seremos um dia livre. Este será o dia, este será o dia quando todas as crianças de Deus poderão cantar com um novo significado.

Meu país, doce terra de liberdade, eu te canto.

Terra onde meus pais morreram, terra do orgulho dos peregrinos,

De qualquer lado da montanha, ouço o sino da liberdade!

E se a América é uma grande nação, isto tem que se tornar verdadeiro.

E assim ouvirei o sino da liberdade no extraordinário topo da montanha de New Hampshire.

Ouvirei o sino da liberdade nas poderosas montanhas poderosas de Nova York.

Ouvirei o sino da liberdade nos engrandecidos Alleghenies da Pennsylvania.

Ouvirei o sino da liberdade nas montanhas cobertas de neve Rockies do Colorado.

Ouvirei o sino da liberdade nas ladeiras curvas da Califórnia.

Mas não é só isso. Ouvirei o sino da liberdade na Montanha de Pedra da Geórgia.

Ouvirei o sino da liberdade na Montanha de Vigilância do Tennessee.

Ouvirei o sino da liberdade em todas as colinas do Mississipi.

Em todas as montanhas, ouviu o sino da liberdade.

E quando isto acontecer, quando nós permitimos o sino da liberdade soar, quando nós deixarmos ele soar em toda moradia e todo vilarejo, em todo estado e em toda cidade, nós poderemos acelerar aquele dia quando todas as crianças de Deus, homens pretos e homens brancos, judeus e gentios, protestantes e católicos, poderão unir mãos e cantar nas palavras do velho spiritual negro:

Livre afinal, livre afinal.

Agradeço ao Deus todo-poderoso, nós somos livres afinal."

VS <- VectorSource(discurso)
corpus <- Corpus(VS)
inspect(corpus)

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords('portuguese'))
tdm <- as.matrix(TermDocumentMatrix(corpus))
fre <- sort(rowSums(tdm), decreasing = T)
aux <- subset(fre, fre>2)

barplot(aux, las=2, col=rainbow(10))

wordcloud(
  corpus, 
  min.freq = 1,
  max.words=60,
  random.order=F,
  rot.per=0.35,
  colors=brewer.pal(8, "Dark2")
)

###################### WORDCLOUD TWITTER BLACK LIVES MATTER ###########

install.packages("tm")
install.packages("wordcloud")
install.packages("twitteR")
install.packages("RColorBrewer")

library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

consumer_key <- "SPo5Sh3M46QdHd7BIuHWPF1n2"
consumer_secret <- "56fNxvBfcqFPMvI6hShIfOBaXKeTKNn9VJ5ycFoXSZIuayEE9i"
access_token <- "1177610586529636352-wmAf2pkUQ0lWFdKLZdkIIui0cd9bpN"
access_secret <- "c3PtHUksqZEQNx36xDPc8j9mkTvLeWvasZbp40MCBgri8"

setup_twitter_oauth(
  consumer_key, 
  consumer_secret, 
  access_token, 
  access_secret
)

tweets <- searchTwitter("#Blacklivesmatter", n=500, lang="pt")
tweets <- twListToDF(tweets)
tweets_t <- paste(tweets$text, collapse= " ")

VS <- VectorSource(tweets_t)
corpus <- Corpus(VS)
inspect(corpus)

#limpeza
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords('portuguese'))

#remover urls
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
corpus <- tm_map(corpus, removeURL)

#remove tudo o que nao sejam letras em pt-br e espaço
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
corpus <- tm_map(corpus, removeNumPunct)

#gera matriz com frequencia palavras
tdm <- as.matrix(TermDocumentMatrix(corpus))

#ordena por frequencia
fre <- sort(rowSums(tdm), decreasing = T)

wordcloud(
  corpus, 
  min.freq = 3,
  max.words=Inf,
  random.order=F,
  rot.per=0.15,
  colors=brewer.pal(8, "Dark2"),
  scale=c(8,.2)
)
?wordcloud

############################ ANALISE DE SENTIMENTOS TWITTER ############


install.packages("tm")
install.packages("syuzhet")
install.packages("twitteR")

library(twitteR)
library(tm)
library(syuzhet)


consumer_key <- "SPo5Sh3M46QdHd7BIuHWPF1n2"
consumer_secret <- "56fNxvBfcqFPMvI6hShIfOBaXKeTKNn9VJ5ycFoXSZIuayEE9i"
access_token <- "1177610586529636352-wmAf2pkUQ0lWFdKLZdkIIui0cd9bpN"
access_secret <- "c3PtHUksqZEQNx36xDPc8j9mkTvLeWvasZbp40MCBgri8"

setup_twitter_oauth(
  consumer_key, 
  consumer_secret, 
  access_token, 
  access_secret
)

tweets <- searchTwitter("#NarutoShippuden", n=500, lang="pt")
tweets <- twListToDF(tweets)
tweets_t <- tweets$text

s <- get_nrc_sentiment(tweets_t)

barplot(colSums(s), las=2, col = rainbow(10),
        ylab="Contagem", main = "Sentimentos com Relação ao naruto")
