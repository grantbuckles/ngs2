# Set environment
rm(list = ls(all = TRUE))
LOCAL <- TRUE # change to FALSE if you want to run from data on the network drive

# load libraries
if (!require("pacman")) install.packages("pacman")
library ("pacman")
pacman::p_load(rstan, rstanarm, ggplot2, Hmisc, httr, bridgesampling)

# set directories
if(Sys.info()['sysname'] == "Windows") {
    if(LOCAL) {
        dd <- 'C:/Users/c_pablo_diego-rosell/Desktop/Projects/DARPA/Cycle 2/Analytics/data'
        od <- 'C:/Users/c_pablo_diego-rosell/Desktop/Projects/DARPA/Cycle 2/Analytics/output'
    } else {
        dd <- 'W:/DARPA_NGS2/CONSULTING/Analytics/cycle2/data'
        od <- 'W:/DARPA_NGS2/CONSULTING/Analytics/cycle2/output'
    }
} else if(Sys.info()['sysname'] == 'Darwin') {
    if(LOCAL) {
        dd <- '/Users/matt_hoover/git/ngs2/cycle2/data'
        od <- '/Users/matt_hoover/git/ngs2/cycle2/output'
    } else {
        dd <- '/Volumes/dod_clients/DARPA_NGS2/CONSULTING/Analytics/cycle2/data'
        od <- '/Volumes/dod_clients/DARPA_NGS2/CONSULTING/Analytics/cycle2/output'
    }
}
set.seed(12345)

# download scripts
effects <- getURL(paste(githubRepo, "effects.R", sep = "/"), ssl.verifypeer = FALSE)
 fileConn<-file("effects.R")
 writeLines(effects, fileConn)
 close(fileConn)
wrangle <- getURL(paste(githubRepo, "wrangle.R", sep = "/"), ssl.verifypeer = FALSE)
 fileConn<-file("wrangle.R")
 writeLines(wrangle, fileConn)
 close(fileConn)
analytics <- getURL(paste(githubRepo, "analytics.R", sep = "/"), ssl.verifypeer = FALSE)
 fileConn<-file("analytics.R")
 writeLines(analytics, fileConn)
 close(fileConn)
AL <- getURL(paste(githubRepo, "Active_Learning.R", sep = "/"), ssl.verifypeer = FALSE)
 fileConn<-file("Active_Learning.R")
 writeLines(AL, fileConn)
 close(fileConn)

# run scripts in order
# source effects
source(paste(dd, "effects.R", sep = "/"))

# source data cleaning
source(paste(dd, "wrangle.R", sep = "/"))

# source analysis
source(paste(dd, "analytics.R", sep = "/"))

# active learning
source(paste(dd, "Active_Learning.R", sep = "/"))

# Test hypothesis 1.1
source('h1.1.R')
