df <- read_excel("data/Dado.xlsx")

metodo <- c("Herschel-Bulkley", "Plástico de Bingham", "Lei de Potência")

dados <- list()
for (i in 1:3) {
  dados[[i]] <- transformar(metodo[i])
  i <- i + 1
}

dados <- setNames(dados,metodo)