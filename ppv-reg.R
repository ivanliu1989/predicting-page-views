# predict web traffic
setwd("C:\\Documents and Settings\\Macro\\Desktop\\Ivandata\\predicting-page-views")
require(ggplot2)
top.1000.sites <- read.csv('data/top_1000_sites.tsv',sep='\t',stringsAsFactors=F)
str(top.1000.sites)
head(top.1000.sites)
ggplot(top.1000.sites,aes(PageViews, UniqueVisitors)) + geom_point()
