library(ggplot2)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);  
  data$Tier = factor(data$Tier,levels=unique(data$Tier))
  data$Architecture = factor(data$Architecture,levels=unique(data$Architecture))
  return(data)
}

getPlot <- function(data, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(data, aes(fill=Architecture, y=Value, x=factor(Architecture)))
  p = p + geom_boxplot(fill=c("lightgoldenrodyellow"))+ facet_grid(Tier~Technology, scales = "free")
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
    plot.subtitle = element_text(hjust = 0.5, size = 12),
    plot.title = element_text(hjust = 0.5, size = 12)
  )
  return(p)
}

dir = 'd:/Workspace/R/mono-vs-ms-results/AzureAppService/'
csvFile = 'apps-city.csv'
city = dataPreprocessing(dir, csvFile)

ylabTxt = 'Median throughput [Requests per second]'
xlabTxt = NULL
fillTxt = 'Architecture'
titleTxt = 'Azure App Service'
titleTxt = NULL
subtitleTxt = '1000x city query'

p1 = getPlot(city, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p1)


csvFile = 'apps-route.csv'
route = dataPreprocessing(dir, csvFile)
subtitleTxt = '100x shortest route'

p2 = getPlot(route, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p2)

