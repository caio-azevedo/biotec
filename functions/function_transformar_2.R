transformar_2 <- function(){
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
}
