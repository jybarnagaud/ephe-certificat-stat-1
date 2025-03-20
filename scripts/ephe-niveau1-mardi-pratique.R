#-----------------------------------------------#
#### Certificat en analyse de données - EPHE ####
#               version 2025                    #
#       séquence pratique du mardi :            #
#       synthèse de données sous R              #
#       distributions de variables              #
#-----------------------------------------------#

## structures d'objets ---------------------------------------------------------

vecteur1 <- c("A","B","Z","J")
matrice1 <- matrix(c(1:21),nrow = 7)

## Filtrage de données sous R --------------------------------------------------

# ouvrir le jeu de données (chemin relatif depuis la racine du projet)

mto <- read.csv("donnees/climat_LR.csv", sep = ";",dec = ",", header = T)

# indexation

mto[2,3]
mto[5,]
mto[,4]

mto[,"temperature_moyenne"]

hist(mto$temperature_moyenne)

# opérations sur les variables

mean(mto$temperature_moyenne)
sd(mto$temperature_moyenne)

tapply(mto$temperature_moyenne, INDEX = mto$POSTE, FUN = mean)
tapply(mto$temperature_moyenne, INDEX = mto$POSTE, FUN = sd)
tapply(mto$temperature_moyenne, INDEX = mto$POSTE, FUN = range)

aggregate(mto[, c("cumul_precip", "temperature_moyenne")],
          by = list(mto$annee), FUN = median)

# filtres de données

subset1 <- subset(mto,POSTE == "Nimes")

t.moy.sup <- subset(mto,temperature_moyenne > mean(temperature_moyenne))

mpl.precip.sup100 <- subset(mto,POSTE =="Montpellier" & cumul_precip>100)

## Lois de distributions - quelques exemples -----------------------------------

mr <- read.table("donnees/mouette_rieuse_hyeres.txt",
                 header = T,
                 sep = "\t")

hist(mr$comptage)

# Exemple 2

acou <- read.csv2("donnees/petrel_acoustique.csv", dec = ".")

hist(acou$Ph.Du)

hist(acou$Ph.NbSy, freq = F)
lines(density(rpois(1000, 6.252479)))

# Exemple 3

tnz <- read.csv2("donnees/traits_oiseaux_NZ.csv", dec = ",")

hist(tnz$Brood_number)
hist((tnz$Weight_g))

hist(subset(tnz, Weight_g < 3000)$Weight_g)

# Exemple 4

tetras <- read.table("donnees/tetras_lyre.txt", header = T, sep = "\t")

hist(tetras$Nichees)
hist(tetras$Nichees / tetras$Poules)

# Exemple 5

bal <- read.table("donnees/baleines.txt", header = T, sep = "\t")
hist(bal$time_z12)
hist(bal$time_z12[bal$time_z12 > 0])

# Exemple 7

bourgeons <- read.table("donnees/phenologie_arbres.txt", header = T, sep = "\t")
hist(bourgeons$bmean)
