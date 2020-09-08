# random noise (sigma.jump > 0, rest are 0)
# 0<B<1
# B>1
# C > 0
# C < 0
library(ggplot2)
library(ggpubr)
library(patchwork)
library(sfsmisc)
library(scales)
theme_set(theme_classic())

ndays <- 876

theta <- 4.162401669
mu <- -6.759018633
sigma.jump <- 4.629432253
sigma.drift <- 1
s <- 0.200813801
A <- 0.785119755
B <- 0.907851074
C <- -0.113559324
						
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

ggplot(aes(x=t*876,y=p), data = df) + 
  geom_line() +
  geom_hline(yintercept = exp(mu), color = 'red', linetype = 'dashed') +
  theme(text = element_text(size=20), aspect.ratio=2/5) +
  scale_y_continuous(label=scientific_format(digits=1))+
  ylab("Log Probability")+
  xlab("Day")+
  annotate("label", x = Inf, y = Inf, 
           hjust = 1, vjust = 1, 
           size = 8,
           label = sprintf("A=%.1f\nB=%.1f\nC=%.1f",A,B,C))








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
