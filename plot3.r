library(dplyr)
library(ggplot2)

pm25 <- readRDS("summaryscc_pm25.rds")
baltimore <- subset(pm25, pm25$fips == "24510")
group <- group_by(baltimore, year, type)

mySum <- summarize(group, total = sum(Emissions, na.rm = T))

png (filename = "plot3.png", width = 600, height = 480)
#ggplot2 library
#ggplot2 library
myPlot <- ggplot(mySum, aes(year, total))
myPlot + geom_point()+facet_grid(.~type)+ggtitle("Baltimore PM2.5 Emissions By Type")
#qplot(year, total, data = mySum, facets = .~ type, main = "Baltimore PM2.5 Emissions By Type")
dev.off()
