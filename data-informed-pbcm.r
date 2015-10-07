###############################################

# author - akashraj

# data-informed PBCM implementation

###############################################

#load required libraries
library("boot")
library("MASS")
library("fitdistrplus")


#load data
eclipse_data_20 <- read.table("data/eclipse-metrics-files-2.0.csv", header = T, sep = ";")

#select only 'filename' and 'pre' columns
eclipse_20_required_columns = eclipse_data_20[, c("filename", "pre")]
eclipse_20_required_columns = eclipse_20_required_columns[order(-eclipse_20_required_columns$pre), , drop = F]

#select non-null values
eclipse_20_nonnull_rows = eclipse_20_required_columns[eclipse_20_required_columns$pre > 0, ]



#step 1: non-parametric bootstrap

statFunction = function(d, i)
{
  d2 = d
  return (4)
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
generated_data_nonnull_rows = generated_data[generated_data > 0]


#step 2: Fit model A and model B into generated samples resulting in MLE parameter vectors 

#model A = weibull
fitWeibull = fitdist(generated_data_nonnull_rows, "weibull")

#mle parameters after weibull is fit into the generated data
mleParamsA = c(fitWeibull$estimate["shape"], fitWeibull$estimate["scale"])


#step 3: Apply parametric bootstrap to both models


#pBootFunction = function(d, mle)
#{
#  out <- d
#  out$param <- rweibull(length(out), mle[1], mle[2])
#  out
#}
#
#pbootstrap = boot(generated_data_nonnull_rows, statFunction, R = 2, sim = "parametric", ran.gen = pBootFunction, mle = mleParamsA)
#pValues = boot.array(pbootstrap, indices = T)









######## Resources ########

# 1) parametric vs non parametric:  http://stats.stackexchange.com/questions/47253/questions-on-paramatric-and-non-parametric-bootstrap

