# Reproducible research: version control and R

## Question 4

**a. Execute the code to produce the paths of two random walks. What do you observe?**

The graphs maps the spatial trajectory of two random walks across a 2 dimensional x/y axis, both starting at the 0,0 coordinate. Colour is used to graphically show time, with gradient of dark to light blue from the start to the end of each walk. Each walk is comprised of 500 steps, with each step being the same distance (0.25), but in a randomised direction. The angle of each point relative to the previous is calculated by generating a random number between 0 and 2π using the runif() function that provides an expression of the magnitude of displacement in the x and y directions based on trigonometry. Both graphs are the product of the same function of step randomisation, and thus show different paths through space. Each time the code is rerun, 

is determined by the runif() function, which randomly selects a number between 0

**Investigate the term **random seeds**. What is a random seed and how does it work? (5 points)**

A random seed is a base value used to by a pseudo-random generater to ensure the same random output each time a piece of code is run. 

**Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points)**

added set.seed() command with a set number 

## Question 5 

**Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the question-5-data folder). How many rows and columns does the table have? (3 points)**

33 rows and 13 columns not including the header row. 

**What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points)**

Can use several transformations -> I decided to use log transformations as this was in line with what was in the original paper. 

**Find the exponent (α) and scaling factor (β) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in Table 2 of the paper, did you find the same values? (10 points**)

alpha: 1.5152 the gradient of the line 
beta: exp(7.0748) the intercept 

Low p-values show that the model is a good fit for the data 

Values very similar to values in paper 2 

**Write the code to reproduce the figure shown below. (10 points)**

ggplot(data, aes(x = log.Genome.length..kb., y = log.Virion.volume..nm.nm.nm.)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "log[Genome length(kb)]", y = "log[Virion volume(nm3)]") +
  theme_bw() +
  theme(
    text = element_text(face = "bold")  
  )

What is the estimated volume of a 300 kb dsDNA virus? (4 points)

6697007 nm3

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points (plus an optional bonus question worth 10 extra points). First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers. All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   - A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points)
   - Investigate the term **random seeds**. What is a random seed and how does it work? (5 points)
   - Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points)
   - Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points)

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \beta L^{\alpha}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   - Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)
   - What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points)
   - Find the exponent ($\alpha$) and scaling factor ($\beta$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points)
   - Write the code to reproduce the figure shown below. (10 points)

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  - What is the estimated volume of a 300 kb dsDNA virus? (4 points)

**Bonus** (**10 points**) Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have? (e.g. check the platform [protocols.io](https://www.protocols.io/)).
