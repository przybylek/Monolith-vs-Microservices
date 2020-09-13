Sys.setlocale(category = "LC_ALL", locale = "Polish")
city = read.csv('city.csv');
library(ggplot2)
library(reshape)
library(grid)
city$Spec = factor(city$Spec,levels=unique(city$Spec))
p = ggplot(city, aes(fill=variable, y=value, x=factor(variable)))
p = p + geom_boxplot() + facet_grid(~Spec, scales="free", space = "free")
p=p+ylab('Przepustowość [l. zapytań/s]')
p=p+labs(fill = "Architektura", 
         title='Testy na Azure Spring Cloud',
         subtitle='1000 zapytań o informację o mieście (City)')+xlab("")
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
print(p)

