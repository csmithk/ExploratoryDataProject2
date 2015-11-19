library(dplyr)

pm25 <- readRDS("summaryscc_pm25.rds")
scc <- readRDS("source_classification_Code.rds")
scc$SCC = as.character(scc$SCC)

pm25scc <- merge(pm25, scc, by.x = "SCC", by.y = "SCC", all = F)

group <- group_by(pm25scc, year)

mySum <- summarize(group, total = sum(Emissions, na.rm = T))



