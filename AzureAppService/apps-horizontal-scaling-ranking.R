# Horizontal scaling route
Sys.setlocale(category = "LC_ALL", locale = "Polish")
routeRank = read.csv('Ranking.csv')
library(ggplot2)

routeRank$Spec = factor(routeRank$Spec,levels=unique(routeRank$Spec))
routeRank$SpecGroup = factor(routeRank$SpecGroup,levels=unique(routeRank$SpecGroup))
p = ggplot(subset(routeRank, Typ %in% c('Route') & Spec %in% c('Monolit', 'MSx1', 'MSx3', 'MSx6', 'MSx10')), aes(y=throughput, x=SpecGroup)) 
p=p+ylab('Przepustowość [l. zapytań/s] - mediana')+xlab('')
p=p + geom_point(size=4, shape=18, aes(color=Technologia)) 
p=p+ facet_grid(Typ~Spec, scales = "free", space="free_x")
p=p+labs(title='Testy na Azure App Service',
         subtitle='Wydajność aplikacji w poszczególnych konfiguracjach (Route)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
p=p+scale_shape_manual(values=c(16))
print(p)

# Horizontal scaling city
Sys.setlocale(category = "LC_ALL", locale = "Polish")
cityRank = read.csv('Ranking.csv')
library(ggplot2)

cityRank$Spec = factor(cityRank$Spec,levels=unique(cityRank$Spec))
cityRank$SpecGroup = factor(cityRank$SpecGroup,levels=unique(cityRank$SpecGroup))
p = ggplot(subset(cityRank, Typ %in% c('City') & Spec %in% c('Monolit', 'MSx1', 'MSx3', 'MSx6', 'MSx10')), aes(y=throughput, x=SpecGroup)) 
p=p+ylab('Przepustowość [l. zapytań/s] - mediana')+xlab('')
p=p + geom_point(size=4, shape=18, aes(color=Technologia)) 
p=p+ facet_grid(Typ~Spec, scales = "free", space="free_x")
p=p+labs(title='Testy na Azure App Service',
         subtitle='Wydajność aplikacji w poszczególnych konfiguracjach (City)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
p=p+scale_shape_manual(values=c(16))
print(p)