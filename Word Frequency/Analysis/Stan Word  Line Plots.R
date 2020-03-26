library(tidyverse)

#Load each plot independently as .csv

#Clinton
dfClinton = read.csv('Clinton.csv')
ggplot(data = dfClinton, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  geom_vline(xintercept = 348,  color='red', linetype = 'dashed')+
  ggtitle('Clinton')+ xlab('Day') +ylab('Observed Log Probability')+
  annotate(geom="text", x=550, y=-11, label="Election Day 2016")+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Clinton.pdf",height = 3, width = 4)

#Trump
dfTrump = read.csv('Trump.csv')
ggplot(data = dfTrump, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  geom_vline(xintercept = 348,  color='red', linetype = 'dashed')+
  ggtitle('Trump')+ xlab('Day') +ylab('Observed Log Probability')+
  annotate(geom="text", x=550, y=-8.8, label="Election Day 2016")+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Trump.pdf",height = 3, width = 4)

#Obama
dfObama = read.csv('Obama.csv')
ggplot(data = dfObama, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  geom_vline(xintercept = 348,  color='red', linetype = 'dashed')+
  ggtitle('Obama')+ xlab('Day') +ylab('Observed Log Probability')+
  annotate(geom="text", x=550, y=-10, label="Election Day 2016")+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Obama.pdf",height = 3, width = 4)

#Bracket
dfBracket = read.csv('Bracket.csv')
ggplot(data = dfBracket, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  geom_vline(xintercept = 100,  color='red', linetype = 'dashed')+
  annotate(geom="text", x=190, y=-15.5, label="March 2016")+
  geom_vline(xintercept = 465,  color='red', linetype = 'dashed')+
  annotate(geom="text", x=555, y=-15.5, label="March 2017")+
  ggtitle('Bracket')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Bracket.pdf",height = 3, width = 4)

#Collusion
dfCollusion = read.csv('Collusion.csv')
ggplot(data = dfCollusion, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  geom_vline(xintercept = 348,  color='red', linetype = 'dashed')+
  annotate(geom="text", x=550, y=-16, label="Election Day 2016")+
  ggtitle('Collusion')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Collusion.pdf",height = 3, width = 4)

#Privacy
dfPrivacy = read.csv('Privacy.txt', header = F, sep = ' ')
colnames(dfPrivacy) = c('day', 'word', 'n', 'z')
dfPrivacy['lpobs'] = log(dfPrivacy['n']/dfPrivacy['z'])
glimpse(dfPrivacy)
ggplot(data = dfPrivacy, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Privacy')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Privacy.pdf",height = 3, width = 4)

#Sunday
df211 = read.csv('Sunday.txt', header = F, sep = ' ')
colnames(df211) = c('day', 'word', 'n', 'z')
df211['lpobs'] = log(df211['n']/df211['z'])
glimpse(df211)
ggplot(data = df211, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Sunday')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Sunday.pdf",height = 3, width = 4)
#ggsave with aspect 3:4

#Summer
dfSummer = read.csv('Summer.txt', header = F, sep = ' ')
colnames(dfSummer) = c('day', 'word', 'n', 'z')
dfSummer['lpobs'] = log(dfSummer['n']/dfSummer['z'])
glimpse(dfSummer)
ggplot(data = dfSummer, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Summer')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Summer.pdf",height = 3, width = 4)

#Fire
dfFire = read.csv('fire.txt', header = F, sep = ' ')
colnames(dfFire) = c('day', 'word', 'n', 'z')
dfFire['lpobs'] = log(dfFire['n']/dfFire['z'])
glimpse(dfFire)
ggplot(data = dfFire, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Fire')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Fire.pdf",height = 3, width = 4)

#Mexico
dfMexico = read.csv('mexico.txt', header = F, sep = ' ')
colnames(dfFire) = c('day', 'word', 'n', 'z')
dfFire['lpobs'] = log(dfFire['n']/dfFire['z'])
glimpse(dfMexico)
ggplot(data = dfFire, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Mexico')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Mexico.pdf",height = 3, width = 4)

#Amazon
df = read.csv('amazon.txt', header = F, sep = ' ')
colnames(df) = c('day', 'word', 'n', 'z')
df['lpobs'] = log(df['n']/df['z'])
ggplot(data = df, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Amazon')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Amazon.pdf",height = 3, width = 4)

#Crisis
df = read.csv('crisis.txt', header = F, sep = ' ')
colnames(df) = c('day', 'word', 'n', 'z')
df['lpobs'] = log(df['n']/df['z'])
ggplot(data = df, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Crisis')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Crisis.pdf",height = 3, width = 4)

#Violence
df = read.csv('violence.txt', header = F, sep = ' ')
colnames(df) = c('day', 'word', 'n', 'z')
df['lpobs'] = log(df['n']/df['z'])
ggplot(data = df, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Violence')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Violence.pdf",height = 3, width = 4)

#Championship
df = read.csv('championship.txt', header = F, sep = ' ')
colnames(df) = c('day', 'word', 'n', 'z')
df['lpobs'] = log(df['n']/df['z'])
ggplot(data = df, aes(x = day, y = lpobs))+
  geom_line(lwd = .2)+
  theme_bw() +
  ggtitle('Championship')+ xlab('Day') +ylab('Observed Log Probability')+
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "./Championship.pdf",height = 3, width = 4)

