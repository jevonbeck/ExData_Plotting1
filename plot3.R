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
kitchenEnergy <- as.numeric(as.character(cleanData$Sub_metering_1))
laundryRoomEnergy <- as.numeric(as.character(cleanData$Sub_metering_2))
heatingEnergy <- as.numeric(as.character(cleanData$Sub_metering_3))

# Plot graph
png("plot3.png")
plot(dateTimes, kitchenEnergy, type = "n", 
     xlab = "", ylab = "Energy sub metering")
lines(dateTimes, kitchenEnergy, type = "l")
lines(dateTimes, laundryRoomEnergy, type = "l", col="red")
lines(dateTimes, heatingEnergy, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       pch = "-")
dev.off()