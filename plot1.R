# read data files
# pm2data <- readRDS("./data/summarySCC_PM25.rds")
# codes <- readRDS("./data/Source_Classification_Code.rds")

emissionByYear <- tapply(pm2data$Emissions, pm2data$year, sum)

years <- as.numeric(names(emissionByYear))

plot(
    x = years, 
    y = emissionByYear, 
    pch = 20, 
    cex = 2,
    xlab = "Year",
    ylab = "Total PM2.5 Emission, tons",
    main = "Emission of PM2.5 in United States"
    )

abline(lm(emissionByYear ~ years), lwd = 2, col = "blue")

dev.copy(png, filename = "plot1.png")
dev.off()