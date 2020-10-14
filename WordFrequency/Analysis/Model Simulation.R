# random noise (sigma.jump > 0, rest are 0)
# 0<B<1
# B>1
# C > 0
# C < 0
library(tidyverse)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
out = read.csv(file='model-out.csv')
#to calculate correlations 
cor.test(out$mu, out$C, method="kendall") 
sum(out$C > 0 & out$mu >-10)/sum(out$mu > -10)

library(ggplot2)
library(ggpubr)
library(patchwork)
library(sfsmisc)
library(scales)
theme_set(theme_classic())

ndays <- 876
#### ABC Decay values
# theta <- 2.43549423
# mu <- -10
# sigma.jump <- 1.524616172
# sigma.drift <- 0.1
# s <- 0.692192031
# A <- -2.98557681
# B <- .5
# C <- 0.5

theta <- 3
mu <- -10.0
sigma.jump <- .50
sigma.drift <- .1
s <- 1.0
A <- 1
B <- 0
C <- 1
												
					
inv_logit <- function(x) { 1/(1+exp(-x)) }

l <- rep(0,ndays) # Not sure what to start on
for(t in 3:ndays) {
  
  if(runif(1) < inv_logit(theta)) {
    l[t] <- rnorm(1, mean=B*l[t-1] + C*(l[t-1]-l[t-2]), sd=sigma.drift)
  }
  else {
    l[t] <- rnorm(1, mean=0, sd=sigma.jump)
  }
}

# convert into probabilities
t <- (1:ndays)/ndays # day scaled to be 0->1
p <- exp(mu+A*t+s*l)
df = data.frame(t,p)

ggplot(aes(x=t*876,y=log(p)), data = df) + 
  geom_line(lwd = .2) +
  geom_hline(yintercept = mu, color = 'red', linetype = 'dashed') +
  theme(text = element_text(size=20)) +
  #scale_y_continuous(label=scientific_format(digits=1))+
  ylab("Log Probability")+
  xlab("Day")+
  annotate("label", x = 180, y = Inf, 
           hjust = 1, vjust = 1, 
           size = 5,
           label = sprintf("A=%.1f\nB=%.1f\nC=%.1f",A,B,C))
ggsave(filename = "./Simulation_C.pdf",height = 3, width = 4)

dfClinton = read.csv('Clinton.csv')
ggplot(data = dfClinton, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_few() +
  geom_vline(xintercept = 348,  color='red', linetype = 'dashed')+
  ggtitle('Clinton')+ xlab('Day') +ylab('Observed Log Probability')+
  annotate(geom="text", x=550, y=-11, label="Election Day 2016")+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Clinton.pdf",height = 3, width = 4)




a = ggplot(aes(x=t*876,y=p), data = df) + 
  geom_line() +
  geom_hline(yintercept = exp(mu), color = 'red', linetype = 'dashed') +
  theme(text = element_text(size=20), aspect.ratio=2/3) +
  scale_y_continuous(label=scientific_format(digits=1))+
  ylab("Log Probability")+
  xlab("Day")+
  annotate("label", x = Inf, y = Inf, 
           hjust = 1, vjust = 1, 
           size = 8,
           label = sprintf("A=%.1f\nB=%.1f\nC=%.1f", A,B,C)) 

b = ggplot(aes(x=t*876,y=p), data = df) + 
  geom_line() +
  geom_hline(yintercept = exp(mu), color = 'red', linetype = 'dashed') +
  theme(text = element_text(size=20), aspect.ratio=2/3) +
  scale_y_continuous(label=scientific_format(digits=1))+
  ylab("Log Probability")+
  xlab("Day")+
  annotate("label", x = Inf, y = Inf, 
           hjust = 1, vjust = 1, 
           size = 8,
           label = sprintf("A=%.1f\nB=%.1f\nC=%.1f", A,B,C)) 
 
c = ggplot(aes(x=t*876,y=p), data = df) + 
  geom_line() +
  geom_hline(yintercept = exp(mu), color = 'red', linetype = 'dashed') +
  theme(text = element_text(size=20), aspect.ratio=2/3) +
  scale_y_continuous(label=scientific_format(digits=1))+
  ylab("Log Probability")+
  xlab("Day")+
  annotate("label", x = Inf, y = Inf, 
           hjust = 1, vjust = 1, 
           size = 8,
           label = sprintf("A=%.1f\nB=%.1f\nC=%.1f", A,B,C))



ggarrange(a, b, c + rremove("x.text"), 
          labels = c("A", "B", "C"),
          ncol = 1, nrow = 3)

a/b/c
