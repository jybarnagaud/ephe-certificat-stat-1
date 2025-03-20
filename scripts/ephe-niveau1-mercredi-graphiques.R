#### graphiques sous R ####
# 19/03/2025
# formation EPHE
# JY Barnagaud
#------------------------#

library(ggplot2)
library(viridis)
library(patchwork)

## jeu de données --------------------------------------------------------------

mto <- read.csv(
  "donnees/climat_LR.csv",
  sep = ";",
  dec = ",",
  header = T
)

## un histogramme --------------------------------------------------------------

hist(mto$cumul_precip)

# avec ggplot

hist1 <- ggplot(mto)+
  aes(x = cumul_precip)+
  geom_histogram()

# par an

hist2 <- ggplot(mto) +
  aes(x = cumul_precip) +
  geom_histogram() +
  facet_wrap( ~ POSTE)+
  labs(x = "Cumul de précipitations (mm / mois)",
       y = "Fréquence", 
       title = "Pluviométrie en Occitanie")+
  theme_minimal()

## nuage de points -------------------------------------------------------------


np1 <- ggplot(mto) +
  aes(x = temperature_moyenne, 
      y = cumul_precip, col = POSTE) +
  geom_point() +
  labs(x = "Température (°C)",
       y = "Cumul de précipitations (mm / mois)") +
  theme_classic()+
  scale_color_viridis_d()+
  facet_wrap(~POSTE)

## boxplot ---------------------------------------------------------------------

bx1 <- ggplot(mto)+
  aes(x = POSTE, y = cumul_precip)+
  geom_boxplot()

## figure composite ------------------------------------------------------------

(hist1+ np1) / (bx1+plot_spacer())+
  plot_annotation(tag_levels = "a")

## sauvegarder un graphique ----------------------------------------------------

ggsave("outputs/figure_mercredi.png", width = 20, height = 20, units = "cm")


