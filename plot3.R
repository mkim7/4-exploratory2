setwd("C:/Users/Owner/Documents/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)
library(ggplot2)

#Plot3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

baltimoreNEI <- NEI[which(NEI$fips=="24510"), ]
baltimoredata <- with(baltimoreNEI, aggregate(Emissions, by=list(year), sum))

baltimoredata.type <- ddply(baltimoreNEI, .(type,year), summarize, Emissions = sum(Emissions))

baltimoredata.type$Pollutant_Type <- baltimoredata.type$type

qplot(year, Emissions, data = baltimoredata.type, group=Pollutant_Type, color = Pollutant_Type, geom=c("point", "line"), ylab="Total Emissions", xlab="Year", main="Total Emissions in the US by Pollutant Type")

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()