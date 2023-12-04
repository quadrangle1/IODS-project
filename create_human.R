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
setwd(path)
write_csv(human, file = "human.csv")

### Let's continue the work from the previous week ###

# Read in the pre-prepared data
human <- read.csv("human.csv")
str(human) # 195 observations of 19 variables representing equality and quality of life -related indices and measures per country (life expectancy, HDI etc.)
# The full list of variables is 
#"country" = Country name

# Health and knowledge

#"GNI" = Gross National Income per capita
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate

# Empowerment

#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.F" = Proportion of females with at least secondary education
#"Edu2.M" = Proportion of males with at least secondary education
#"Labo.F" = Proportion of females in the labour force
#"Labo.M" " Proportion of males in the labour force

#"Edu2.FM" = Edu2.F / Edu2.M
#"Labo.FM" = Labo2.F / Labo2.M

# Exclude unnecessary variables
human_analysis <- human %>% select(c("country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"))

# Remove rows with missing values
human_analysis <- na.omit(human_analysis)

# Remove observations related to bigger areas than 1 country
to_delete <- c("Arab States", "East Asia and the Pacific", "Europe and Central Asia", "Latin America and the Caribbean", "	
South Asia", "Sub-Saharan Africa", "World", "South Asia")
human_analysis_subset <- human_analysis[ ! human_analysis$country %in% to_delete, ]
dim(human_analysis_subset) # dimensions 155 9

# Write data into file overwriting the old human data
write_csv(human_analysis_subset, file = "human.csv")












