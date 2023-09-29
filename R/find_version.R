# find_cran_version_link <- function(package) {
#   tab <- remotes:::package_find_archives(package=package, repo=getOption('repos'), verbose = TRUE)
#   if(!is.null(tab)){
#     
#   only_ver <- rownames(tab)
#   only_ver <- paste0('https://cran.r-project.org/src/contrib/Archive/',only_ver)
#   print(only_ver)
#   
#   
#  # for(i in 1:length(only_ver)){
#  #   
#  #   k <- unlist(strsplit(only_ver[i], '/'))[2]
#  #   print(k)
#  #    }
#   } else {
#     print('either package not found or package only have one version')
#   }
# }
# 
# find_cran_version_link('data.table')
# find.package('data.table')
# find.package('Hmisc')
#'@export
find_all_installed_package <- function(){
  
  k <- installed.packages()
  k <- k[,c('Package','Version')]
  pack <- k[,c(1,2)]
  rownames(pack) <- NULL
  print(pack)
  
}

#'@export
find_installed_location <- function(package='data.table'){
  # package <- 'data.table'
  path <- .libPaths()
  
  for(i in 1:length(path)){
    p <- basename(fs::dir_ls(path[i]))
    if(package %in% p)
      print(paste0(package, ' located: ', path[i],'/',package))
    
    
  }
}

#'@export

find_installed_version <- function(package='data.table'){
  
  k <- installed.packages()
  k <- k[,c('Package','Version','LibPath')]
  pack <- k[,1]
  # package='data.table'
  if(package %in% pack){
    ind <- which(pack %in% package)
    ind <- k[ind,]
    print(ind)
  }
  
}

#'@export
find_cran_version <- function(package='data.table'){
  
  # package <- 'data.table'
  ll <- pak::pkg_history(pkg=package)
  ll <- ll$Version
  print(ll)
  last <- tail(ll,n = 1)
  print('You can find all the version link here: ')
  print(paste0('https://cran.r-project.org/src/contrib/Archive/',
        package, '/'))
  print('Or you can change the version and download or install directly: ')
  print(paste0('https://cran.r-project.org/src/contrib/Archive/',
        package, '/',package,'_',last,'.tar.gz'))
}

