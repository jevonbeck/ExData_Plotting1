# Load Data
rawdata <- read.csv("household_power_consumption.txt", sep=";")
rawDates <- as.Date(rawdata$Date, "%d/%m/%Y")
datesOfInterest <- rawDates >= as.Date("2007-02-01") & 
    rawDates <= as.Date("2007-02-02")
rawInterestData <- rawdata[datesOfInterest,]
cleanData <- rawInterestData[complete.cases(rawInterestData),]

# Retrieve data of interest
dateTimes <- as.POSIXlt(paste(cleanData$Date, cleanData$Time), 
                        format = "%d/%m/%Y %H:%M:%S")

activePower <- as.numeric(as.character(cleanData$Global_active_power))
reactivePower <- as.numeric(as.character(cleanData$Global_reactive_power))
voltage <- as.numeric(as.character(cleanData$Voltage))

kitchenEnergy <- as.numeric(as.character(cleanData$Sub_metering_1))
laundryRoomEnergy <- as.numeric(as.character(cleanData$Sub_metering_2))
heatingEnergy <- as.numeric(as.character(cleanData$Sub_metering_3))

# Plot graphs
png("plot4.png")
par(mfcol = c(2, 2))

# 1st plot (top-left)
plot(dateTimes, activePower, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

# 2nd plot (bottom-left)
plot(dateTimes, kitchenEnergy, type = "n", 
     xlab = "", ylab = "Energy sub metering")
lines(dateTimes, kitchenEnergy, type = "l")
lines(dateTimes, laundryRoomEnergy, type = "l", col="red")
lines(dateTimes, heatingEnergy, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       pch = "-")

# 3rd plot (top-right)
plot(dateTimes, voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

# 4th plot (bottom-right)
plot(dateTimes, reactivePower, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()

