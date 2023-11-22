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
#' @import utils
#' @importFrom pak pkg_history
#' @importFrom  fs dir_ls
#' @importFrom  fs dir_exists
#' @importFrom  remotes install_version

#' @title find all the installed packages in the current system
#'@export
find_all_installed_package <- function(){

  k <- installed.packages()
  k <- k[,c('Package','Version')]
  pack <- k[,c(1,2)]
  rownames(pack) <- NULL
  print(pack)

}

#' @title find the location where package installed in current system
#' @param package character\cr
#' package name
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

#' @title find version of a package that is already installed in system
#' @param package character\cr
#' package name

#'@export

find_installed_package_version <- function(package='data.table'){

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

#' @title find different versions available for a package in CRAN
#' @param package character\cr
#' package name
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

# remove package from all location

# subset of package in different location

# find all R version installed
#' @title find all R versions that installed in the system

#'@export
find_all_R_version_installed <- function(){

  if(grepl('mingw',R.Version()$os)){

    k <- fs::dir_ls('C:/Program Files/R/')
    print(k)
    l <- fs::dir_ls('C:/Program Files/R/', recurse = T, type = 'file', regexp = 'R.exe$|Rscript.exe$')
    print(l)

  } else{
    if(fs::dir_exists('/opt/R')){

      print(fs::dir_ls('/opt/R/'))
    }
    if(fs::dir_exists('/usr/local/bin/')) {

      k <- grep('R', fs::dir_ls('/usr/local/bin/'),value=T)
      print(k)
    }

    if(fs::dir_exists('/usr/bin/')){

      kk <- grep('R',fs::dir_ls('/usr/bin/'),value=T)
      print(kk)
    }

  }

}

# rversions::r_versions()
#'
#'
#' find R version history

# find_R_version_history <- function(n=10){
# k <- rversions::r_versions()
# data.table::setDT(k)
# l <- k[order(-version),]
# print(l,n)
#
# }

# getRversion()
# R.version.string

# find all R library for all R version

# install from local or url
#' @title interactively select which version to install for a package
#' @param package character\cr
#'@export
install_package_version <- function(package){
  ll <- pak::pkg_history(pkg=package)
  ll <- ll$Version
  # str(ll)
  til <- paste0('Type a number from 1 to ',as.character(length(ll)),
                ': that match version you want to install',
                '. Type 0 to exit')

  k <- menu(ll,title = til)
  if(k!=0){

 k <- ll[k]
 print(paste0('installing :', package, ': version:', k))
  remotes::install_version(package, version = k)

  }
}


# add pak::search()
# different versions finder
# dependency
#' @title find dependency
#' @param package character\cr
#' @export
find_package_dependencies <- function(package) {

  packrat:::recursivePackageDependencies(package, ignores = '',lib.loc = .libPaths()[1])

}


#' @title download source code
#' @param package character\cr
#' @export
download_source_code <- function(package,dir="."){
  untar(download.packages(package, destdir = dir,type = 'source')[,2])

}
