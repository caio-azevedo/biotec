df <- read_excel("data/Dado.xlsx")

metodo <- c("Herschel-Bulkley", "Plástico de Bingham", "Lei de Potência")

dados <- lapply(metodo[1:3],transformar)

dados <- setNames(dados,metodo)


# Transformação por fluído ------------------------------------------------
dados_ <- transformar_2()