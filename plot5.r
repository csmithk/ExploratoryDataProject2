library(dplyr)
library(ggplot2)

pm25 <- readRDS("summaryscc_pm25.rds")
pm25 <- subset(pm25, pm25$fips == "24510")
scc <- readRDS("source_classification_Code.rds")
scc$SCC = as.character(scc$SCC)
scc$Short.Name = as.character(scc$Short.Name)

pm25scc <- merge(pm25, scc, by.x = "SCC", by.y = "SCC", all = F)

#get everything with highway veh in the short name
mvRows <- grep("Highway Veh", pm25scc$Short.Name)
#get the rows that have "Highway veh" in them
mv <- pm25scc[mvRows, ]
group <- group_by(mv, year)

mySum <- summarize(group, total = sum(Emissions, na.rm = T))

png (filename = "plot5.png", width = 600, height = 480)
#ggplot2

#ggplot2 library
myPlot <- ggplot(mySum, aes(year, total))
myPlot + geom_point() + ggtitle("Baltimore Motor Vehicle Emissions")

#qplot(year, total, data = mySum, main = "Baltimore Motor Vehicle Emissions")
dev.off()