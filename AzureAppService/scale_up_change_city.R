# scale up perf change for route
Sys.setlocale(category = "LC_ALL", locale = "Polish")
change = read.csv('vertical-change-route.csv')
library(ggplot2)
library(ggrepel)

change$Spec = factor(change$Spec,levels=unique(change$Spec))
change$SpecGroup = factor(change$SpecGroup,levels=unique(change$SpecGroup))

p = ggplot(subset(change, Typ %in% c('Route')), aes(y=perfDiff, x=SpecGroup)) 
p=p+ylab('Zmiana mediany przepustowości po przeskalowaniu [%]')+xlab('')
p=p + geom_point(size=4, aes(color=Technologia, shape=Spec)) 

# p=p+ facet_grid(Typ~SpecGroup, scales = "free", space="free_x")
p=p+labs(color='Technologia',
         shape='Architektura',
         title='Testy na Azure App Service',
         subtitle='Zmiana w wydajności przy skalowaniu pionowym (Route)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
p=p+scale_shape_manual(values=c(20, 16,18,17,15))
p=p+geom_hline(yintercept=0, linetype="dashed")
print(p)


# scale up perf change for city
Sys.setlocale(category = "LC_ALL", locale = "Polish")
change = read.csv('vertical-change-city.csv')
library(ggplot2)
library(ggrepel)

change$Spec = factor(change$Spec,levels=unique(change$Spec))
change$SpecGroup = factor(change$SpecGroup,levels=unique(change$SpecGroup))

p = ggplot(subset(change, Typ %in% c('Route')), aes(y=perfDiff, x=SpecGroup)) 
p=p+ylab('Zmiana mediany przepustowości po przeskalowaniu [%]')+xlab('')
p=p + geom_point(size=4, aes(color=Technologia, shape=Spec)) 

# p=p+ facet_grid(Typ~SpecGroup, scales = "free", space="free_x")
p=p+labs(color='Technologia',
         shape='Architektura',
         title='Testy na Azure App Service',
         subtitle='Zmiana w wydajności przy skalowaniu pionowym (City)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
p=p+scale_shape_manual(values=c(20, 16,18,17,15))
p=p+geom_hline(yintercept=0, linetype="dashed")
print(p)

