# Reproducible research: version control and R

## Question 1-3

Here is the link to my logistic_growth repo: https://github.com/AnonymousBiology/logistic_growth

## Question 4

### _Execute the code to produce the paths of two random walks. What do you observe? (10)_

The graphs map the spatial trajectory of two random walks across a 2-dimensional axis, both starting at the 0,0 coordinate. Colour is used to graphically show time, with gradient of dark to light blue from the start to the end of each walk. 

Each walk is comprised of 500 steps with one unit of time per step, and each step being the same distance (h = 0.25), but in a randomised direction. The ```angle``` of each point relative to the previous is calculated by generating a random number between 0 and 2π using the ```runif()``` function. This is then used to create two expressions to describe the magnitude of displacement in the x (```cos(angle)*h```) and y (```sin(angle)*h```) direction from each previous point, which is used to generate the next coordinate. This function is used generate two datasets of random walk coordinates, which are then plotted and displayed side by side using the ```grid.arrange()``` function.

The randomisation of each step in the path means that ```plot1``` and ```plot 2``` take different routes through space, despite using the same function to generate the coordinates of both walks. Furthermore, every time the code is rerun, the output of both plots changes, meaning that the script is not reproducible in its current form. 

### _Investigate the term **random seeds**. What is a random seed and how does it work? (5)_

A random seed is a base value used to by a pseudo-random generator to ensure the same random output each time a piece of code is run - this can be applied to any code containing same mechanism of random number generation. In the context of **random_walk.R**, for instance, the ```set.seed()``` function can be used as a single integer argument within the ```random_walk()``` function to ensure that the same sequence of random angles is generated for each step every time the function is applied. Each step is completely random relative to the previous step within this function, but the whole function repeats the same pattern when used multiple times. The actual value of the seed itself is arbitrary (I used the integer 12) but this value must be written into the code to ensure that the random output will be repeatable for anyone else using the code. 

### _Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked reproducible-research_homework repo. (10)_

I added the ```set.seed()``` function to the ```random_walk()``` function just before the loop argument. The commit is titled "set.seed() edit". 

### _Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5)_

<img width="1471" alt="Screenshot 2023-12-03 at 16 55 52" src="https://github.com/poppyjdw/reproducible-research_homework/assets/150140489/d6278049-ba4d-434f-9886-6d3134e8c87c">

## Question 5 

### _Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the question-5-data folder). How many rows and columns does the table have? (3)_

I used the following code to count the number of rows and columns in my dataset

```
data <- read.csv("Cui_etal2014.csv")

num_rows <- nrow(data)
num_columns <- ncol(data)
num_rows
num_columns
```
This produced the output of 33 rows and 13 columns. The header row was not included in this count. 

### _What transformation can you use to fit a linear model to the data? Apply the transformation. (3)_

Given that the relationship between virion volume and genome length can be modelled by an allometric equation ( $`V = \beta L^{\alpha}`$ ) according to the original paper, log-transforming these variables should linearise the model to the form $`\ln(V) = \alpha \ln(L) + \ln(\beta)`$. 

The following code is used to apply this transformation to the log.Virion.volume..nm.nm.nm. and log.Genome.length..kb. variables 

```
data$log.Virion.volume..nm.nm.nm. <- log(data$Virion.volume..nm.nm.nm.)
data$log.Genome.length..kb. <- log(data$Genome.length..kb.)
```

### _Find the exponent (α) and scaling factor (β) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in Table 2 of the paper, did you find the same values? (10)_

The following code creates a linear regression model based the log-transformed virion volume and genome length values: 

```
model <- lm(log.Virion.volume..nm.nm.nm. ~ log.Genome.length..kb., data = data)
summary(model)
```
This provides the following output: 

