#----------------------------------------------------------------------
# Alissa Mune & Bruna Wundervald
# R-Ladies Meetup, 21 de Março de 2019
# Usando purrrr com dados do googleAnalytics
#----------------------------------------------------------------------

# Lendo os dados previamente extraídos
load("data/RLadies.RData")

meus_dados <- RLadies

# Vendo a classe dos dados
class(meus_dados)

length(meus_dados)

# Vendo os nomes e classes de cada lista
meus_dados %>% purrr::map(class)
meus_dados %>% purrr::map(names)

# mostra o head dos dataframes
meus_dados %>% 
  purrr::keep(is.data.frame) %>% 
  purrr::map(head, 2)

# pega os tres primeiros itens e empilha em um objeto só
meus_dados %>% 
  magrittr::extract(1:3) %>% 
  purrr::map_dfr(tibble::as_tibble, .id = "id")
  
# transforma a lista numa tabela com list columns
meus_dados %>% 
  purrr::keep(is.data.frame) %>% 
  purrr::map_dfr(~tibble::tibble(tabela = list(.x)), .id = "id")

# gráfico a partir da lista
meus_dados %>% 
  magrittr::extract(1:2) %>% 
  purrr::map_dfr(tibble::as_tibble, .id = "id") %>% 
  ggplot(aes(x = sessions, y = timeOnPage)) +
  geom_point(aes(colour = id), alpha = 0.7) +
  labs(colour = "Lista") +
  theme_bw()

# gráfico a partir da lista, cortando o eixo x
meus_dados %>% 
  magrittr::extract(1:2) %>% 
  purrr::map_dfr(tibble::as_tibble, .id = "id") %>% 
  ggplot(aes(x = sessions, y = timeOnPage)) +
  geom_point(aes(colour = id), alpha = 0.7) +
  labs(colour = "Lista") +
  xlim(0, 50) +
  theme_bw()


