# Loading NEI and SSC Data frames:

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filtering the NEI data by Baltimore city:
NEI_Baltimore <- NEI[NEI$fips == "24510", ]

#Finding total emissions by year:
Total_emission_Baltimore <- aggregate(Emissions ~ year, NEI_Baltimore, sum)

#Saving the analysis in PNG:
png("EDA_Plot2.png", width=1280, height=1024, units = "px")

#Plotting the decrease in total emissions in the Baltimore city:
plot(
    (Total_emission_Baltimore$Emissions),
    type = "o",
    names.arg = Total_emission_Baltimore$year,
    xlab = "Year",
    ylab = "PM2.5 Emissions (Tons)",
    main = "Total PM2.5 Emissions across Baltimore city, Maryland",
    lty=6,
    col = "red")

dev.off()