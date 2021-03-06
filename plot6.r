
library(dplyr)
library(ggplot2)


pm25 <- readRDS("summaryscc_pm25.rds")
pm25 <- filter(pm25, fips == "24510"  | fips == "06037")
pm25$fips [pm25$fips == "24510"] <- "Baltimore"
pm25$fips [pm25$fips == "06037"] <- "Los Angeles"
colnames(pm25)[1] <- "city"
scc <- readRDS("source_classification_Code.rds")
scc$SCC = as.character(scc$SCC)
scc$Short.Name = as.character(scc$Short.Name)

pm25scc <- merge(pm25, scc, by.x = "SCC", by.y = "SCC", all = F)

#get everything with highway veh in the short name
mvRows <- grep("Highway Veh", pm25scc$Short.Name)
#get the rows that have "Highway veh" in them
mv <- pm25scc[mvRows, ]
mve <- mv[,c("city", "year", "Emissions")]
group <- group_by(mve, city, year)

mySum <- summarize(group, total = sum(Emissions, na.rm = T))

png (filename = "plot6.png", width = 600, height = 480)
#ggplot2 library
myPlot <- ggplot(mySum, aes(city, total))
myPlot + geom_point()+facet_grid(.~city)+ggtitle("Baltimore and Los Angeles Motor Vehicle Emissions")

#qplot(year, total, data = mySum, main = "Baltimore and Los Angeles Motor Vehicle Emissions", facets = .~city )

dev.off()
