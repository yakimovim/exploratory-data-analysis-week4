# read data files
pm2data <- readRDS("./data/summarySCC_PM25.rds")
codes <- readRDS("./data/Source_Classification_Code.rds")

coalCombustionCodes <- subset(codes, grepl("Comb", EI.Sector) & grepl("Coal", EI.Sector))
coalCombustionSCC <- coalCombustionCodes$SCC

coalCombustionData <- subset(pm2data, SCC %in% coalCombustionSCC)

coalCombustionEmissionByYear <- tapply(coalCombustionData$Emissions, coalCombustionData$year, sum)

years <- as.numeric(names(coalCombustionEmissionByYear))

plot(
    x = years, 
    y = coalCombustionEmissionByYear, 
    pch = 20, 
    cex = 2,
    xlab = "Year",
    ylab = "Total Coal Combustion Related PM2.5 Emission, tons",
    main = "Coal Combustion Related Emission of PM2.5 in United States"
)

abline(lm(coalCombustionEmissionByYear ~ years), lwd = 2, col = "blue")

dev.copy(png, filename = "plot4.png")
dev.off()