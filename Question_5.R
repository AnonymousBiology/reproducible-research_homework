## QUESTION 5

# Reading the data 
data <- read.csv("/cloud/project/question-5-data/Cui_etal2014.csv")

# Get the number of rows and columns
num_rows <- nrow(data)
num_columns <- ncol(data)
num_rows
num_columns

# Print the results
cat("Number of rows:", num_rows, "\n")
cat("Number of columns:", num_columns, "\n")

# Log transforming the variables 
data$log.Virion.volume..nm.nm.nm. <- log(data$Virion.volume..nm.nm.nm.)
data$log.Genome.length..kb. <- log(data$Genome.length..kb.)

# Modelling the log transformation 
model <- lm(log.Virion.volume..nm.nm.nm. ~ log.Genome.length..kb., data = data)
summary(model)

# Log-transform the data
your_data$log_Genome_length <- log(your_data$Genome_length)
your_data$log_Virion_volume <- log(your_data$Virion_volume)

# Plot the graph
ggplot(data, aes(x = log.Genome.length..kb., y = log.Virion.volume..nm.nm.nm.)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "log[Genome length(kb)]", y = "log[Virion volume(nm3)]") +
  theme_bw() +
  theme(
    text = element_text(face = "bold")  
  )

ggsave("reproduced_allometric_scaling.png", width = 8, height = 6, dpi = 600)

# Applying the formula to L = 300 
exp(7.0748) * 300^1.5152 

L <- 300 
α <- 1.5152
β <- exp(7.0748)

V <- β*L^α
V
