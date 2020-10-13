df <- data.frame(elements=c("A", "B", "C", "D", "E"),
                 X= c(5,7,12,15,10))
df
summary(df)
var(df$X)
sd(df$X)

length(which(df$X%%2 == 0))/nrow(df)

"
sd <- 4.1681
N <- 2637
erro <- 1
nc <- (1-0.95)/2
n <-(qnorm(nc, lower.tail= F)^2 * sd^2 * N)/((erro^2*(N-1))+(qnorm(nc,lower.tail = F)^2*sd^2)) 
n

sd <-6250
erro <-500
nc<-(1-0.95)/2
n <-((qnorm(nc,lower.tail= F)*sd)/erro)^2
n"

###########
sd <-4250
erro <-300
nc<-(1-0.9)/2
n <-((qnorm(nc,lower.tail= F)*sd)/erro)^2
n


sd <- 5
N <- 1500
erro <- 1.5
nc <- (1-0.955)/2
n <-(qnorm(nc, lower.tail= F)^2 * sd^2 * N)/((erro^2*(N-1))+(qnorm(nc,lower.tail = F)^2*sd^2)) 
n

sd <- (30-10)/4
erro <- 1
nc <- (1-0.98)/2
n <-((qnorm(nc,lower.tail= F)*sd)/erro)^2
n

sd <- (30-10)/4
N <- 5000
erro <- 1
nc <- (1-0.98)/2
n <-(qnorm(nc, lower.tail= F)^2 * sd^2 * N)/((erro^2*(N-1))+(qnorm(nc,lower.tail = F)^2*sd^2)) 
n

#########

1-pnorm(q=30,mean =  50,sd =  10)
pnorm(q=30,mean =  50,sd =  10)

#########
1-pnorm(1)
pnorm(-2)
pnorm(0)
1-pnorm(1.28)
#############

qnorm(p = 0.90,mean = 90, sd = 21, lower.tail = F)
##########


#Desviopadrão
d <-3.8
#Médiadaamostra 
x <-30.2
#Tamanhodaamostra
n <-100
#Nível de confiança
nc<-(1-0.95)/2
#Erro 
error <-d/sqrt(n)
#Limiteinferior 
left <-x-(qnorm(nc,lower.tail= F)*error)
#Limitesuperior
right <-x+(qnorm(nc,lower.tail= F)*error)
cat("[",left, "-", right,"]", sep = "")

##########

#Desviopadrão
d <-47
#Médiadaamostra 
x <-658
#Tamanhodaamostra
n <-100
#Nível de confiança
nc<-(1-0.90)/2
#Erro 
error <-d/sqrt(n)
#Limiteinferior 
left <-x-(qnorm(nc,lower.tail= F)*error)
#Limitesuperior
right <-x+(qnorm(nc,lower.tail= F)*error)
cat("[",left, "-", right,"]", sep = "")

#########

aux <- c(4.37, 3.63, 2.78, 5.46, 2.18, 6.07, 3.24, 5.89, 4.86, 4.64)
#Desviopadrão
d <-sd(aux)
#Médiadaamostra 
x <-mean(aux)
#Tamanhodaamostra
n <-length(aux)
#Nível de confiança
nc<-(1-0.90)/2
#Erro 
error <-d/sqrt(n)
#Limiteinferior 
left <-x-(qnorm(nc,lower.tail= F)*error)
#Limitesuperior
right <-x+(qnorm(nc,lower.tail= F)*error)
cat("[",left, "-", right,"]", sep = "")

########