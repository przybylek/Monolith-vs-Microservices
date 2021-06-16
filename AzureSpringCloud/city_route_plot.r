####
library(ggplot2)
library(reshape)
library(grid)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);  
  data$Spec = factor(data$Spec, levels=unique(data$Spec))
  return(data)
}

getPlot <- function(data, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(data, aes(fill=variable, y=value, x=factor(variable)))
  p = p + geom_boxplot(fill=c("lightgoldenrodyellow")) + facet_grid(~Spec, scales="free", space = "free", labeller = labeller(Spec = label_wrap_gen(8)))
  p = p + ylab(ylabTxt)+xlab(xlabTxt)
  p = p + labs(fill=fillTxt, title=titleTxt, subtitle=subtitleTxt)
  p = p + theme_bw(base_size = 14)
  p = p + theme(#text = element_text(size = 20),
    axis.title.y = element_text(size = 11),
		strip.text.x = element_text(size = 10), #grid panel header 
		axis.text.x = element_text(size = 10), #grid panel label
		# axis.text.y = element_text(size = 13), 
    plot.subtitle = element_text(hjust = 0.5, size = 14),
    plot.title = element_text(hjust = 0.5, size = 14)
  )
  return(p)
}

removeLegend <- function(plot) {
      plot = plot + theme(legend.title = element_blank())
      plot = plot + theme(legend.position='none')
      return(plot);
}

dir = 'd:/Workspace/R/mono-vs-ms-results/AzureSpringCloud/'
# dir = 'd:/OneDrive/DOC/Micro/'

#5.3 
csvFile = 'city.csv'
city = dataPreprocessing(dir, csvFile)

ylabTxt = 'Throughput [Requests per second]'
xlabTxt = NULL
fillTxt = 'Architecture'
titleTxt = 'Azure Spring Cloud'
titleTxt = NULL
subtitleTxt = '1000x city query'

p1 = getPlot(city, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
p1 = removeLegend(p1)
print(p1)

#5.5
subtitleTxt = '100x shortest route'
ylabTxt = 'Throughput [Requests per second]'
csvFile = 'route.csv'
route = dataPreprocessing(dir, csvFile)

p2 = getPlot(route, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
p2 = removeLegend(p2)
print(p2)