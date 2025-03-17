#-----------------------------------------------#
#### Certificat en analyse de données - EPHE ####
#               version 2025                    #
#       séquence pratique du mardi :            #
#       distributions de variables              #
#-----------------------------------------------#

# Exemple 1

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
