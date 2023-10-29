library(rstan)

##################################################################
# Helper function

# Define a function for the inverse logit transformation
inv_logit <- function(x) {
  pi <- exp(x) / (1 + exp(x))
  return(pi)
}

# Define a function for the Bernoulli distribution
bernoulli <- function(n, p) {
  return(rbinom(n, 1, p))
}
##################################################################
# Define the path to your Stan model file
stan_file <- "models/binomial_bandit.stan"

# Compile the Stan model
model <- stan_model(file = stan_file)


# Check the model object to ensure it was compiled successfully
compiled_model

##################################################################


