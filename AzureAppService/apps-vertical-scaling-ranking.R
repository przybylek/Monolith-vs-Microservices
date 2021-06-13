# vertical scaling
library(ggplot2)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);  
  data$Spec = factor(data$Spec, levels=unique(data$Spec))
  data$SpecGroup = factor(data$SpecGroup, levels=unique(data$SpecGroup))
  return(data)
}

getPlot <- function(data, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(data, aes(y=Throughput, x=Spec))
  p = p + geom_point(size=4, aes(color=Technology)) 
  p = p + scale_color_manual(values = c("orange", "blue4"))
  p = p+ facet_grid(Type~SpecGroup, scales = "free", space="free_x") 
  p = p + ylab(ylabTxt)+xlab(xlabTxt)
  p = p + labs(fill=fillTxt, title=titleTxt, subtitle=subtitleTxt)
  p = p + theme_bw()
  p = p + theme(
    legend.position='bottom',
    legend.title=element_text(size=11), 
    legend.text=element_text(size=10),
    axis.title.y = element_text(size = 10),		
		axis.text.x = element_text(size = 8), #grid panel label
		# axis.text.y = element_text(size = 13), 
    strip.text.y = element_blank(), # remove right bar with Type
    plot.subtitle = element_text(hjust = 0.5, size = 12),
    plot.title = element_text(hjust = 0.5, size = 12)
  )
  p = p + scale_shape_manual(values=c(16,18))
  return(p)
}

removeLegend <- function(plot) {
      plot = plot + theme(legend.title = element_blank())
      plot = plot + theme(legend.position='none')
      return(plot);
}

dir = 'd:/Workspace/R/mono-vs-ms-results/AzureAppService/'
csvFile = 'Ranking.csv'
data = dataPreprocessing(dir, csvFile)

#5.7
city = subset(data, Type %in% c('City'))

ylabTxt = 'Median throughput [Requests per second]'
xlabTxt = NULL
fillTxt = 'Architecture'
titleTxt = 'Azure App Service'
titleTxt = NULL
subtitleTxt = '1000x city query'

p1 = getPlot(city, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p1)
# 1000x383

#5.14
route = subset(data, Type %in% c('Route'))
subtitleTxt = '100x shortest route'

p2 = getPlot(route, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p2)
# 1000x383