#--------------------------------------------------------#
#### script du test de synthèse - certificat niveau 1 ####
# version 2025
#--------------------------------------------------------#

## données ---------------------------------------------------------------------

hyeres <- read.table("donnees/mouette_rieuse_hyeres.txt",
                 header = T,
                 sep = "\t")

## exploration -----------------------------------------------------------------

hist(hyeres$temperature)
hist(hyeres$o2)

plot(lr$temperature, lr$o2)

## modèle ----------------------------------------------------------------------

modhyeres <- lm(o2 ~ temperature, data = hyeres)

par(mfrow=c(2,2))
plot(modhyeres)

summary(modhyeres)
confint(modhyeres)
