rm(list=ls())

library(readxl)
library(tidyverse)
library(ggthemes)
library(patchwork)
library(extrafont)
library(readxl)
library(glue)

df <- read_excel("data/Dado.xlsx")


transformar <- function(metodo){
dados <- df |> 
  select("RPM"=1, num_range("F",1:5) ,"TF"=contains(metodo)) |> 
  pivot_longer(cols = c("F1","F2","F3","F4","F5"),
               values_to = "y",
               names_to = "f") |> 
  pivot_longer(cols = c("TF1","TF2","TF3","TF4","TF5"),
               values_to = "ty",
               names_to = "TF") |> 
  mutate(TF = substr(TF,2,3)) |> 
  filter(f==TF) |> 
  rename("Fluído de perfuração" = f,
         !!metodo := TF) 
}

metodo <- c("Herschel-Bulkley", "Plástico de Bingham", "Lei de Potência")

dados <- list()
for (i in 1:3) {
dados[[i]] <- transformar(metodo[i])
i <- i + 1
}

dados <- setNames(dados,metodo)

# Tema --------------------------------------------------------------------

extrafont::loadfonts()
tema <- ggthemes::theme_hc() +
  theme(axis.title = element_text(
    family = "Times New Roman",
    face = "bold",
    size = 20
  ),
  axis.text = element_text(
    family = "Times New Roman",
    size = 15
  ),
  plot.caption = element_text(
    family = "Times New Roman",
    face = "bold",
    size = 15,
    hjust = 1
  ),
  legend.text = element_text(
    family = "Times New Roman",
    face = "bold",
    size = 14
  ),
  legend.title = element_text(
    family = "Times New Roman",
    size = 14 ))


# Gráficos ----------------------------------------------------------------

grafico <- function(metodo){
  a <- dados[[metodo]] |>
  mutate(facet=(ifelse(`Fluído de perfuração` %in% c("F1","F2","F3"),1,2))) |> 
  filter(facet==1) |>
  ggplot()+
  geom_point(aes(x=RPM,y=y, shape=`Fluído de perfuração`),size=5)+
  geom_line(aes(x=RPM, y =ty, color=!!sym(metodo)),linewidth=2)+
  labs(y = expression(paste(tau,"(Pa)")),
       x = expression(paste(gamma,"(s"^-1,")")))+
  ggthemes::scale_color_few() +
  scale_x_continuous(breaks=seq(0,1000,100)) +
  scale_y_continuous(breaks=seq(0,50,10)) + ylim(c(0,51))

b <- dados[[metodo]] |>
  mutate(facet=(ifelse(`Fluído de perfuração` %in% c("F1","F2","F3"),1,2))) |> 
  filter(facet==2) |> 
  ggplot()+
  geom_point(aes(x=RPM,y=y, shape=`Fluído de perfuração`),size=5)+
  geom_line(aes(x=RPM, y =ty, color=!!sym(metodo)),linewidth=2)+
  labs(y = expression(paste(tau,"(Pa)")),
       x = expression(paste(gamma,"(s"^-1,")"))) +
  ggthemes::scale_color_canva()+
  scale_x_continuous(breaks=seq(0,1000,100)) +
  scale_y_continuous(breaks=seq(0,50,10)) + ylim(c(0,51))


a + b +
  plot_layout(axes = "collect_y",axis_titles  = "collect") & tema
}

lista_g <- c("Herschel-Bulkley", "Plástico de Bingham", "Lei de Potência")

grafs <- list()
for (i in 1:3) {
  grafs[[i]] <- grafico(metodo[i])
  i <- i + 1
}

purrr::walk2(grafs, lista_g,
             ~ ggsave(plot = .x,
                      filename = glue('fig/fig_{.y}.png'),
                      dpi = 300,
                      width = 16, height = 10))
