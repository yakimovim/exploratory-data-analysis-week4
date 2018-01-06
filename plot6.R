library(dplyr)

# read data files
pm2data <- readRDS("./data/summarySCC_PM25.rds")
codes <- readRDS("./data/Source_Classification_Code.rds")

motorVehicleCodes <- subset(codes, grepl("Vehicles", EI.Sector))
motorVehicleSCC <- motorVehicleCodes$SCC

emission <- subset(pm2data, fips %in% c("24510", "06037") & SCC %in% motorVehicleSCC)

emission <- tbl_df(emission)
emissionByPlaceAndYear <- emission %>%
    group_by(fips, year) %>%
    summarise(TotalEmission = sum(Emissions))

with(emissionByPlaceAndYear, {
    plot(year, TotalEmission, 
         col = fips, 
         pch = 19, 
         cex = 2, 
         ylim = c(0, 8000),
         xlab = "Year",
         ylab = "Total Motor Vehicle Related PM2.5 Emission, tons",
         main = "Motor Vehicle Related Emission of PM2.5"
    )
    legend("topright", 
           legend = c("Los Angeles County, California", "Baltimore City, Maryland"), 
           col = unique(fips),
           pch = 19)
})

 
dev.copy(png, filename = "plot6.png")
dev.off()