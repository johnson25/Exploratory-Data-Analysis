# Loading NEI and SSC Data frames:

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Finding total emissions by year:
Total_emission <- aggregate(Emissions ~ year, NEI, sum)

#Saving the analysis in PNG:
png("EDA_Plot1.png", width=1280, height=1024, units = "px")

#Plotting the decrease in total emissions by each year:
plot(
    (Total_emission$Emissions)/10^6,
    type = "o",
    names.arg = Total_emission$year,
    xlab = "Year",
    ylab = "PM2.5 Emissions (10^6 Tons)",
    main = "Total PM2.5 Emissions for each year across USA",
    lty=6,
    col = "red")

dev.off()

