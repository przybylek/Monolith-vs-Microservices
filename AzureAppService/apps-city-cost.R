Sys.setlocale(category = "LC_ALL", locale = "Polish")
setwd('C:\\Users\\anna.ojdowska\\Google Drive\\Praca magisterska\\JMeter\\Results\\Processed\\AppService');
cityCost = read.csv('apps-city-cost.csv');
library(ggplot2)
library(ggrepel)

cityCost$dominating = factor(cityCost$dominating,levels=unique(cityCost$dominating))
p = ggplot(cityCost, aes(x=cost, y=throughput)) 

p=p + geom_point(size=4, aes(color=dominating, shape=Architektura))
p=p+ylab('Przepustowość [l. zapytań/s] - mediana') 
p=p+ xlab('Koszt dobowy')
p=p+geom_text_repel(aes(label = Spec), box.padding=0.35, point.padding=0.5,segment.color='grey50', min.segment.length = 0)
p=p+ scale_color_manual(values = c("#009e73", "#D55E00"))
p=p+labs(color="Konfiguracja jest opłacalna",
         title='Testy na Azure AppService',
         subtitle='Stosunek wydajności do kosztu uruchomienia aplikacji (City)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
p=p+facet_grid(~Technologia)
print(p)


# plot only dominating points
Sys.setlocale(category = "LC_ALL", locale = "Polish")
cityCost = read.csv('apps-city-cost.csv');
library(ggplot2)
library(ggrepel)

cityCost$dominating = factor(cityCost$dominating,levels=unique(cityCost$dominating))

p = ggplot(subset(cityCost, dominating %in% c('tak')), aes(x=cost, y=throughput)) 

p=p + geom_point(size=4, aes(shape=Architektura), color='#009E73')
p=p+ylab('Przepustowość [l. zapytań/s] - mediana') 
p=p+ xlab('Koszt dobowy')
p=p+geom_text_repel(aes(label = Spec), box.padding=0.35, point.padding=0.5,segment.color='grey50', min.segment.length = 0)
p=p+labs(title='Testy na Azure AppService',
         subtitle='Stosunek wydajności do kosztu uruchomienia aplikacji (City)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
p=p+facet_grid(~Technologia)
print(p)