### Hanna Haltia, 11 Nov 2023, The script for assignment 2 of the IODS course 2023. ###

## Read in the learning14 data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

  # Data structure: 183 observations, 60 variables (gender, age, learning parameters etc.)
  str(lrn14)
  # Data dimensions are thus 183 rows and the 60 columns
  dim(lrn14)
  
## Make analysis data set with compound variables + age, gender, and attitude
  # questions related to deep, surface and strategic learning
  deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
  surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
  strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
  
  # select the columns related to deep learning 
  deep_columns <- select(lrn14, one_of(deep_questions))
  # and create column 'deep' by averaging
  lrn14$deep <- rowMeans(deep_columns)
  
  # select the columns related to surface learning 
  surface_columns <- select(lrn14, one_of(surface_questions))
  # and create column 'surf' by averaging
  lrn14$surf <- rowMeans(surface_columns)
  
  # select the columns related to strategic learning 
  strategic_columns <- select(lrn14, one_of(strategic_questions))
  # and create column 'stra' by averaging
  lrn14$stra <- rowMeans(strategic_columns)
  
  # Select the wanted columns
  lrn14_analysis <- select(lrn14, Age, gender, Attitude, Points, surf, stra, deep)
  
  # Exclude observations with exam points 0
  lrn14_analysis <- filter(lrn14_analysis, Points > 0)

  # See dimensions of the new dataset: 166 rows and 7 columns
  dim(lrn14_analysis)
  
## Set the working directory to the IODS project folder
setwd("/Users/hchaltia/Open data science course/IODS-project/data")

  # Write the new dataset into a csv
  write_csv(lrn14_analysis, file = "lrn14_subset_for_analysis.csv")
  
  # Read the data in again and check that it is correct: 166 rows, 7 columns, and the data looks correct with head()
  lrn14_analysis_again <- read.csv("lrn14_subset_for_analysis.csv")
  str(lrn14_analysis_again)
  head(lrn14_analysis_again)


