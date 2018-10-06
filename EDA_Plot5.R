# Loading NEI and SSC Data frames:

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filtering the NEI data related to vehicles:
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicles_SCC <- SCC[vehicles, ]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC, ]

#Filtering the NEI data related to vehicles in Baltimore city:
vehicles_Baltimore_NEI <- vehicles_NEI[vehicles_NEI$fips == "24510", ]

#Saving the analysis in PNG:
png("EDA_Plot5.png", width=1280, height=1024, units = "px")

#Plotting the change in vehicle emissions in Baltimore city:

library(ggplot2)

vehicles_plot <- ggplot(vehicles_Baltimore_NEI, aes(factor(year), Emissions/10^5)) +
    geom_bar(stat="identity", fill="blue", width=0.5) +
    theme_bw() + guides(fill=FALSE) +
    labs(x = "year", y = expression("Total PM2.5 Emissions (10^5 Tons)")) +
    labs(title = expression("PM2.5 vehicle emissions in Baltimore city, Maryland"))

print(vehicles_plot)

dev.off()