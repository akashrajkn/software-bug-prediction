###############################################

# author - akashraj

# data-informed PBCM implementation

###############################################

#load required libraries
library(boot)


#load data
eclipse_data_20 <- read.table("data/eclipse-metrics-files-2.0.csv", header = T, sep = ";")

#select only 'filename' and 'pre' columns
eclipse_20_required_columns = eclipse_data_20[, c("filename", "pre")]
eclipse_20_required_columns = eclipse_20_required_columns[order(-eclipse_20_required_columns$pre), , drop = F]

#select non-null values
eclipse_20_nonnull_rows = eclipse_20_required_columns[eclipse_20_required_columns$pre > 0, ]



#step 1: non-parametric bootstrap

## http://stackoverflow.com/questions/10264025/r-sample-a-vector-with-replacement-multiple-times
#replicate(10,sample(x,length(x),replace = TRUE))
##

