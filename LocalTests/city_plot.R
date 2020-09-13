Sys.setlocale(category = "LC_ALL", locale = "Polish")
city = read.csv('local-city.csv')
library(ggplot2)
library(reshape)
library(grid)
meltCity = melt(city)
meltCity$Tech = factor(meltCity$Tech,levels=unique(meltCity$Tech))
p = ggplot(meltCity, aes(fill=variable, y=value, x=factor(variable)))
p = p + geom_boxplot() + facet_wrap(~Tech)
p=p+ylab('Przepustowość [l. zapytań/s]')+xlab("")
p=p+labs(fill = "Architektura",
      title='Testy lokalne',
      subtitle='1000 zapytań o informację o mieście (City)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
print(p)



