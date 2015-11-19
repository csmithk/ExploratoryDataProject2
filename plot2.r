library(dplyr)

pm25 <- readRDS("summaryscc_pm25.rds")
baltimore <- subset(pm25, pm25$fips == "24510")
group <- group_by(baltimore, year)

mySum <- summarize(group, total = sum(Emissions, na.rm = T))

png (filename = "plot2.png", width = 480, height = 480)
barplot(mySum$total, names = mySum$year, xlab = "Year", ylab = "PM2.5 in tons", main = "Baltimore Total PM2.5 Emissions")

dev.off()