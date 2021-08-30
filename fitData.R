
library(rstan)
# To run in parallel on multiple cores
options(mc.cores=parallel::detectCores())
dev.off()

# To avoid recompiling unchanged Stan program
rstan_options(auto_write=TRUE)

source("./toyData.R")

dataStan <- list(y=y, TT=TT, z0=0)

f2pStan <- stan(file = "./model.stan",
	data = dataStan, chains = 3, iter = 3000)

# Traceplot for sdp
traceplot(f2pStan, pars = c("sdp", "sdo"))
stan_dens(f2pStan, pars = c("sdp", "sdo"))

rstan::check_hmc_diagnostics(f2pStan)

#### Trying with my model (I should get similar results)
results <- stan(file = "./myVersion.stan",
	data = dataStan, chains = 3, iter = 3000)

# Traceplot for sdp
traceplot(results, pars = "sdp", inc_warmup = TRUE)

rstan::check_hmc_diagnostics(results)

#### Trying with a second version of my model (I should get similar results)
results_2 <- stan(file = "./myVersion_2.stan",
	data = dataStan, chains = 3, iter = 3000)

# Traceplot for sdp
traceplot(results_2, pars = "sdp", inc_warmup = TRUE)

rstan::check_hmc_diagnostics(results_2)
