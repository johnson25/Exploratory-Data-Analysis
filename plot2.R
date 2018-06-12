library(dplyr)
Household <- read.csv(file = "C:/Users/johns/Documents/R/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows=2075259, check.names = F, stringsAsFactors = F, comment.char = "")
subset_household <- subset(Household, Date %in% c("1/2/2007","2/2/2007"))
subset_household$Date <- as.Date(subset_household$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(subset_household$Date), subset_household$Time)
subset_household$Datetime <- as.POSIXct(datetime)

with(subset_household, {plot(Global_active_power~Datetime, type = "l", xlab="", ylab="Global Active Power(kilowatts)") })

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()