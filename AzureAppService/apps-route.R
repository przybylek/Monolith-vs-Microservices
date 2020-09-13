Sys.setlocale(category = "LC_ALL", locale = "Polish")
route = read.csv('apps-route.csv')
library(ggplot2)

route$Tier = factor(route$Tier,levels=unique(route$Tier))
route$Architektura = factor(route$Architektura,levels=unique(route$Architektura))

p = ggplot(route, aes(fill=Architektura, y=value, x=factor(Architektura)))
p = p + geom_boxplot()+ facet_grid(Tier~Tech, scales = "free")
p=p+ylab('Przepustowość [l. zapytań/s]')+labs(fill = "Technologia")+xlab("")
p=p+labs(fill = "Architektura",
         title='Testy na Azure AppService',
         subtitle='100 zapytań o zapytań o najkrótszą trasę (Route)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
print(p)