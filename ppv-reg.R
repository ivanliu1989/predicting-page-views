# predict web traffic
setwd("C:\\Documents and Settings\\Macro\\Desktop\\Ivandata\\predicting-page-views")
require(ggplot2)
top.1000.sites <- read.csv('data/top_1000_sites.tsv',sep='\t',stringsAsFactors=F)
str(top.1000.sites)
head(top.1000.sites)
png('PageViews_UniView.png')
ggplot(top.1000.sites,aes(y=log(PageViews), x=log(UniqueVisitors))) + geom_point() +
    geom_smooth(method='lm',se=F)
dev.off()
ggplot(top.1000.sites,aes(log(PageViews))) + geom_density()

# define slop and intercept
lm.fit <- lm(log(PageViews)~log(UniqueVisitors), data=top.1000.sites)
summary(lm.fit)
    # quantile(residuals(lm.fit))
    # plot(lm.fit)

# model 2
lm.fit <- lm(log(PageViews)~HasAdvertising + log(UniqueVisitors) + InEnglish, data=top.1000.sites)
summary(lm.fit)
png('lm_plot.png')
par(mfcol = c(2,2))
plot(lm.fit)
dev.off()
attach(top.1000.sites)
cov(log(PageViews),log(UniqueVisitors))
detach(top.1000.sites)

top.1000.sites <- transform(top.1000.sites, repeatedVisitor = PageViews - UniqueVisitors)
ggplot(top.1000.sites,aes(y=log(PageViews), x=log(repeatedVisitor))) + geom_point() +
    geom_smooth(method='lm',se=F)
lm.fit.2 <- lm(repeatedVisitor ~ HasAdvertising + InEnglish + TLD + Reach + Category, top.1000.sites)
summary(lm.fit.2)
png('lm_plot_2.png')
par(mfcol = c(2,2))
plot(lm.fit.2)
dev.off()