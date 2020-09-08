# Run: 
# echo "word,mu,scale,A,B,C,theta,jump,maxRhat,medianRhat,lastRhats,divergent,total.freq,median.daily.p,mean.daily.p,sd.daily.p,freq.acorr,lpcor" > model-out.csv; tail -q -n 1 model/out/*.csv >> model-out.csv
library(tidyr)
library(ggplot2)

d <- read.csv("model-out.csv")
s <- strsplit(as.character(d$word), "\\/")

d$word <- unlist(lapply(s, function(a){a[1]}))
d$tag  <- unlist(lapply(s, function(a){a[2]}))

# collapse some tagging
d$mytag <- d$tag
d$mytag[d$tag=="nnp"] <- "nn"
d$mytag[d$tag=="nnps"] <- "nn"
d$mytag[d$tag=="nns"] <- "nn"
d$mytag[d$tag=="vbd"] <- "vb"
d$mytag[d$tag=="vbg"] <- "vb"
d$mytag[d$tag=="vbn"] <- "vb"
d$mytag[d$tag=="vbp"] <- "vb"
d$mytag[d$tag=="vbz"] <- "vb"

d$mytag[d$tag=="rbr"] <- "rb"
d$mytag[d$tag=="jjr"] <- "jj"
d$mytag[d$tag=="jjs"] <- "jj"


# and add function words 
d$mytag[d$tag=="cd"] <- "func"
d$mytag[d$tag=="in"] <- "func"
d$mytag[d$tag=="rp"] <- "func"
d$mytag[d$tag=="prp"] <- "func"
d$mytag[d$tag=="md"] <- "func"
d$mytag[d$tag=="cc"] <- "func"
d$mytag[d$tag=="dt"] <- "func"
d$mytag[d$tag=="pdt"] <- "func"


# toss tags that have few words
t <- table(d$mytag)
d <- subset(d, (mytag != "fw") & (mytag == "func" | is.element(mytag, names(t[t>10]))))
d$mytag <- as.factor(d$mytag)


# convert to long format so we can make one plot
dlong <- gather(d, variable, value, scale:jump, factor_key=TRUE)

# Scatter plot version:
# plt <- ggplot(dlong, aes(x=mu,y=value)) + 
#     facet_grid(variable ~ mytag, scales="free") + 
#     geom_point(alpha=0.01) + 
#     geom_hline(aes(yintercept=0), color="red", alpha=1*(dlong$variable!="scale" & dlong$variable!="theta" & dlong$variable!="jump")) +
#     theme_bw()

plt <- ggplot(dlong, aes(x=mu,y=value)) + 
  facet_grid(variable ~ mytag, scales="free") + 
  geom_hex(bins=50) +
  geom_hline(aes(yintercept=0), color="red", alpha=1*(dlong$variable!="scale" & dlong$variable!="theta" & dlong$variable!="jump")) +
  theme_bw()+
  theme(text = element_text(size=12))
  #+ theme(text = element_text(size=36), aspect.ratio=2/3)
plt
