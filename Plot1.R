Household <- read.csv(file = "C:/Users/johns/Documents/R/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows=2075259, check.names = F, stringsAsFactors = F, comment.char = "")
subset_household <- subset(Household, Date %in% c("1/2/2007","2/2/2007"))
subset_household$Date <- as.Date(subset_household$Date, format="%d/%m/%Y")

hist(as.numeric(as.character(subset_household$Global_active_power)), col ="red", main="Global Active Power", xlab="Global Active Power(kilowatts)", ylab = "Frequency")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()