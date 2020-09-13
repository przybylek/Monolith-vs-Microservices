Sys.setlocale(category = "LC_ALL", locale = "Polish")
route = read.csv('local-route.csv');
library(ggplot2)
library(reshape)
library(grid)
meltRoute = melt(route)
meltRoute$Tech = factor(meltRoute$Tech,levels=unique(meltRoute$Tech))
p = ggplot(meltRoute, aes(fill=variable, y=value, x=factor(variable)))
p = p + geom_boxplot() + facet_wrap(~Tech)
p=p+ylab('Przepustowość [l. zapytań/s]')+xlab("")
p=p+labs(fill = "Architektura",
         title='Testy lokalne',
         subtitle='100 zapytań o najkrótszą trasę (Route)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
print(p)




