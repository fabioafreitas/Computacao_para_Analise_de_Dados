install.packages("tm")
install.packages("twitteR")
install.packages("syuzhet")
install.packages("wordcloud")
install.packages("RColorBrewer")

library(tm)
library(twitteR)
library(syuzhet)
library(wordcloud)
library(RColorBrewer)

consumer_key <- "f3M3zsXjY5quN8yb8hfwrxs1w"
consumer_secret <- "YhVIYJB6lhVfCguJ27LPcH1eg0jmJLhou7rK06tVvGCrNGzdJl"
access_token <- "1440727007592017924-I4z8plFnva2HcVJJylK36HkiDI9cts"
access_secret <- "h7mFIZVTtskk9qvbAzMoqiEjpizkenspDEXp2ddIA6Xj9"

searchString <- "educação"

setup_twitter_oauth(
  consumer_key, 
  consumer_secret, 
  access_token, 
  access_secret
)


# Obtendo tweets para a #Blacklivesmatter e formatação de dados
tweets <- searchTwitter(searchString, n=50, lang="pt")

# conversão para formato mais legível
tweets <- twListToDF(tweets)

# contacenaremos todos o texto de todos os tweets obtidos num único texto
tweets_t <- paste(tweets$text, collapse= " ")

## Tratamento e Limpeza do texto dos tweets
# Primeiro, converteremos o agregados dos textos para o formato de **Corpus**
VS <- VectorSource(tweets_t)
corpus <- Corpus(VS)
inspect(corpus)

# conversão para letras em minúsculo; 
# remoção de pontuação, como vírgulas e dois pontos; 
# remoção de espaços em branco adicionais; 
# e remoção de stopwords do idioma Português.
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords('portuguese'))

# retirada de links e urls dos tweets
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
corpus <- tm_map(corpus, removeURL)

# Remoção das palavras que não pertençam ao idioma Português
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
corpus <- tm_map(corpus, removeNumPunct)

# Geração da matriz que associa a palavra ao seu número de ocorrências
tdm <- as.matrix(TermDocumentMatrix(corpus))



# ordenamento da matriz de acordo com a frequência de palavras
fre <- sort(rowSums(tdm), decreasing = T)



### Geração da nuvem de palavras
wordcloud(
  corpus, 
  min.freq = 3,
  max.words=Inf,
  random.order=F,
  rot.per=0.15,
  colors=brewer.pal(8, "Dark2"),
  scale=c(5,.2)
)

### Análise de sentimentos
tema <- searchString
tweets <- searchTwitter(tema, n=50, lang="pt")
tweets <- twListToDF(tweets)
tweets_t <- tweets$text
sentiments <- get_nrc_sentiment(tweets_t)
barplot(
  colSums(sentiments), 
  las=2, 
  col = rainbow(10),
  ylab="Contagem", 
  main = paste("Sentimentos associados ao tema: ", tema, sep=" ")
)