```
Call:
lm(formula = log.Virion.volume..nm.nm.nm. ~ log.Genome.length..kb., 
    data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-1.8523 -1.2530 -0.1026  1.0739  2.0193 

Coefficients:
                       Estimate Std. Error t value Pr(>|t|)    
(Intercept)              7.0748     0.7693   9.196 2.28e-10 ***
log.Genome.length..kb.   1.5152     0.1725   8.784 6.44e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.263 on 31 degrees of freedom
Multiple R-squared:  0.7134,	Adjusted R-squared:  0.7042 
F-statistic: 77.16 on 1 and 31 DF,  p-value: 6.438e-10
```
Within this linear model ( $`\ln(V) = \alpha \ln(L) + \ln(\beta)`$ ), $`α`$ is the gradient of the slope, which is 1.5152 according to the estimated coefficients. $`\ln(\beta)`$ is the intercept of this model, which is 7.0748, so the value of $`β`$ is $`exp(7.0748)`$, which is 1181.807 (3 d.p). The p-values of $`α`$ and $`β`$ are 8.784 6.44e-10 and 9.196 2.28e-10 respectively, which are significantly lower than 0.05 and are therefore statistically significant. This suggests that the model is a good fit for the data. 

The values of the allometric exponent and scaling factor for dsDNA in the paper are 1.52 and 1,182, which are the same as my predicted $`α`$ and $`β`$ when rounded. 

### _Write the code to reproduce the figure shown below. (10)_

I reproduced the figure using the ```ggplot2``` package and the following code: 

```
ggplot(data, aes(x = log.Genome.length..kb., y = log.Virion.volume..nm.nm.nm.)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "log[Genome length(kb)]", y = "log[Virion volume(nm3)]") +
  theme_bw() +
  theme(text = element_text(face = "bold")
  )
```
(This code can be found in the **Question_5.R** file attached to this repository.) 

This produced the output: 

![reproduced_allometric_scaling](https://github.com/poppyjdw/reproducible-research_homework/assets/150140489/abc4d7e1-12f5-4e5f-b301-b10f6fe40862)

### _What is the estimated volume of a 300 kb dsDNA virus? (4)_

I input my estimates for $`α`$ and $`β`$ into the equation $`V = \beta L^{\alpha}`$:

```
L <- 300 
α <- 1.5152
β <- exp(7.0748)

V <- β*L^α
```

This produced an estimated volume of 6697007 nm3. 

### _Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have? (e.g. check the platform [protocols.io](https://www.protocols.io/))._

Reproducibility is the ability to recreate the results of a study using the same data and coding resources. This is important to ensure that the metholodology can be properly critiqued by other researchers, and is therefore an important feature in making research more robust. GitHub is a platform that is used to store and share git repositories (where the code or research of a project can be compiled). This is therefore an important platform for making the methods behind research accessible to be reproduced and tested externally. The ability to compile and collaboratively edit on Github is also important for the purposes of active research, especially as any changes can be tracked so every step can be traced back and understood. 

Replicability, by contrast, is the ability to arrive at the same results  via an independent study that collects new data or uses a new method. This is less about scrutinising the methodology, and more about verifying consistency of the results under new conditions or establishing whether the results are more generalisable to similar test subjects or situations. The forking feature on Github provides a useful means by which new research which builds on the methods or findings of a previous study can be linked back to its foundations. 

Whilst GitHub is an important tool for sharing coding data, it has several drawbacks. The user interface is quite complex and unintuitive, making it less accessible to people who have not been given guidance about how to navigate the platform. Furthermore, even with an understanding of the interface it can be challenging to locate a resource around a general area of research without clearly searching for a single paper. This is where other platforms, such as protocols.io, can useful in tandem with GitHub. Protocols.io provides a dynamic space for the sharing and communication of research, making it easier to explore this platform. However, it does not provide all the detail of how code has developed over time, and so it still may be beneficial to link resources between platforms. Additionally, GutHub might not be the ideal location to store even more detailed walk-throughs of the complete methadology underpinning a paper, and so further programmes could be required to store these. 

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

**Bonus**  Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have? (e.g. check the platform [protocols.io](https://www.protocols.io/)).
 
