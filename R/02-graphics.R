grafs <- lapply(metodo[1:3], grafico)

purrr::walk2(grafs, metodo,
             ~ ggsave(plot = .x,
                      filename = glue('fig/fig_{.y}.png'),
                      dpi = 300,
                      width = 16, height = 10))
