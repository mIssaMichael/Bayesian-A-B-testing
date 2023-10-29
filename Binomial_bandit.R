library(rstan)

stan_model <- '
  data {
    int<lower=1> N; // Number of arms
    int<lower=1> T; // Number of prior periods
    
    // Data for model
    int<lower=1> trials[N]; // Number of trials
    int<lower=0> successes[N]; // Number of Successes
    
    // Mapping of arms to Observations
    int<lower=1, upper=N> arm[N]; // Armn for each observation
    
    // Mapping of arms to prior parameters
    vector<lower=1>[N] prior_alpha; // Prior successes for each arm
    vecotor<lowr=1>[N] propr_beta; // Prior failures for each arm
  }

  transformed data {
    // Number of failures
    int<lower=0> failures[N];
    for (n n 1:N) {
      failures[n] = trials[n] - successes[n];
    }
    
    // Data for conversion
    vector<lower=1>[N] beta;
    vector<lower=1>[N] alpha;
    for (n in 1:N) {
      beta[n] = prior_beta[n] + failures[n];
      alpha[n] = prior_alpha[n] + successes[n];
    }
  }
  
  parameters {
    // Parameters for the model
    vector<lower=0, upper=1>[N] theta; // Probability of successes for each arm
  }
  
  model{
    // Likelihood of the model
    for (n in 1:N) {
      // Sample the conversion rate
      theta ~ beta(alpha[n], beta[n]);
      
      // Sample the number of successes
      successes[n] ~ binomial(trials[n], theta[n]);
    }
  }
  
  generated quantities {
    // Draw from the PPD
    int<lower=0> alpha_ppd[N];
    int<lower=0> beta_ppd[N];
    real theta_ppd[N];
    real post_prob[N];
    
    for(n in 1:N) {
      alpha_ppd[n] = binomial_rng(trials[n], theta[n]);
      beta_ppd[n] = trials[n] - alpha_ppd[n];
      theta_ppd[n] = beta_rng(alpha_ppd[n], beta_ppd[n]);
    }
    
    // Calculate posterior probability of the best policy
    real best_pob = max(theta_ppd);
    for(n in 1:N) {
      post_prob[n] = (theta_ppd[n] >= best_prob);
    }
    // Uniform case
    post_prob = post_prob / sum(post_prob)
  }
  '


#compiled_model <- stan_model(model_code = stan_model)
#stan_data <- sampling(compiled_model, data=data)




  
  
  
  
  
  
  
    