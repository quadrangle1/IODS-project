### Hanna Haltia, 16 Nov 2023, IODS assignment 3 script with data from http://www.archive.ics.uci.edu/dataset/320/student+performance ###

# Set working directory
setwd("/Users/hchaltia/Open data science course/IODS-project/data")

# Read in the datasets
  mat <- read.csv("student-mat.csv", sep = ";")
  por <- read.csv("student-por.csv", sep = ";")

# Explore the dimensions of the datasets
  str(mat) # 395 rows, 33 columns. Has both character and integer variables.
  str(por) # 649 rows, 33 columns. Also has both character and integer variables.
  
# Join the datasets using all other variables except the ones mentioned in the instructions
  # Load required packages
  library(dplyr)
  
  # Define columns that are not used in the joining
  free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")
  
  # Rest of the columns are used in the joining
  join_cols <- setdiff(colnames(por), free_cols)
  
  # Join the two datasets by the defined columns
  mat_por <- inner_join(mat, por, by = join_cols)
  
  # Look at the column names of the joined dataset
  colnames(mat_por)
  
  # Glimpse at the joined dataset
  str(mat_por) # The joined dataset has 370 rows and 39 columns, still integer and character variables.
  
# Get rid of duplicates
  alc <- select(mat_por, all_of(join_cols))
  for(col_name in free_cols) {
    two_cols <- select(mat_por, starts_with(col_name))
    first_col <- select(two_cols, 1)[[1]]
    if(is.numeric(first_col)) {
      alc[col_name] <- round(rowMeans(two_cols))
    } else {
      alc[col_name] <- first_col
    }
  }

  # Explore dimensions of the created dataset
  dim(alc) # 370 rows and 33 columns
  
# Create alc_use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# Create high_use
alc <- mutate(alc, high_use = alc_use > 2)

# Take a look at the data dimensions again
dim(alc) #370 rows and 35 columns

# Write the dataset into a csv
write_csv(alc, "alc_dataset.csv")



