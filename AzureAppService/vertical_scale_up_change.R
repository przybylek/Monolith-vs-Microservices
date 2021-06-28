# vertical scaling
# scale up perf change for route

library(ggplot2)
library(ggrepel)

dataPreprocessing <- function(dir, csvFile){
  path = paste(dir, csvFile, sep = "")
  data = read.csv(path);  
  data$Spec = factor(data$Spec, levels=unique(data$Spec))
  data$SpecGroup = factor(data$SpecGroup, levels=unique(data$SpecGroup))
  return(data)
}

getPlot <- function(data, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt){
  p = ggplot(data, aes(y=perfDiff, x=SpecGroup))
  p = p + geom_point(size=3, aes(color=Technology, shape=Spec)) 
  p = p + scale_color_manual(values = c("orange", "blue4")) 
  p = p + ylab(ylabTxt)+xlab(xlabTxt)
  p = p + labs(title=titleTxt,
               subtitle=subtitleTxt,
               color='Technology',
               shape='Architecture'
               )
  p = p + theme_bw()
  p = p + theme(
      # axis.title.y = element_text(size = 10),
	    # axis.text.y = element_text(size = 13),
      plot.subtitle = element_text(hjust = 0.5, size = 14),
      plot.title = element_text(hjust = 0.5, size = 14)
  )
  p = p + scale_shape_manual(values=c(20, 16,18,17,15))
  p = p + geom_hline(yintercept=0, linetype="dashed")
  return(p)
}

dir = 'd:/Workspace/R/mono-vs-ms-results/AzureAppService/'
ylabTxt = 'Change in the median throughput when scaling up [%]'
xlabTxt = NULL
fillTxt = NULL
titleTxt = 'Azure App Service'
titleTxt = NULL
subtitleTxt = '1000x city query'

# 5.13
csvFile = 'vertical-change.csv'
data = dataPreprocessing(dir, csvFile)
cityVertical = subset(data, Type %in% c('City'))

p1 = getPlot(cityVertical, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p1)
# 574x700

# 5.20
routeVertical = subset(data, Type %in% c('Route'))
subtitleTxt = '100x shortest route'

p2 = getPlot(routeVertical, titleTxt, subtitleTxt, xlabTxt, ylabTxt, fillTxt)
print(p2)
# 574x700

