#
#
#
#
#
#
#
library(here)
library(tidyr)
library(dplyr)
library(rlang)
library(glue)
library(brms)
library(projpred)
library(purrr)
library(parallel)
library(stringr)
#
#
#
#
data = readRDS(here("data", "data_processed.csv"))
pron_order = c("Jun", "Qing", "Gong", "RuEr")
data = data %>% mutate(PronTypeSimple = factor(PronTypeSimple, levels = pron_order))
#
#
#
load_models = function(models, regex = "model_.*\\.rds"){
    model_files = list.files(here("models"))
    model_files = model_files[str_detect(model_files, "^model_.*\\.rds")]
    models = list()
    for(filename in model_files){
        model_name = str_replace(filename, "\\.rds", "")
        env_pokemodels[[model_name]] = readRDS(here("models", filename))
    }
    models
}
models = load_models()
#
#
#
#
#
#
#
set_prior_pronpredict = function(response_cats, var){
    purrr::reduce(
        lapply(response_cats,
            function(x){
                set_prior(glue("normal(0, {var})"),
                    class = "b",
                    dpar = glue("mu{x}"))
            }
        ),
        c)
}

model_brm_priors = set_prior_pronpredict(pron_order[-1], 4)

#
#
#
#
#
#
num_cores = parallel::detectCores(logical = FALSE) - 2L
get_model_pronpredict = function(formula, chains = 4L, iter = 2000L, cores = 1L){
    brm(formula,
        data = data,
        family = categorical(link = "logit"),
        chains = chains,
        iter = iter,
        prior = model_brm_priors,
        cores = getOption("mc.cores", min(cores, chains)),
        save_pars = save_pars(all = TRUE))
}
#
#
#
#
model_test = get_model_pronpredict(
    bf(PronTypeSimple ~ Power),
    chains = 2L, iter = 1000L,
    cores = num_cores)
#
#
#
#
model_mainonly = get_model_pronpredict(
    bf(PronTypeSimple ~ Power + Intimate + StanceH + StanceS + Kin + ImpositionH + (1 | Speaker)),
    cores = num_cores
)
saveRDS(model_mainonly, file = "models/model_mainonly.rds")
#
#
#
#
model_main_powstanceh = get_model_pronpredict(
    bf(PronTypeSimple ~ Intimate + Power * StanceH + StanceS + Kin + ImpositionH + (1 | Speaker)),
    cores = num_cores
)
#
#
#
#
model_main_powintim = get_model_pronpredict(
    bf(PronTypeSimple ~ Power * Intimate + StanceH + StanceS + Kin + ImpositionH + (1 | Speaker)),
    cores = num_cores
)
model_main_intimstanceh = get_model_pronpredict(
    bf(PronTypeSimple ~ Power + Intimate * StanceH + StanceS + Kin + ImpositionH + (1 | Speaker)),
    cores = num_cores
)
model_full_intim = get_model_pronpredict(
    bf(PronTypeSimple ~ Power * Intimate + Power * StanceH + Intimate * StanceH + StanceS + Kin + ImpositionH + (1 | Speaker)),
    cores = num_cores
)

saveRDS(model_main_powintim, file = "models/model_main_powintim.rds")
saveRDS(model_main_powstanceh, file = "models/model_main_powstanceh.rds")
saveRDS(model_main_intimstanceh, file = "models/model_main_intimstanceh.rds")
saveRDS(model_full_intim, file = "models/model_full_intim.rds")
#
#
#
#
model_main_powkin = get_model_pronpredict(
    bf(PronTypeSimple ~ Power * Intimate + StanceH + StanceS + Kin + ImpositionH + (1 | Speaker)),
    cores = num_cores
)
model_main_kintanceh = get_model_pronpredict(
    bf(PronTypeSimple ~ Power + Intimate * StanceH + StanceS + Kin + ImpositionH + (1 | Speaker)),
    cores = num_cores
)
model_full_kin = get_model_pronpredict(
    bf(PronTypeSimple ~ Power * Kin + Power * StanceH + Kin * StanceH + StanceS + Intimate + ImpositionH + (1 | Speaker)),
    cores = num_cores
)
saveRDS(model_main_powkin, file = "models/model_main_powkin.rds")
saveRDS(model_main_kintanceh, file = "models/model_main_kintanceh.rds")
saveRDS(model_full_kin, file = "models/model_full_kin.rds")
#
#
#
list_files(here("models"))
#
#
#
#
#
#
#loo_compare = loo(model_mainonly, model_full, model_main_powintim, model_main_powstanceh, model_main_intimstanceh, moment_match = TRUE)
kfold_compare = kfold(model_mainonly, model_main_powstanceh,
    model_main_powintim, model_main_intimstanceh,
    model_main_powkin, model_main_kintanceh,
    model_full_kin, model_full_intim)
saveRDS(kfold_compare, file = "models/cv_model_withintim.rds")
#
#
#
#
#

#
#
#
