
# Gráficos por métodos ----------------------------------------------------

grafs <- lapply(metodo[1:3], grafico)

purrr::walk2(grafs, metodo,
             ~ ggsave(plot = .x,
                      filename = glue('fig/fig_{.y}.png'),
                      dpi = 300,
                      width = 16, height = 10))

# Gráfico por fluído ------------------------------------------------------
ggplot(dados_, aes(x = RPM, y = y, color=metodo_fluido)) +
  geom_point(data = subset(dados_, metodo_fluido == fluido), shape = 16,
             size=5) +
  geom_line(data = subset(dados_, metodo_fluido != fluido),
            linewidth=1.2) +
  facet_wrap(~fluido, nrow=3) +
  labs(y = expression(paste(tau,"(Pa)")),
       x = expression(paste(gamma,"(s"^-1,")")),
       color = "") + scale_color_manual(values=c("#d7a7eb","#ebdd60",
                                                 "#ac8279","#00ffff",
                                                 "#003366","red","green",
                                                 "blue"))+
   tema


ggsave(filename = "fig/fig_fluidos.png",
       dpi = 300,
       width = 16, height = 10)
