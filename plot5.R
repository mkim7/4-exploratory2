setwd("C:/Users/Owner/Documents/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)
library(ggplot2)

#Plot5: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


motorSCC <- grep("motor", SCC$Short.Name, ignore.case=TRUE)
motorSCC <- SCC[motorSCC, ]
motorSCCcharacter <- as.character(motorSCC$SCC)

NEI$SCC <- as.character(NEI$SCC)
motorNEI <- NEI[NEI$SCC %in% motorSCCcharacter, ]

motordatabaltimore <- motorNEI[which(motorNEI$fips == "24510"), ]

totalmotordatabaltimore <- with(motordatabaltimore, aggregate(Emissions, by=list(year), sum))

plot(totalmotordatabaltimore, type="o", ylab="Total Emissions", xlab="Year", main = "Total Emissions from Motor Vehicle Sources in Baltimore City")

dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()