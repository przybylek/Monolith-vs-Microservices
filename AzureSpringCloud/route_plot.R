Sys.setlocale(category = "LC_ALL", locale = "Polish")
setwd('C:\\Users\\anna.ojdowska\\Google Drive\\Praca magisterska\\JMeter\\Results\\Processed\\SpringCloud');
route = read.csv('route.csv');
library(ggplot2)
library(reshape)
library(grid)
route$Spec = factor(route$Spec,levels=unique(route$Spec))
p = ggplot(route, aes(fill=variable, y=value, x=factor(variable)))
p = p + geom_boxplot() + facet_grid(~Spec, scales="free", space = "free")
p=p+ylab('Przepustowość [l. zapytań/s]')+xlab("")
p=p+labs(fill = "Architektura", 
         title='Testy na Azure Spring Cloud',
         subtitle='100 zapytań o zapytań o najkrótszą trasę (Route)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
print(p)

