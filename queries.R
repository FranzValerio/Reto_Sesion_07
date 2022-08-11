# Reto 01: Sesión 07


# Importamos las bibliotecas a utilizar

library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

# Hacemos la conexión a la base de datos, usamos dbConnect para guardarla como
# un objeto

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# Exploramos un poco las tablas de la DB.

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

# Hacemos la primer query para sólo seleccionar la tabla Country Language

Data.Language <- dbGetQuery(MyDataBase, 'SELECT * FROM CountryLanguage')

# Exploramos un poco más

head(Data.Language)

# Realizamos el filtro de los países de habla hispana con el operador %>% 
# y lo guardamos en la DF "esp"

esp <- Data.Language %>% filter(Language == "Spanish")

# Finalmente, realizamos el gráfico requerido

esp %>% ggplot(aes(x = CountryCode, y = Percentage, fill = IsOfficial)) +
  geom_bin2d() +
  coord_flip()