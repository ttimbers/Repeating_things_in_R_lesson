##  Repeating things in R study group lesson
by Tiffany Timbers

Dependencies: R, and gapminder & dplyr R packages

### Motivation

One major reason for using a scripting language, such as R or Python, for your data 
analysis is that it makes your more efficient - it is easy once you have written code, to 
apply it to a new set of data. But how about 10 new sets of data? In this lesson, we're
going to discuss the useful tools and strategies, that are available in R, that will help
you become more efficient with your data analysis by easily repeating a command or 
analysis on many things (e.g., datasets). 

### Learning Objectives

After this lesson, learners will be to:

1. write a for loop in R to apply a command (e.g., plotting) or analysis (e.g., linear models) to many datasets

2. use dplyr to to apply an analysis (e.g., linear model) to many datasets

3. Explain why, in R, it is more advantageous to use a tool, such as dplyr, as opposed to a for loop

### Dataset

We will be working with the gapminder dataset for this lesson. You can load the dataset 
by calling the gapminder R package:

~~~
library(gapminder)
head(gapminder)
~~~

~~~
Source: local data frame [6 x 6]

      country continent  year lifeExp      pop gdpPercap
       (fctr)    (fctr) (int)   (dbl)    (int)     (dbl)
1 Afghanistan      Asia  1952  28.801  8425333  779.4453
2 Afghanistan      Asia  1957  30.332  9240934  820.8530
3 Afghanistan      Asia  1962  31.997 10267083  853.1007
4 Afghanistan      Asia  1967  34.020 11537966  836.1971
5 Afghanistan      Asia  1972  36.088 13079460  739.9811
6 Afghanistan      Asia  1977  38.438 14880372  786.1134
~~~

So we can see that this dataset is a dataframe that has 6 columns. What countries are in 
this dataset? We can find that out by asking what are the unique values in the country 
column:

~~~
unique(gapminder$country)
~~~

This returns a list of the 142 countries in the dataset.


For this lesson, we will be focusing plotting `year` versus `lifeExp` for different 
countries. Let's plot this for all the countries together:

~~~
plot(x = gapminder$year, y = gapminder$lifeExp, main = "All Countries")
~~~

![alt text](all_countries.png)


### For Loops in R

It looks like there may be a positive correlation between `year` and `lifeExp`, but does
the relationship look the same for all countries? Let's look at at three different 
countries to start, for example, Canada, the United States and Zimbabwe.

To plot Canada's data, we need to first subset the data, and then plot it:

~~~
Canada <- gapminder[gapminder$country == "Canada",]
plot(x = Canada$year, y = Canada$lifeExp, main = "Canada")
~~~

OK, let's do the same for the United States and Zimbabwe:

~~~
US <- gapminder[gapminder$country == "United States",]
plot(x = US$year, y = US$lifeExp, main = "US")

Zimbabwe <- gapminder[gapminder$country == "Zimbabwe",]
plot(x = Zimbabwe$year, y = Zimbabwe$lifeExp, main = "Zimbabwe")
~~~

We can see that Canada & the US look fairly similar, but something very different happened
in Zimbabwe. How might we plot this data more efficiently, if we wanted to look at another
3 countries, or all 142?

One way we could do this is to use a for loop. A for loop iterates over a list of things, 
and applies the commands within the loop for each item in the list. Let's start with a 
simple example where we print the name of the countries:

~~~
countries_to_plot <- c("Canada", "United States", "Zimbabwe")

for (country in countries_to_plot) {
  print(country)
}
~~~

We can use a similar strategy to plot many things. Let's start with the 3 we have already
plotted, Canada, the United States and Zimbabwe.

~~~ 
countries_to_plot <- c("Canada", "United States", "Zimbabwe")

for (country in countries_to_plot) {
  country_to_plot <-  gapminder[gapminder$country == country,]
  plot(x = country_to_plot$year, y = country_to_plot$lifeExp, main = country)
}
~~~

Now using the code for this loop, we can easily change which countries to plot, and how 
many, we could even plot all 142 like this:

~~~ 
countries_to_plot <- unique(gapminder$country)

for (country in countries_to_plot) {
  country_to_plot <-  gapminder[gapminder$country == country,]
  plot(x = country_to_plot$year, y = country_to_plot$lifeExp, main = country)
}
~~~

Pretty cool right? A word of caution, although loops can be useful, and this seemed pretty
quick, loops in R generally are not that efficient. Looping over a lot of things can be 
very slow, as is looping over commands that use a lot of memory. What can you do in these
cases? You can use some vectorization approaches, that use a faster strategy, which is 
hidden under the hood of R, and we don't really need to worry about the nuts and bolts,
we can just take advantage of them. The one that we will explore today is the package 
`dplyr`.


### Dplyr for repeating analysis on several datasets