# Loading NEI and SSC Data frames:

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filtering the NEI data related to coal combustion:
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
Coal_Combustion <- (combustion & coal)
combustion_SCC <- SCC[Coal_Combustion, ]$SCC
combustion_NEI <- NEI[NEI$SCC %in% combustion_SCC, ]

#Saving the analysis in PNG:
png("EDA_Plot4.png", width=1280, height=1024, units = "px")

#Plotting the change in coal combustion related emission over the years:

library(ggplot2)

coalcombustion_plot <- ggplot(combustion_NEI, aes(factor(year), Emissions/10^5)) +
                       geom_bar(stat="identity", fill="blue", width=0.5) +
                       theme_bw() + guides(fill=FALSE) +
                       labs(x = "year", y = expression("Total PM2.5 Emissions (10^5 Tons)")) +
                       labs(title = expression("PM2.5 Coal combustion emissions across USA"))

print(coalcombustion_plot)

dev.off()