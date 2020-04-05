library(tidyverse)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
stan = read.csv(file='D.txt')
glimpse(stan)

#to calculate correlations 
cor.test(stan$mu, stan$C, method="kendall") 

#Scatterplots of mu vs each variable
ggplot(stan, aes(x = mean.daily.p, y = mu)) +
  geom_hex(bins = 70)+
  #scale_fill_gradient(trans = "log", labels = function(x) round(x,1))+ 
  theme_bw() + 
  theme(text = element_text(size=36), aspect.ratio=2/3)+ 
  #ylim(-17,-5)+
  xlim(-16,-6)+
  xlab("Observed Mean Log Prob")+
  ylab('Mu')+ 
  geom_smooth(method = 'lm')+
  geom_abline(intercept = 0, color = 'red')

summary(lm(data = stan, mean.daily.p ~ mu))

ggplot(stan, aes(x = mu, y = drift)) +
  geom_hex(bins = 80)+
  theme_bw() + 
  theme(text = element_text(size=36), aspect.ratio=2/3)+
  ylim(0,1.5)+
  ylab("Drift")+
  xlab('Mu')

ggplot(stan, aes(x = mu, y = A)) +
  #geom_point(alpha = .02, size =3) +
  geom_hex(bins = 70)+
  theme_bw() + 
  theme(text = element_text(size=36), aspect.ratio=2/3)+
  geom_hline(yintercept=0, linetype="dashed", 
             color = "red", size=2)+
  ylim(-2,2)+
  xlab('Mu')

ggplot(stan, aes(x = mu, y = B)) +
  #geom_point(alpha = .02, size =3) +
  geom_hex(bins = 70)+
  theme_bw() + 
  theme(text = element_text(size=36), aspect.ratio=2/3)+
  geom_hline(yintercept=0, linetype="dashed", 
             color = "red", size=2)+
  ylim(-1,1.1)+
  xlab('Mu')


ggplot(stan, aes(x = mu, y = C)) +
  geom_hex(bins = 70)+
  theme_bw() + 
  theme(text = element_text(size=36), aspect.ratio=2/3)+
  geom_hline(yintercept=0, linetype="dashed", 
             color = "red", size=2)+
  ylim(-1,1)+
  xlab('Mu')

ggplot(stan, aes(x = mu, y = theta)) +
  geom_hex(bins = 80)+
  theme_bw() + 
  theme(text = element_text(size=36), aspect.ratio=2/3)+
  #geom_smooth(method = "loess", color = 'blue') + 
  ylim(0,1)+
  ylab("Theta")+
  xlab('Mu')

ggplot(stan, aes(x=mu)) + geom_histogram(bins = 100) +
  theme_bw() +
  theme(text = element_text(size=40), aspect.ratio=2/3)+
  ylab("Count")+
  xlab('Mu')


Fn <- ecdf(stan$mu)
curve(Fn, from = -20, to = -5, ylab = 'CDF', xlab = 'Mu')
