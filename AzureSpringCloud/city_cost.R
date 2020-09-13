Sys.setlocale(category = "LC_ALL", locale = "Polish")
cityCost = read.csv('city-cost.csv');
library(ggplot2)
library(ggrepel)

cityCost$dominating = factor(cityCost$dominating,levels=unique(cityCost$dominating))

p = ggplot(cityCost, aes(x=cost, y=throughput)) 
p=p + geom_point(size=5, aes(color=dominating, shape=Architektura))
p=p+ylab('Przepustowość [l. zapytań/s] - mediana') 
p=p+ xlab('Koszt dobowy (urealniony)')
p=p+geom_text_repel(aes(label = Spec), box.padding=0.35, point.padding=0.5,segment.color='grey50', min.segment.length = 0)
p=p+ scale_color_manual(values = c("#009E73", "#D55E00"))
p=p+labs(color="Konfiguracja jest opłacalna",
         title='Testy na Azure Spring Cloud',
         subtitle='Stosunek wydajności do kosztu uruchomienia aplikacji (City)')
p=p+theme(plot.title = element_text(hjust = 0.5, size=14), 
          plot.subtitle = element_text(hjust = 0.5, size = 13))
print(p)
