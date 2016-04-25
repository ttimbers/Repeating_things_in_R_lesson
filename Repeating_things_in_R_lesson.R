library(gapminder)

gap <- gapminder

str(gapminder)

plot(x = gapminder$lifeExp, y = gapminder$year, main = "All Countries")

Canada <- gapminder[gapminder$country == "Canada",]

plot(x = Canada$year, y = Canada$lifeExp, main = "Canada")

USA <- gapminder[gapminder$country == "United States",]

qplot(data = USA, x = lifeExp, y = year, main = "United States")

UK <- gapminder[gapminder$country == "United Kingdom",]

qplot(data = UK, x = lifeExp, y = year, main = "United Kingdom")

Zimbabwe <- gapminder[gapminder$country == "Zimbabwe",]

qplot(data = Zimbabwe, x = lifeExp, y = year, main = "Zimbabwe")

Myanmar <- gapminder[gapminder$country == "Myanmar",]

qplot(data = Myanmar, x = lifeExp, y = year, main = "Zimbabwe")

## or use a loop

countries_to_plot <- c("Canada", "United States", "Myanmar")


for (country in countries_to_plot) {
  print(country)
}


for (country in countries_to_plot) {
  country_to_plot <-  gapminder[gapminder$country == country,]
  plot(country_to_plot$lifeExp ~ country_to_plot$year)
  title(main = country)
}



countries_to_plot <- unique(gapminder$country)

for (country in countries_to_plot) {
  country_to_plot <-  gapminder[gapminder$country == country,]
  plot(country_to_plot$lifeExp ~ country_to_plot$year)
  title(main = country)
}


# or use dplyr

# introduce group_by
# introduce %>%
# introduce do

library(dplyr)

## simpler (even though you get an error)
my_plots <- group_by(gapminder, country) %>% 
  do((plot(x=.$year, y = .$lifeExp, main = .$country[1])))

## no error
my_plots <- group_by(gapminder, country) %>% 
  do( p = print(plot(x=.$year, y = .$lifeExp, main = .$country[1])))

# using ggplot
my_plots <- group_by(gapminder, country) %>% 
  do( p = print(qplot(data = ., x=year, y = lifeExp, main = .$country[1])))

my_plots <- group_by(gapminder, country) %>% 
  do( p = qplot(data = ., x=year, y = lifeExp, main = .$country[1]))

# can access plots with data frame

# numerically
my_plots$p[1]

# or by country name
my_plots$p[my_plots$country =="Canada"]


# Challenge use dplyr to fit linear models between year & lifeExp for every country, have it returned in an dataframe where you can access it by number or country name

group_by(gapminder, country) %>% do(plot = print(qplot(data=(.), x = lifeExp, y = year)))

group_by(gapminder, country) %>% do(plot = print(qplot(data=(.), x = lifeExp, y = year)))


group_by(gapminder, country) %>% do(head(.))

head(gapminder)

plot_species <- function(species_data){
  p <- plot(species_data$Sepal.Length,species_data$Sepal.Width, main=species_data$Species[1])
  print(p)
  
}

group_by(iris, Species) %>% do( p = print(qplot(data=(.), x=Sepal.Length, y=Sepal.Width)))

group_by(iris, Species) %>% do( p = print(plot(.$Sepal.Length, .$Sepal.Width, main=.$Species[1])))

group_by(iris, Species) %>%
  do(plot = plot_species(.))
