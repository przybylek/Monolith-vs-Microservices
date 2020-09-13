# Aggregated plot for AppService city test
Sys.setlocale(category = "LC_ALL", locale = "Polish")
city = read.csv('apps-city.csv')
library(ggplot2)

city$Tier = factor(city$Tier,levels=unique(city$Tier))
city$Architektura = factor(city$Architektura,levels=unique(city$Architektura))

p = ggplot(city, aes(fill=Architektura, y=value, x=factor(Architektura)))
p = p + geom_boxplot()+ facet_grid(Tier~Tech, scales = "free")
p=p+ylab('Przepustowość [l. zapytań/s]')+labs(fill = "Technologia")+xlab("")
p=p+labs(fill = "Architektura",
         title='Testy na Azure AppService',
         subtitle='1000 zapytań o informację o mieście (City)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
print(p)


