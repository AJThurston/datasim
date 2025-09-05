#devtools::install_github("yihui/animation")

library(ggplot2)
library(animation)
library(gganimate)
library(tweenr)
library(formattable)
windowsFonts(Times=windowsFont("TT Times New Roman"))

meanx1=0  #mean of the predicted distribution.
sdx1=1    #SD of the predicted distribution.
meany1=0  #mean of the actual distribution.
sdy1=1    #SD of the actual distribution.
n=100    #sample size for both distribution.

data = data.frame(matrix(ncol = 3, nrow = 0))
colnames(data) <- c("r","x1","y1")

for (i in -99:-89){ #for loops don't like decimals
  r = i/100
  x = rnorm(n=n, mean=meanx1, sd=sdx1) #Simulated x 
  y0 = rnorm(n=n, mean=meany1, sd=sdy1)
  y = x*r+y0*(1-r^2)^0.5
  df = data.frame(r,x,y)
  data = rbind(data,df)
}

p = ggplot(data) +

  aes(x = x, y = y, frame = r) +
  scale_x_continuous(limits = c(-3,3), breaks = c(-3,-2,-1,0,1,2,3)) +
  scale_y_continuous(limits = c(-3,3), breaks = c(-3,-2,-1,0,1,2,3)) +
  geom_point(alpha = 0.4, size = 5, color = '#006747') +
  theme(
    text = element_text(size = 20, family = "Times", color = "black"),
    panel.background = element_rect(fill = "white"),
    axis.text.y = element_text(size = 20, color = 'black'),
    axis.text.x = element_text(size = 20, color = 'black'),
    panel.grid.major.y = element_line(color = "gray"),
    panel.grid.major.x = element_line(color = "gray"),
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    axis.line.x = element_line(color = "black"),
    axis.line.y = element_line(color = "black")
  )


gganimate(p, 
          interval = .0000125, 
          "C:\\Users\\AJ Thurston\\Desktop\\corrs.gif",
          title_frame = TRUE)

