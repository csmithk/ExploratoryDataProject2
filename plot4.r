library(dplyr)
library(ggplot2)

pm25 <- readRDS("summaryscc_pm25.rds")
scc <- readRDS("source_classification_Code.rds")
scc$SCC = as.character(scc$SCC)
scc$Short.Name = as.character(scc$Short.Name)

pm25scc <- merge(pm25, scc, by.x = "SCC", by.y = "SCC", all = F)

#get everything with Coal in the short name
coalRows <- grep("Coal", pm25scc$Short.Name)
#get the rows that have "Coal" in them
coal <- pm25scc[coalRows, ]
group <- group_by(coal, year)

mySum <- summarize(group, total = sum(Emissions, na.rm = T))

png (filename = "plot4.png", width = 600, height = 480)
#ggplot2 library

myPlot <- ggplot(mySum, aes(year, total))
myPlot + geom_point()++ggtitle("Baltimore PM2.5 Emissions By Type")

dev.off()