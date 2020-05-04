# Dataset: Wines review dataset from Kaggle
# https://www.kaggle.com/zynicide/wine-reviews

# 0) Open dataset with NA values

# Read the dataset with NA-values replaced with "real" NA
wine_data <- read.csv( 'winemag-data-130k-v2.csv', na.string = c('', 'i', 'P'))
head(wine_data)

# 1) Check for NA

# Check if the single value is NA
is.na(wine_data$region_1[2])
# Get all the rows, where Country is NA
wine_data[is.na(wine_data$country),]
# Check if there are NO missing values in Points
all(!is.na(wine_data$points))
# Check if there are missing values in Countries
any(is.na(wine_data$country))

# 2) Check all NAs

# Throws exception, since there are missing values in dataset
na.fail(wine_data)
# Do not throw the exception, since Points column has no missing values
na.fail(wine_data$points)

# 3) Check all NAs in the dataset

# Get the number of rows with missing data
sum(!complete.cases(wine_data))
# Get THE rows with missing data
wine_data[!complete.cases(wine_data), ]

# 4) More practical example - indexes of NA elements

# Get indexes of the rows with Country missing
which(is.na(wine_data$country))

# 5) Advanced is.na usage
test_vec <- c( 'ten', '5', 'n', '25', '10')

# Remove non-convertible strings from the vector
test_vec[!is.na(as.numeric(test_vec))]

# 6) Skipping NAs

# Price column contains NAs. And regular operation gives NA as result
mean(wine_data$price)
# Skipping NAs
mean(wine_data$price, na.rm = T)

# 7) Skip NAs for dataset

wine_data_totally_cleared_1 <- na.omit(wine_data)

wine_data_totally_cleared_2 <- wine_data[complete.cases(wine_data),]

# 8) Skip NAs conditionally

# Returns the subset with NA
wine_data_condition_NA <- wine_data[wine_data$price > 20,]

# Returns the subset without NAs
wine_data_condition <- subset(wine_data, wine_data$price > 20)

# Checking
sum(!complete.cases(wine_data_condition_NA))
sum(!complete.cases(wine_data_condition))


# 9) mice package
install.packages('mice')
require(mice)

wine_data[1:5, 4:8]

# Get the map of missing data
# Left index - number of rows, right index - number of missing features. Matrix - feature is present or not
md.pattern(wine_data[1:5, 4:8], plot = F)
md.pattern(wine_data, plot = F)

# 10) Visualization
install.packages('VIM')
require(VIM)

# Plots the distribution of missing values and the chart of patterns
aggr_plot <- aggr(wine_data[1:5, 4:8], col=c('navyblue','red'),
                  numbers=TRUE, sortVars=TRUE, labels=names(wine_data[1:5, 4:8]),
                  ylab=c("Histogram of missing data","Pattern"))

aggr_plot <- aggr(wine_data, col=c('navyblue','red'),
                  numbers=TRUE, labels=colnames(wine_data),
                  ylab=c("Histogram of missing data","Pattern"))
