### Hanna Haltia - 7th Dec 2023 - Data wrangling assignment for week 6 ###

## BPRS data wrangling ##
# Read in the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)

# Dimensions and summaries of variables
dim(BPRS) # 40 observations of 11 variables
str(BPRS)
summary(BPRS)

# Change categorical variables into factors
BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)

# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)

# Add variable "week"
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

## RATS data wrangling ##
# Read in the data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Dimensions and summaries of variables
dim(RATS) # 16 observations of 13 variables
str(RATS)
summary(RATS)

# Change categorical variables into factors
RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

# Convert to long form and add variable "time"
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3,4))) %>%
  arrange(Time)

## Check the data 
head(BPRSL, 10)
head(RATSL, 10)

# The long format data has collapsed several columns from the wide format data into one column.

## Write the data into a file
write.csv(BPRSL, file= "BPRSL.csv")
write.csv(RATSL, file = "RATSL.csv")













