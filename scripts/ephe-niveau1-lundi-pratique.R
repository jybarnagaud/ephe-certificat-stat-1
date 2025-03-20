#### Introduction aux bases de R ####
# JY Barnagaud
# 17 mars 2025
#-----------------------------------#

## calculs de base -------------------------------------------------------------

calcul1 <- 2+2

calcul1

calcul2 <- log(10)

calcul3 <- log(calcul1)

## ouverture d'une table de données --------------------------------------------

# identifier le dossier où se trouvent les données

wd <- "C:/Users/jeany/OneDrive/Documents/ephe-certificat-stat-1/donnees"
setwd(wd)

# ouvrir le jeu de données

mto <- read.csv("climat_LR.csv", sep = ";",dec = ",", header = T)

# vérification du jeu de données

class(mto)
dim(mto)
head(mto)
view(mto)
str(mto)
summary(mto)
