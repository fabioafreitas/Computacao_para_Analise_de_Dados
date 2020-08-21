#Atribuição
x <- 133
y <- 36
z <- log(sqrt(x+y))
round(z, digits = 0)

#Round
a <- log(0+1+1+2+3)
a <- round(a, digits = 3)

#derivadas
derivada <- deriv(~sin(x)+x,'x',func = T)
result_derivada <- attr(func(2),'gradient')
round_derivada <- round(result_derivada, 3)

#factorial
fact <- log10(factorial(10))
fact_round <- round(fact, 2)

#Exercicio da velocidade da luz
light <- 300000000 # m/s
mass <- 10 # kg
energy <- round(log(light*mass), 2)

#vetores
v<-c(2,5,7,8,9)
fx <- function(x) {
  return(x^3 + x^2 + x)
}
mean(fx(v))
