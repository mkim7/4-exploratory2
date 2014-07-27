setwd("C:/Users/Owner/Documents/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)
library(ggplot2)

#Plot4: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

coalSCC <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coalSCC <- SCC[coalSCC,]
coalSCCcharacter <- as.character(coalSCC$SCC)

NEI$SCC <-as.character(NEI$SCC)
coalNEI <- NEI[NEI$SCC %in% coalSCCcharacter, ]

coaldata <- with(coalNEI, aggregate(Emissions, by = list(year), sum))

plot(coaldata, type="o", ylab="Total Emissions", xlab="Year", main="Emissions from Coal Combustion in the US")
        
        
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()