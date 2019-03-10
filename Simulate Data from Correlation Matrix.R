library(xlsx)
library(formattable)

set.seed(1) #Set seed so result is reproducable
n = 1000    #Sample size
M = 50      #Variable Means
SD = 10     #Variable SD
deci = 0    #Decimals to round data

names = c("Y1","X1","X2","X3")
nvars = length(names)

R = matrix(cbind(  1,.70,.50,.50,  
                 .70,  1,.30,.30,  
                 .50,.30,  1,.10,
                 .50,.30,.10,  1),
           nrow=nvars)

U = t(chol(R))
nvars = dim(U)[1]
random.normal = matrix(rnorm(nvars*n,0,1), nrow=nvars, ncol=n);
data = as.data.frame(t(U %*% random.normal))
data = round(data*SD+M, digits = deci)
names(data) = names
rm(U,R,random.normal,names,M,n,nvars,SD,deci)

write.xlsx(data, "data.xlsx")

plot(data)

