setwd("C:/Users/Owner/Documents/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)
library(ggplot2)

#Plot1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

totaldata <- with(NEI, aggregate(Emissions, by = list(year), sum))

plot(totaldata, type = "o", ylab="Total Emissions", xlab="Year", main="Total Emissions in the US")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

