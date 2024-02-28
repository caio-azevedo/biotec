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


# Import data script ------------------------------------------------------
df <- read_excel("data/Dado.xlsx")

dados_1 <- df |> 
  select("RPM"=1, num_range("F",1:5)) |> 
  tidyr::pivot_longer(cols = 2:6,
                      names_to = "metodo_fluido",
                      values_to = "y")

dados_ <- df |> 
  select(-num_range("F",1:5)) |> 
  rename("RPM"=1) |> 
  tidyr::pivot_longer(cols=2:16,
                      names_to = "metodo_fluido",
                      values_to = "y") |> 
  bind_rows(dados_1) |> 
  mutate("fluido"=str_sub(metodo_fluido,nchar(metodo_fluido)-1,
                          nchar(metodo_fluido))) |> 
  mutate("metodo_fluido"=ifelse(nchar(metodo_fluido) > 2,
                                str_sub(metodo_fluido,1,nchar(metodo_fluido)-2),
                                metodo_fluido)) 




# Import graphics script --------------------------------------------------

ggplot(dados_, aes(x = RPM, y = y, color=metodo_fluido)) +
  geom_point(data = subset(dados_, metodo_fluido == fluido), shape = 16,
             size=5) +
  geom_line(data = subset(dados_, metodo_fluido != fluido),
            linewidth=2) +
  facet_wrap(~fluido, nrow=3) +
  labs(y = expression(paste(tau,"(Pa)")),
       x = expression(paste(gamma,"(s"^-1,")"))) +
  scale_color_viridis_d()

