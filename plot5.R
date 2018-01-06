# read data files
pm2data <- readRDS("./data/summarySCC_PM25.rds")
codes <- readRDS("./data/Source_Classification_Code.rds")

motorVehicleCodes <- subset(codes, grepl("Vehicles", EI.Sector))
motorVehicleSCC <- motorVehicleCodes$SCC

baltimoreCityMotorVehicleData <- subset(pm2data, fips == "24510" & SCC %in% motorVehicleSCC)

baltimoreCityMotorVehicleEmissionByYear <- tapply(baltimoreCityMotorVehicleData$Emissions, baltimoreCityMotorVehicleData$year, sum)

years <- as.numeric(names(baltimoreCityMotorVehicleEmissionByYear))

plot(
    x = years, 
    y = baltimoreCityMotorVehicleEmissionByYear, 
    pch = 20, 
    cex = 2,
    xlab = "Year",
    ylab = "Total Motor Vehicle Related PM2.5 Emission, tons",
    main = "Motor Vehicle Related Emission of PM2.5 in the Baltimore City, Maryland"
)

abline(lm(baltimoreCityMotorVehicleEmissionByYear ~ years), lwd = 2, col = "blue")

dev.copy(png, filename = "plot5.png")
dev.off()