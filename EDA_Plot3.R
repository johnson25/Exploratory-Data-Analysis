# Loading NEI and SSC Data frames:

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filtering the NEI data by Baltimore city:
NEI_Baltimore <- NEI[NEI$fips == "24510", ]

#Finding total emissions by year:
Total_emission_Baltimore <- aggregate(Emissions ~ year, NEI_Baltimore, sum)

#Saving the analysis in PNG:
png("EDA_Plot3.png", width=1280, height=1024, units = "px")

#Plotting the increase in total emissions in the Baltimore city according to the four types of sources:

library(ggplot2)

Type_Plot <- ggplot(NEI_Baltimore, aes(factor(year), Emissions, fill=type)) + 
             geom_bar(stat = "identity") +
             theme_bw() + guides(fill=FALSE) +
             facet_grid(.~type, scales = "free", space = "free") +
             labs(x = "year", y = expression("PM2.5 Emissions (Tons)")) +
             labs(title = expression("Total PM2.5 Emissions across Baltimore city, Maryland according to source type"))
print(Type_Plot)
dev.off()