# Load Data
rawdata <- read.csv("household_power_consumption.txt", sep=";")
rawDates <- as.Date(rawdata$Date, "%d/%m/%Y")
datesOfInterest <- rawDates >= as.Date("2007-02-01") & 
    rawDates <= as.Date("2007-02-02")
rawInterestData <- rawdata[datesOfInterest,]
cleanData <- rawInterestData[complete.cases(rawInterestData),]

# Retrieve data of interest
activePower <- as.numeric(as.character(cleanData$Global_active_power))

# Plot graph
png("plot1.png")
hist(activePower, col= "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()