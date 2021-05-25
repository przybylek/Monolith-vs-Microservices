library(ggplot2)
library(reshape)
library(grid)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);
  data = subset(data, select = -Microservices.RPC) #remove Microservices.RPC column
  colnames(data)[which(names(data) == "Microservices.HTTP")] <- "MS"
  meltData = melt(data)
  meltData$Tech = factor(meltData$Tech,levels=unique(meltData$Tech))
  return(meltData)
}

getPlot <- function(meltData, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(meltData, aes(fill=variable, y=value, x=factor(variable)))
  p = p + geom_boxplot() + facet_wrap(~Tech)
  p = p + ylab(ylabTxt)+xlab(xlabTxt)
  p = p + labs(fill=fillTxt, title=titleTxt, subtitle=subtitleTxt)
  p = p + theme_bw(base_size = 14)
  p = p + theme(#text = element_text(size = 20),
    axis.title.y = element_text(size = 12),
		strip.text.x = element_text(size = 13), #grid panel header 
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

dir = 'd:/Workspace/R/mono-vs-ms-results/LocalTests/'
# dir = 'd:/OneDrive/DOC/Micro/'

#5.1 
csvFile = 'local-city.csv'
meltCity = dataPreprocessing(dir, csvFile)

ylabTxt = 'Throughput [Requests per second]'
xlabTxt = NULL
fillTxt = 'Architecture'
titleTxt = 'Local test'
titleTxt = NULL
subtitleTxt = '1000x city query'

p1 = getPlot(meltCity, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)

#5.2
subtitleTxt = '100x shortest route'
ylabTxt = ''
csvFile = 'local-route.csv'
meltRoute = dataPreprocessing(dir, csvFile)

p2 = getPlot(meltRoute, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)

# Assemble multiple plots without legends
library(gridExtra)

p1 = removeLegend(p1)
p2 = removeLegend(p2)
grid.arrange(p1, p2, ncol = 2, nrow = 1)


# Assemble multiple plots and a legend
library(lemon)
grid_arrange_shared_legend(p1, p2, ncol = 2, nrow = 1, position='bottom')
#width=800

