library(tidyverse)

library(tidymodels)
library(finetune)
library(bonsai)
library(baguette)

library(doMC)
library(parallelly)

availableCores()

registerDoMC(cores = max(1, availableCores() - 1))

wf_set_fit_pca <-
  workflow_map(
    wf_set_pca, 
    fn = "tune_grid", 
    verbose = TRUE, 
    seed = 1,
    resamples = flights_folds,
    control = control_grid(parallel_over = "everything")
  )

save(wf_set_fit_pca, file = "wf_set_fit_pca.rda")