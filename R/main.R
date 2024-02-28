# clean up workspace ------------------------------------------------------
rm(list=ls())

# close all figure --------------------------------------------------------
graphics.off()

# load packages -----------------------------------------------------------
library(readxl)
library(tidyverse)
library(ggthemes)
library(patchwork)
library(extrafont)
library(glue)
library(harrypotter)

# list functions ----------------------------------------------------------
my_R_files <- list.files(path ="functions", pattern = '*.R', 
                          full.names = TRUE)

# Load all functions in R  ------------------------------------------------
sapply(my_R_files, source)

# Import data script ------------------------------------------------------
source("R/01-import-and-clean-data.R")

# Import graphics script --------------------------------------------------
source("R/02-graphics.R")

