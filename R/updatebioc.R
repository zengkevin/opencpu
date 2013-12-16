#this function is called by a cronjob
#not used by the API
updatebioc <- function(){
  #make sure config is initiated
  loadconfigs();
  
  #load library
  biocpath <- file.path(gettmpdir(), "bioc_library");
  
  #nothing to update
  if(!length(list.files(biocpath))){
    message("BIOC library does not exist or is empty. Done.")
    return();
  }
  
  #set path  
  .libPaths(biocpath);
  
  #load BIOC packages
  source("http://bioconductor.org/biocLite.R");
  
  #update
  update.packages(lib.loc=biocpath, repos=biocinstallRepos(), ask = FALSE, checkBuilt=TRUE);
  if(length(list.files(biocpath))){
    system2("touch", paste0(biocpath, "/*"));
  }  
}