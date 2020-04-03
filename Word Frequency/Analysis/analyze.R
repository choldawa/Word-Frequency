library(rstan)
#options(width=Sys.getenv("COLUMNS"))

d <- read.table("corpus-1.txt",header=T)
all.days <- data.frame(day=seq(min(d$day),max(d$day)))

# compile the model
model <- stan_model(file="model.stan", model_name="model10")

# get the word ordering, just from day=2 (day 1 was a partial day) in decreasing order of frequency
# a <- subset(d,day==2)
# words <- a$word[order(a$freq,decreasing=TRUE)]

# Or just trim infrequent words and get it at random
words <- unique(as.character(d$word))
words <- sample(words[1:20000]) # and a random 20,000

# run on each word
D <- NULL # we'll build up a dataframe with one row for each word
for(w in words) {

    q <- subset(d, word==w) # extract this word
    if(nrow(q) < 10) { next } # skip words that have <10 days they had samples -- these are probably noise
    
    # Fill in missing days so they are zeros
    q <- merge(all.days, q, all.x=T, all.y=T)
    q$freq[is.na(q$freq)] <- 0 #fix NAs (which merge may have inserted) to be zeroes
    q$z[is.na(q$z)]       <- 0 
    q <- q[order(q$day),] # sort by day
        
    # construct data for stan
    data <- list(N_DAYS=nrow(q), cnt=q$freq, z=q$z)

    # Run the sampler (note init=0)
    fit <- rstan::sampling(object=model, data=data, iter=1000, chains=2, cores=2, init=0)

    # extract a summary
    s <- summary(fit)
	
	# get the mean daily lp_adjust
    pp <- colMeans(extract(fit, "lp_adjust")$lp_adjust)
    cr <- cor.test(pp, log(q$freq)-log(q$z))
    # plot(pp, log(q$freq)-log(q$z)) # recovered lps are close to what they are -- good sanity check

    # autocorrelation
    acrr <- tryCatch(cor.test((data$cnt/data$z)[-1],(data$cnt/data$z)[-length(data$z)])$estimate,
                     error=function(e) { NA })
    
    # bind into the big data frame of words
    D <- rbind(D, data.frame(word=w, 
                            mu=mean(extract(fit,"mu")$mu), 
                            drift=mean(extract(fit,"drift")$drift),
                            A=mean(extract(fit,"A")$A), 
                            B=mean(extract(fit,"B")$B), 
                            C=mean(extract(fit,"C")$C), 
                            resamplestdev=mean(extract(fit,"resamplestdev")$resamplestdev), 
                            theta=mean(extract(fit,"theta")$theta),
                            maxRhat=max(data.frame(s$summary)$Rhat),
                            medianRhat=median(data.frame(s$summary)$Rhat),                            
                            total.freq=log(sum(q$freq)),
                            median.daily.p=median(log(q$freq)-log(q$z), na.rm=T),
                            mean.daily.p=mean(log(q$freq)-log(q$z), na.rm=T),
                            sd.daily.p=sd(log(q$freq)-log(q$z)),
                            freq.acorr=acrr,
                            lpcor=cr$estimate))

    
    print(q)
    print(fit)
    write.csv(D, file="D.txt")
}


