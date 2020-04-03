
data {
    int N_DAYS;                // total number of days
    int<lower=0> cnt[N_DAYS];  // daily counts for this word
    int<lower=0> z[N_DAYS];    // daily total counts observed
}

transformed data {
}

parameters {
   
   // each day's adjusted probability from mu (so zero initialization is at the mean)
   real lp_adjust[N_DAYS];
   
   real<upper=0> mu;
   real<lower=0> drift;
   real<lower=0> resamplestdev;
    
   real A;
   real B;
   real C;
   
   real<lower=0,upper=1> theta; 
}
    
transformed parameters {
}
    
model { 

    drift  ~ normal(0, 1);
    resamplestdev ~ normal(0,1);
    theta  ~ beta(1, 10); // prior here is to primarily help model identification, but we assume a bias against resampling
     
    A ~ normal(0, 1);
    B ~ normal(0, 1);
    C ~ normal(0, 1);

    mu ~ normal(-20.68, 1.83); // word overall mean
    
    // initialize the first two days
    for(d in 1:2) {
        lp_adjust[d] ~ normal(0.0, resamplestdev); // not sure what to use for this exactly, but its only two data points
    }
    
    // Main loop over days, marginalizing over whether that day was a new sample of lp_adjust or a drift on the previous day
    for(d in 3:N_DAYS) {
         target += log_sum_exp( log(theta)   + normal_lpdf(lp_adjust[d] | 0.0, resamplestdev), // fixed probabilities
                                log(1-theta) + normal_lpdf(lp_adjust[d] | A + B*(lp_adjust[d-1]) + C*(lp_adjust[d-1]-lp_adjust[d-2]), drift));
    }

    // treat as a binomial sample with the given mu and lp_adjust
    for(i in 1:N_DAYS){    
        target += cnt[i]*(mu+lp_adjust[i]) + (z[i]-cnt[i])*log1m(exp(mu+lp_adjust[i]));
    }   
}



