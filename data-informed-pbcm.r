###############################################

# author - akashraj

# data-informed PBCM implementation

###############################################

#load required libraries
library("boot")
library("MASS")
library("fitdistrplus")
library("actuar")


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

fitPareto = fitdist(generated_data_nonnull_rows, "pareto", start = list(shape = 1, scale = 500))
mleParamsB = c(fitPareto$estimate)


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

generated_data_A = rweibull(length(generated_data_nonnull_rows), fitWeibull$estimate["shape"], fitWeibull$estimate["scale"])
generated_data_A = sort(generated_data_A, decreasing = T) #generated_data_A = sort(ceiling(generated_data_A), decreasing = T)

generated_data_B = rpareto(length(generated_data_nonnull_rows), fitPareto$estimate["shape"], fitPareto$estimate["scale"])
generated_data_B = sort(generated_data_B, decreasing = T) #generated_data_B = sort(ceiling(generated_data_B), decreasing = T)


#step 4: cross fitting of models (with each other's generated data)

#fit models A and B with generated_data_A
cross_fit_A_A <- fitdist(generated_data_A, "weibull")
cross_fit_A_B <- fitdist(generated_data_A, "pareto", start = list(shape = 1, scale = 500))

#fit models A and B with generated_data_B
cross_fit_B_A <- fitdist(generated_data_B, "weibull")
cross_fit_B_B <- fitdist(generated_data_B, "pareto", start = list(shape = 1, scale = 500))



######## Resources ########

# 1) parametric vs non parametric:  http://stats.stackexchange.com/questions/47253/questions-on-paramatric-and-non-parametric-bootstrap

