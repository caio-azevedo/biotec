grafico <- function(metodo){
  a <- dados[[metodo]] |>
    mutate(facet=(ifelse(`Fluído de perfuração` %in% c("F1","F2","F3"),1,2))) |> 
    filter(facet==1) |>
    ggplot()+
    geom_point(aes(x=RPM,y=y, shape=`Fluído de perfuração`),size=5)+
    geom_line(aes(x=RPM, y =ty, color=!!sym(metodo)),
              linewidth=2)+
    labs(y = expression(paste(tau,"(Pa)")),
         x = expression(paste(gamma,"(s"^-1,")")))+
    scale_color_hp_d(option = "ronweasley2") +
    scale_x_continuous(breaks=seq(0,1000,100)) +
    scale_y_continuous(breaks=seq(0,50,10), limits = c(0,51))
  
  b <- dados[[metodo]] |>
    mutate(facet=(ifelse(`Fluído de perfuração` %in% c("F1","F2","F3"),1,2))) |> 
    filter(facet==2) |> 
    ggplot()+
    geom_point(aes(x=RPM,y=y, shape=`Fluído de perfuração`),size=5)+
    geom_line(aes(x=RPM, y =ty, color=!!sym(metodo)),
              linewidth=2)+
    labs(y = expression(paste(tau,"(Pa)")),
         x = expression(paste(gamma,"(s"^-1,")"))) +
    harrypotter::scale_color_hp_d(option = "RonWeasley")+
    scale_x_continuous(breaks=seq(0,1000,100)) +
    scale_y_continuous(breaks=seq(0,50,10), limits = c(0,51))
  
  
  a + b +
    plot_layout(axes = "collect_y",axis_titles  = "collect") & tema
}
