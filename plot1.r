
library(dplyr)

pm25 <- readRDS("summaryscc_pm25.rds")

group <- group_by(pm25, year)

mySum <- summarize(group, total = sum(Emissions, na.rm = T))

png (filename = "plot1.png", width = 480, height = 480)
barplot(mySum$total, names = mySum$year, xlab = "Year", ylab = "PM2.5 in tons", main = "US Total PM2.5 Emissions")

dev.off()