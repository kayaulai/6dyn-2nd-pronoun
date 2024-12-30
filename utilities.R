load_models = function(regex = "^model_.*\\.rds"){
  model_files = list.files(here("models"))
  model_files = model_files[str_detect(model_files, regex)]
  models = list()
  for(filename in model_files){
      model_name = str_replace(filename, "\\.rds", "")
      env_poke(global_env(), model_name, readRDS(here("models", filename)))
  }
}
