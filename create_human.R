### Hanna Haltia 26th Nov 2023 | Data wrangling exercise for week 5 ###

# Read in the data
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Explore the data structure
str(hd)
dim(hd) # 195 observations and 8 variables, mostly numeric but also character variables

str(gii)
dim(gii) # 195 observations and 10 variables, mostly numeric but also character variables

# Create summaries of the variables
summary(hd)
summary(gii)

# Name the variables with shorter descriptive names
names(hd) <- c("HDI.Rank", "country", "HDI", "Life.Exp", "Edu.Exp", "mean_years_education", "GNI", "GNI-HDI_rank")
summary(hd)

names(gii) <- c("GII_rank", "country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")
summary(gii)

# Create the new variables in the gii dataset
library(tidyverse)
gii <- mutate(gii, Edu2.FM = (Edu2.F/Edu2.M))
gii <- mutate(gii, Labo.FM = (Labo.F/Labo.M))

# Join the datasets using country as identifier
human <- inner_join(hd, gii, by = "country")
dim(human) # 195 observations and 19 variables

# Write the new dataset into a file
setwd("/Users/hchaltia/Open data science course/IODS-project/data")
write_csv(human, file = "human.csv")



