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

statFunction = function(d, i)
{
  d2 = d[i,]
  return (d2$pre)
}

npbootstrap = boot(eclipse_20_required_columns, statFunction, R=2)
values = boot.array(npbootstrap, indices = T)

generated_data <- values[1,]

#sampling with replacement
for(i in 1:ncol(values))
{
	generated_data[i] <- eclipse_20_required_columns[values[2,i], 2]
}

generated_data = sort(generated_data, decreasing = T)


#step 2: Fit model A and model B into generated samples resulting in MLE parameter vectors 



