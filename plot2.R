setwd("C:/Users/Owner/Documents/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)
library(ggplot2)

#Plot2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

baltimoreNEI <- NEI[which(NEI$fips=="24510"), ]
baltimoredata <- with(baltimoreNEI, aggregate(Emissions, by=list(year), sum))

plot(baltimoredata, type = "o", ylab="Total Emissions", xlab="Year", main="Total Emissions in Baltimore County")


dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()