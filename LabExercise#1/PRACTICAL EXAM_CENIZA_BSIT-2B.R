#Practical Exam
#A
warpbreaks
#1. Find out, in a single command, which columns of warpbreaks are either numeric or integer.
num1<- sapply(warpbreaks, function(x) is.numeric(x) || is.integer(x))
num1

#2. Is numeric a natural data type for the columns which are stored as such? Convert to integer when necessary.
num2<- as.integer(warpbreaks$breaks)
str(num2)
numeric_names <- names(num1)[num1]
for (col in numeric_names) {
  if (is.numeric(warpbreaks[[col]]) && !is.integer(warpbreaks[[col]])) {
    warpbreaks[[col]] <- as.integer(warpbreaks[[col]])
  }
}



#3. Error messages in R sometimes report the underlying type of an object rather than the user-level class. Derive from the following code and error message what the underlying type.
#Example if you input a vector that contains "13" it will have an error due to the invalid data type  

#----------------------------------------------------------
#B

#1. Read the complete file using readLines.
example_file <- readLines("/cloud/project/LabExercise#1/exampleFile.txt")
example_file
#2. Separate the vector of lines into a vector containing comments and a vector containing the data. Hint: use grepl.
comments <- example_file[grepl("//", example_file)]
data <- example_file[!grepl("//", example_file)]
comments
data

# 3. Extract the date from the first comment line.
num3 <- comments[1]
date <- gsub("// Survey data. Created :", "", num3)
date

#4. Read the data into a matrix as follows.
#a. Split the character vectors in the vector containing data lines by semicolon (;) using strsplit.
num4a <- strsplit(data, ";")
num4a

#b. Find the maximum number of fields retrieved by split. Append rows that are shorter with NA's.
num4bmax <- max(lengths(num4a))
num4a <- lapply(num4a, function(x) {
  if (length(x) < num4bmax) {
    x <- c(x, rep(NA, num4bmax - length(x)))
  }
  return(x)
})
#c. Use unlist and matrix to transform the data to row-column format.
num4c<- matrix(unlist(num4a), ncol = num4bmax, byrow = TRUE)
num4c
#d. From comment lines 2-4, extract the names of the fields. Set these as colnames for the matrix you just created.
num4unlist <- unlist(strsplit(comments[2:4], ";"))
colnames(num4c) <- num4unlist

num4c

write.csv(num4c,file = "Final in PracticalB.csv")






