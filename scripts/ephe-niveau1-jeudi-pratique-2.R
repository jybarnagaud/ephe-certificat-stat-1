#--------------------------------------#
#### TD du jeudi : modèles linéaires ###
# version mars 2025
# JY Barnagaud
#--------------------------------------#

# Quelle est la relation entre tarse et poids chez deux espèces de mésanges? 

## packages --------------------------------------------------------------------

library(ggplot2)
library(patchwork)
library(viridis)
library(ggeffects)
library(tidyverse)

## données ---------------------------------------------------------------------

biom <- read.table("donnees/mesures_nichoirs.txt",header=T,sep="\t")

# ces fonctions de visualisations ne sont d'habitude pas dans le script mais 
# doivent être utilisées

str(biom)
dim(biom)
summary(biom)
head(biom)

## exploration des données -----------------------------------------------------

# distribution des variables

h1 <- ggplot(biom)+
  aes(x = tarse)+
  geom_histogram()

h2 <- ggplot(biom)+
  aes(x = poids)+
  geom_histogram()

h3 <- ggplot(biom)+
  aes(x = tarse, y = poids)+
  geom_point()

(h1 + h2)/h3

# il semble y avoir deux populations distinctes : les espèces?

h4 <- ggplot(biom)+
  aes(x = poids, fill = espece)+
  geom_histogram()+
  scale_fill_viridis_d()

h5 <- ggplot(biom)+
  aes(x = tarse, y = poids, col = espece)+
  geom_point(alpha = 0.5)+
  scale_color_viridis_d()

h4 + h5

# résumés quantitatifs

quanti.sum <- aggregate(
  biom[, c("tarse", "poids")],
  by = list(biom$espece),
  FUN = function(x) {
    round(c(mean(x, na.rm = T), sd(x, na.rm = T)), 2)
  }
)

quanti.sum <- do.call("data.frame",quanti.sum)
colnames(quanti.sum) <- c("espece","tarse (moyenne, mm)", "tarse (écart-type, mm)",
                          "poids moyen (g)", "poids (écart-type, g)")

## modèle : relation tarse - poids ---------------------------------------------

# données par espèce

parmaj <- subset(biom, espece == "PARMAJ")
parcae <- subset(biom, espece == "PARCAE")

# modèle pour la m. charbonnière

m1.parmaj <- lm(poids ~ tarse, data = parmaj)

# on vérifie les résidus

par(mfrow = c(2,2))
plot(m1.parmaj)

# inférence

summary(m1.parmaj)

pm1 <- ggpredict(m1.parmaj)%>%
  plot(show_data = T)

# idem pour la m. bleue

m2.parcae <- lm(poids ~ tarse, data = parcae)

par(mfrow = c(2,2))
plot(m2.parcae)

summary(m2.parcae)

pm2 <- ggpredict(m2.parcae)%>%
  plot(show_data = T)

# résumé graphique

pm1 + pm2

## modèle alternatif -----------------------------------------------------------

biom$espece <- factor(biom$espece)
m.all <- lm(poids~tarse*espece, data = biom)

par(mfrow=c(2,2))
plot(m.all)

summary(m.all)

pm3 <- ggpredict(m.all, terms = c("tarse","espece"))%>%
  plot(show_data = T)

## prédire la valeur manquante--------------------------------------------------

missdata <-
  subset(biom, is.na(tarse))

# recoder le modèle dans le sens de la prédiction

lmpred <- lm(tarse ~ poids, data = biom, subset = espece == "PARCAE")

new.tarse <- data.frame(poids = missdata$poids)

pred.tarse <- predict(lmpred, newdata = new.tarse, interval = "confidence")

## prédire entre espèces -------------------------------------------------------

new.poids <- data.frame(tarse = parcae$tarse)
pred.poids <- predict(m1.parmaj, newdata = new.poids, interval = "confidence")
pred.poids$true.poids <- parcae$poids
pred.obs <- cbind(pred.poids,parcae)

# est-ce que ça colle avec les vrais poids de parcae?

predtest <- ggplot(pred.obs)+
  aes(x = tarse, y = poids)+
  geom_point()+
  geom_point(aes(x = tarse, y = fit, col = "red"), data = pred.obs)
  