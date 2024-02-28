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