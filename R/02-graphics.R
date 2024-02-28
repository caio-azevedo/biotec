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
