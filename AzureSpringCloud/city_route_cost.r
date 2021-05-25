# https://en.wikipedia.org/wiki/Pareto_efficiency
# https://ggrepel.slowkow.com/articles/examples.html
# https://ggplot2.tidyverse.org/reference/labellers.html


library(ggplot2)
library(ggrepel)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);  
  data$efficient = factor(data$efficient, levels=unique(data$efficient)) 
  return(data)
}

getPlot <- function(data, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(data, aes(x=cost, y=throughput))
  p = p + geom_point(size=5, aes(color=efficient, shape=Architecture))  
  p = p + ylab(ylabTxt)+xlab(xlabTxt)
  p = p + labs(fill=fillTxt, title=titleTxt, subtitle=subtitleTxt, color="Pareto efficient")
  # p = p + geom_label_repel(
  p = p + geom_text_repel(  
      max.time = 2,
      max.iter = 40000,
      aes(label = Spec),
      size=3.3, # font size
      box.padding = 0.6,      
      point.padding = 0.2,
      min.segment.length = 0, # draw all line segments, no matter how short they are
      max.overlaps = Inf # always show all labels, regardless of too many overlaps
      )
  p = p + scale_color_manual(values = c("#009E73", "#D55E00"))
  p = p + theme_bw()
  p = p + theme(
    # text = element_text(size = 6),
    axis.title.x = element_text(size = 11),
    axis.title.y = element_text(size = 11),
	# strip.text.x = element_text(size = 10), #grid panel header 
	# axis.text.x = element_text(size = 10), #grid panel label
	# axis.text.y = element_text(size = 13), 
    plot.subtitle = element_text(hjust = 0.5, size = 14),
    plot.title = element_text(hjust = 0.5, size = 14)
  )
  p = p + theme(legend.position='bottom')
  return(p)
}

removeLegend <- function(plot) {
      plot = plot + theme(legend.title = element_blank())
      plot = plot + theme(legend.position='none')
      return(plot);
}

dir = 'd:/Workspace/R/mono-vs-ms-results/AzureSpringCloud/'
# dir = 'd:/OneDrive/DOC/Micro/'

#5.4 
csvFile = 'city-cost.csv'
city = dataPreprocessing(dir, csvFile)

ylabTxt = 'Median throughput [Requests per second]'
xlabTxt = 'daily cost'
fillTxt = 'Architecture'
titleTxt = 'Azure Spring Cloud'
titleTxt = NULL
subtitleTxt = '1000x city query'

p1 = getPlot(city, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
# p1 = removeLegend(p1)
print(p1)


#5.6 

subtitleTxt = '100x shortest route'
csvFile = 'route-cost.csv'
route = dataPreprocessing(dir, csvFile)

p2 = getPlot(route, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p2)