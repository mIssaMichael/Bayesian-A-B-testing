# Load the required libraries
library(tidyverse)

# Set the random seed for reproducibility
set.seed(123)

# Define the parameters for the Beta distributions (prior beliefs)
prior_a <- 50   # Shape parameter for Version A
prior_b <- 50   # Shape parameter for Version B

# Simulate the number of visitors for each version
n_visitors_a <- 1000
n_visitors_b <- 1000

# Simulate conversion data for Version A
conversion_data_a <- rbeta(n_visitors_a, shape1 = prior_a, shape2 = prior_b)

# Simulate conversion data for Version B
conversion_data_b <- rbeta(n_visitors_b, shape1 = prior_a, shape2 = prior_b)

# Create data frames for each version
data_a <- data.frame(Version = "A", Conversion = conversion_data_a)
data_b <- data.frame(Version = "B", Conversion = conversion_data_b)

# Combine the data frames
simulated_data <- bind_rows(data_a, data_b)

# Print the first few rows of the simulated data
head(simulated_data)

# Plot the simulated data
ggplot(simulated_data, aes(x = Version, y = Conversion)) +
  geom_boxplot(fill = "lightblue") +
  labs(x = "Version", y = "Conversion Rate") +
  theme_minimal()
