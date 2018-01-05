library(dplyr)
library(ggplot2)

# read data files
# pm2data <- readRDS("./data/summarySCC_PM25.rds")
# codes <- readRDS("./data/Source_Classification_Code.rds")

baltimoreCityEmission <- subset(pm2data, fips == "24510")
baltimoreCityEmission$type <- as.factor(baltimoreCityEmission$type)

baltimoreCityEmission <- tbl_df(baltimoreCityEmission)

baltimoreCityEmissionByTypeAndYear <- baltimoreCityEmission %>%
    group_by(type, year) %>%
    summarise(TotalEmission = sum(Emissions))

g <- ggplot(baltimoreCityEmissionByTypeAndYear, aes(year, TotalEmission))

print(g + 
    ylim(-100, 2500) +
    geom_point(cex = 3) + 
    geom_smooth(method = "lm", se = FALSE) + 
    facet_wrap(~ type, ncol = 2) + 
    labs(x = "Year", y = "Total PM2.5 Emission, tons", title = "Emission of PM2.5 in the Baltimore City, Maryland by type of sources"))

dev.copy(png, filename = "plot3.png")
dev.off()