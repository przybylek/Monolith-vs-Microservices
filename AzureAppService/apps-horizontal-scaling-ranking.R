# Horizontal scaling
library(ggplot2)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);  
  data$Spec = factor(data$Spec, levels=unique(data$Spec))
  data$SpecGroup = factor(data$SpecGroup, levels=unique(data$SpecGroup))
  return(data)
}

getPlot <- function(data, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(data, aes(y=Throughput, x=SpecGroup))
  p = p + geom_point(size=4, aes(color=Technology)) 
  p = p + scale_color_manual(values = c("orange", "blue4"))
  p = p+ facet_grid(Type~Spec, scales = "free", space="free_x")
  p = p + ylab(ylabTxt)+xlab(xlabTxt)
  p = p + labs(title=titleTxt, subtitle=subtitleTxt)
  p = p + theme_bw()
  p = p + theme(#element_blank()
      legend.position='bottom',
      legend.title=element_text(size=11), 
      legend.text=element_text(size=10),
      axis.title.y = element_text(size = 10),		
      strip.text.x = element_text(size = 10), #grid panel header 
      axis.text.x = element_text(size = 8), #grid panel label
      strip.text.y = element_blank(), # remove right bar with Type
      plot.subtitle = element_text(hjust = 0.5, size = 12),
      plot.title = element_text(hjust = 0.5, size = 12)
  )
  p = p + scale_shape_manual(values=c(16))
  return(p)
}

dir = 'd:/Workspace/R/mono-vs-ms-results/AzureAppService/'
csvFile = 'Ranking.csv'
data = dataPreprocessing(dir, csvFile)

#5.8
city = subset(data, Type %in% c('City') & Spec %in% c('Monolith', 'MSx1', 'MSx3', 'MSx6', 'MSx10'))    

ylabTxt = 'Median throughput [Requests per second]'
xlabTxt = NULL
fillTxt = NULL
titleTxt = 'Azure App Service'
titleTxt = NULL
subtitleTxt = '1000x city query'

p1 = getPlot(city, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p1)
# 1000x383
# size=14

#5.15
route = subset(data, Type %in% c('Route') & Spec %in% c('Monolith', 'MSx1', 'MSx3', 'MSx6', 'MSx10'))
subtitleTxt = '100x shortest route'

p2 = getPlot(route, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p2)
# 1000x383 
