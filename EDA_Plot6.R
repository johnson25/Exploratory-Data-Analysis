# Loading NEI and SSC Data frames:

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filtering the NEI data related to vehicles:
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicles_SCC <- SCC[vehicles, ]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC, ]

#Filtering the NEI data related to vehicles in Baltimore city and adding city name:
vehicles_Baltimore_NEI <- vehicles_NEI[vehicles_NEI$fips == "24510", ]
vehicles_Baltimore_NEI$city <- "Baltimore City"

vehicles_LosAngeles_NEI <- vehicles_NEI[vehicles_NEI$fips == "06037", ]
vehicles_LosAngeles_NEI$city <- "Los Angeles"

#Combining the datasets of Baltimore city and Los Angeles:
LA_Baltimore_both <- rbind(vehicles_Baltimore_NEI, vehicles_LosAngeles_NEI)

#Saving the analysis in PNG:
png("EDA_Plot6.png", width=1280, height=1024, units = "px")

#Plotting the vehicle emissions in both Baltimore city and Los Angeles:

library(ggplot2)

LA_Baltimore_vehicleplot <- ggplot(LA_Baltimore_both, aes(factor(year), y=Emissions, fill = city)) +
    geom_bar(aes(fill=year), stat="identity") +
    facet_grid(scales = "free", space="free", .~city) +
    theme_bw() + guides(fill=FALSE) +
    labs(x = "year", y = expression("Total PM2.5 Emissions (Kilo Tons)")) +
    labs(title = expression("PM2.5 vehicle emissions in Baltimore city, Maryland and Los Angeles"))

print(LA_Baltimore_vehicleplot)

dev.off()