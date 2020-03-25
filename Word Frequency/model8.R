install.packages("gridExtra", dep = TRUE)
install.packages('ggplot2', dep = TRUE)
install.packages('ggthemes', dep = TRUE)
install.packages("dplyr")
install.packages('hexbin')

library(gridExtra)
library(ggplot2)
library(ggthemes)
library(extrafont)
library(grid)
library(dplyr)
library(tidyverse)
library(hexbin)



stan_dat <- read.csv(file='Model10.csv')
head(stan_dat)
stan_dat$index <- NULL

stan <- filter(stan_dat, maxr <1.15)
View(stan)
View(stan_dat)

stan <- stan_dat

calpha<- round(cor(stan_dat$mu,stan_dat$theta,method = "kendall"),2)
calpha
cor.test(stan_dat$mu, stan_dat$drift, method="kendall") 



########
#HEXBIN
########

ggplot(stan, aes(x = mu, y = alpha)) +
  geom_hex(alpha = 1) +
  scale_fill_gradient(low = "snow2", high = "blue4")+
  theme_tufte() + geom_smooth(method = "loess", color = 'black')+
  theme(text=element_text(size=30))+ 
  annotate("text", Inf, Inf, label =  'italic(tau) == "-0.31***"', parse = TRUE, hjust = 1, vjust = 1, size = 14)

ggplot(stan, aes(x = mu, y = sd)) +
  geom_hex(alpha = 1) +
  scale_fill_gradient(low = "snow2", high = "blue4")+
  theme_tufte() + geom_smooth(method = "loess", color = 'black') +ylim(0,1.2)+xlim(-12,-4)+
  theme(text=element_text(size = 30))+
  annotate("text", Inf, Inf, label = 'italic(tau) == "-0.27***"', parse = TRUE, hjust = 1, vjust = 1, size = 14)

ggplot(stan, aes(x = mu, y = a)) +
  geom_hex(alpha = 1) +
  scale_fill_gradient(low = "snow2", high = "blue4")+
  theme_tufte() + geom_smooth(method = "loess", color = 'black') +ylim(-1,1.05)+xlim(-12,-4)+
  theme(text=element_text(size=30))+
  annotate("text", Inf, Inf, label = 'italic(tau) == "0.18***"', parse = TRUE, hjust = 1, vjust = 1, size =14)

ggplot(stan, aes(x = mu, y = drift)) +
  geom_hex(alpha = 1) +
  scale_fill_gradient(low = "snow2", high = "blue4")+
  theme_tufte() + geom_smooth(method = "loess", color = 'black') +ylim(0,.5)+xlim(-12,-4)+
  theme(text=element_text(size=30))+
  annotate("text", Inf, Inf, label = 'italic(tau) == "-0.26***"', parse = TRUE, hjust = 1, vjust = 1, size = 14)

ggplot(stan, aes(x = mu, y = theta)) +
  geom_hex(alpha = 1) +
  scale_fill_gradient(low = "snow2", high = "blue4")+
  theme_tufte() + geom_smooth(method = "loess", color = 'black')  +ylim(0,.8)+xlim(-12,-4)+
  theme(text=element_text(size=30))+
  annotate("text", Inf, Inf, label = 'italic(tau) == "-0.06***"', parse = TRUE, hjust = 1, vjust = 1,size = 14)

ggplot(stan, aes(x = mu, y = lpobs)) +
  geom_hex(alpha = 1) +
  scale_fill_gradient(low = "snow2", high = "blue4")+
  theme_tufte() + geom_smooth(method = "loess", color = 'black')  +ylim(-12,-4)+xlim(-12,-4)+
  theme(text=element_text(size=30)) +
  annotate("text", Inf, Inf, label = 'italic(tau) == "0.63***"', parse = TRUE, hjust = 1, vjust = 1, size = 14)

grid.arrange(h1,h2,h3,h4,h5,h6, nrow = 2, ncol= 3)
#save
g <- arrangeGrob(h1,h2,h3,h4,h5,h6, nrow = 2, ncol= 3) #generates g
ggsave(file="C:/Users/Cameron/Desktop/stan/Graphs/corr.pdf", g) #saves g


########################

pdf()
library(grid) # not loaded by default
grid.newpage()
pushViewport(viewport(layout = grid.layout(3,2)))
print(h1, vp = vplayout(1,1))
print(h2, vp = vplayout(2,1))
print(h3, vp = vplayout(3,1))
print(h4, vp = vplayout(1,2))
print(h5, vp = vplayout(2,2))
print(h6, vp = vplayout(3,2))
dev.off()





#############
##PLOTTING##
############
# QQplot
ggplot(stan, aes(sample=mu))+stat_qq()+ theme_tufte()+
  theme(text=element_text(size=9,  family="Arial"))

qqnorm(stan$mu)
qqline(stan$mu,col = "red")


#Histogram
ggplot(data=stan, aes(stan$mu)) + geom_histogram()+ 
  ggtitle("Distribution of Mu")+
  theme_tufte()+
  labs(x="Mu", y="Count") + 
  theme(text=element_text(size=12,  family="Arial"))
#####
#Scatter plots
p1 <- ggplot(stan, aes(x = mu, y = alpha)) +
  geom_point(alpha = 0.1) +
  ggtitle("Alpha")+ 
  annotate("text", x=-4, y=1.8, label = "")  + 
  theme_tufte() + geom_smooth(method = "loess", color = 'red') +ylim(-10,10)+xlim(-10,-4)+
  theme(text=element_text(size=9,  family="Arial"))
p2 <- ggplot(stan, aes(x = mu, y = sd)) +
  geom_point(alpha = 0.1) +
  ggtitle("Sigma")+ 
  annotate("text", x=-4, y=1.8, label = "") +
  theme_tufte() + geom_smooth(method = "loess", color = 'red') +ylim(0,1)+xlim(-10,-4)+
  theme(text=element_text(size=9,  family="Arial"))
p3 <- ggplot(stan, aes(x = mu, y = a)) +
  geom_point(alpha = 0.1) +
  ggtitle("A")+ 
  annotate("text", x=-4, y=1.8, label = "") +
  theme_tufte() + geom_smooth(method = "loess", color = 'red') +ylim(-1,1)+xlim(-10,-4)+
  theme(text=element_text(size=9,  family="Arial"))
p4 <- ggplot(stan, aes(x = mu, y = drift)) +
  geom_point(alpha = 0.1) +
  ggtitle("Drift")+ 
  theme_tufte() + geom_smooth(method = "loess", color = 'red') +ylim(0,.5)+xlim(-10,-4)+
  theme(text=element_text(size=9,  family="Arial"))
p5 <- ggplot(stan, aes(x = mu, y = theta)) +
  geom_point(alpha = 0.1) +
  ggtitle("Theta")+ 
  theme_tufte() + geom_smooth(method = "loess", color = 'red')  +ylim(0,.8)+xlim(-10,-4)+
  theme(text=element_text(size=9,  family="Arial"))
p6 <- ggplot(stan, aes(x = mu, y = lpobs)) +
  geom_point(alpha = 0.1) +
  ggtitle("Observed Log Probability")+ 
  theme_tufte() + geom_smooth(method = "loess", color = 'red')  +ylim(-10,-4)+xlim(-10,-4)+
  theme(text=element_text(size=9,  family="Arial"))

grid.arrange(p1,p2,p3,p4,p5,p6, nrow = 2, ncol= 3
             ,top = textGrob("Correlation of Mu and Other Parameters",gp=gpar(fontsize=20,font=3)))
