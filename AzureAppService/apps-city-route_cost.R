library(ggplot2)
library(ggrepel)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);  
  data$Efficient = factor(data$Efficient, levels=unique(data$Efficient)) 
  return(data)
}

getPlot <- function(data, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(data, aes(x=Cost, y=Throughput))
  p = p + geom_point(size=3, aes(color=Efficient, shape=Architecture)) 
  p = p + ylab(ylabTxt)+xlab(xlabTxt)
  p = p + labs(title=titleTxt, subtitle=subtitleTxt, color="Pareto efficient")
  p = p + scale_color_manual(values = c("#009e73", "#D55E00"))
  p = p + geom_text_repel(  
      max.time = 4,
      max.iter = 80000,
      aes(label = Spec),
      size=3.2, # font size
      box.padding = 0.35,      
      point.padding = 0.2,
      min.segment.length = 0, # draw all line segments, no matter how short they are
      max.overlaps = Inf # always show all labels, regardless of too many overlaps
      )
  p = p + theme_bw()
  p = p + theme(
    axis.title.x = element_text(size = 11),
    axis.title.y = element_text(size = 11),
    plot.subtitle = element_text(hjust = 0.5, size = 14),
    plot.title = element_text(hjust = 0.5, size = 14)
  )
  p = p + theme(legend.position='bottom')
  p = p + facet_grid(~Technology)
  return(p)
}

dir = 'd:/Workspace/R/mono-vs-ms-results/AzureAppService/'

# 5.10
csvFile = 'apps-city-cost.csv'
city = dataPreprocessing(dir, csvFile)

ylabTxt = 'Median throughput [Requests per second]'
xlabTxt = 'daily cost'
fillTxt = NULL
titleTxt = 'Azure App Service'
titleTxt = NULL
subtitleTxt = '1000x city query'

p1 = getPlot(city, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p1)
# width=1000x667

# 5.17
csvFile = 'apps-route-cost.csv'
route = dataPreprocessing(dir, csvFile)
subtitleTxt = '100x shortest route'

p2 = getPlot(route, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p2)
# width=1000x667


