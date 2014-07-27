setwd("C:/Users/Owner/Documents/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)
library(ggplot2)

#Plot6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

motorSCC <- grep("motor", SCC$Short.Name, ignore.case=TRUE)
motorSCC <- SCC[motorSCC, ]
motorSCCcharacter <- as.character(motorSCC$SCC)

NEI$SCC <- as.character(NEI$SCC)
motorNEI <- NEI[NEI$SCC %in% motorSCCcharacter, ]

motordatabaltimore <- motorNEI[which(motorNEI$fips == "24510"), ]
motordatala <- motorNEI[which(motorNEI$fips == "06037"), ]

totalmotordatabaltimore <- with(motordatabaltimore, aggregate(Emissions, by=list(year), sum))
totalmotordatala <- with(motordatala, aggregate(Emissions, by=list(year), sum))

totalmotordatabaltimore$group <- rep("Baltimore County", length(totalmotordatabaltimore[,1]))
totalmotordatala$group <- rep("LA County", length(totalmotordatala[,1]))

baltimore.la <- rbind(totalmotordatabaltimore, totalmotordatala)
baltimore.la$group <- as.factor(baltimore.la$group)

colnames(baltimore.la) <- c("Year", "Emissions", "Group")

qplot(Year, Emissions, data=baltimore.la, group=Group, color=Group, geom=c("point", "line"), ylab="Total Emissions", xlab="Year", main="Emissions from Motor Vehicle Sources for Baltimore and LA")

dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()