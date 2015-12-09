library(dplyr)

# Clear environment variables:
rm(list = ls())

# assign the classes of the table columns to be read in:
colClasses = c("character","character",rep("numeric",7))

# read the table, convert dates/times, and select only
# data between 2007-02-01 and 2007-02-02:
housepower <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings="?", colClasses = colClasses)
housepower$Date <- as.Date(housepower$Date, format="%d/%m/%Y")
housepower <- filter(housepower, Date=="2007-02-01" | Date=="2007-02-02")

# change first column to contain both date + time:
housepower$Date <- strptime(paste(housepower$Date, housepower$Time), format="%Y-%m-%d %H:%M:%S")

# remove the "time" column:
housepower <- select(housepower, -Time)

# plot four different panels and save to PNG:
size <- 0.85
par(mfrow = c(2,2))
par(mar = c(4,4.25,1,0.55))
par(mgp = c(2.5,1,0))

with(housepower, {
  
  plot(housepower$Date, housepower$Global_active_power, type="l", ylab="Global Active Power", xlab="", cex.lab=size, cex.axis=size)
  
  plot(housepower$Date, housepower$Voltage, type="l", ylab="Voltage", xlab="datetime", cex.lab=size, cex.axis=size)
  
  plot(housepower$Date, housepower$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", cex.lab=size, cex.axis=size)
  lines(housepower$Date, housepower$Sub_metering_2, col="red")
  lines(housepower$Date, housepower$Sub_metering_3, col="blue")
  legend("topright",c("Sub_metering_1","sub_metering_2","sub_metering_3"), bty="n", lty=c(1,1), col=c("black","red","blue"), cex=0.55, xjust=1)
  
  plot(housepower$Date, housepower$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", cex.lab=size, cex.axis=size)
  }
)

dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()
