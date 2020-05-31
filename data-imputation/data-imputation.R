library(mice)


# Create toy example
df_test <- data.frame()
df_test <- rbind(df_test, c(1.0, 2.0, NA,  2.0, 5.0))
df_test <- rbind(df_test, c(NA,  8.0, 4.0, 5.0, 1.0))
df_test <- rbind(df_test, c(3.0, 4.0, 7.0,  NA, 2.0))
df_test <- rbind(df_test, c(4.0, NA,  1.0, 6.0, 3.0))
df_test <- rbind(df_test, c(5.0, 1.0, 2,   3.0, NA))
df_test <- rbind(df_test, c(9.0, 4.0, NA,  3.0, NA))

names(df_test) <- c("First", "Second", "Third", "Fourth", "Fifth")
df_test$First_cat <- c("Cat1", "Cat2", NA, "Cat1", "Cat2", "Cat2")
df_test$First_cat <- factor(df_test$First_cat)


# Count missing values
sapply(df_test, function(x) sum(is.na(x)))


# Get pattern of missing data
md.pattern(df_test)

# Prepare the initial template for imputing methods
init <- mice(df_test, meth="mean", maxit=0)

methods(mice)

# Exclude variable from imputation

init$predictorMatrix[, c("Second")]=0
init$method[c("Second")]=""

# Set imputing methods
init$method[c("First_cat")]="logreg"

init$method[c("Third")]="mean" 
init$method[c("Fourth")]="norm"

# predictive mean matching
init$method[c("Fifth")]="pmm"

# Imputing itself
imputation <- mice(df_test, method=init$method, predictorMatrix=init$predictorMatrix, maxit=10, m = 5, seed=123)

# Get info
summary(imputation)

imputation$method

imputation$imp

# Get concrete daatset
complete(imputation, 2)

imputed <- complete(imputation, 5)
