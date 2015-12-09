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

# plot all three sub_meter readings as a function of datetime and save to PNG:
par(mar = c(5,4.5,4,2) + 0.1)
plot(housepower$Date, housepower$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(housepower$Date, housepower$Sub_metering_2, col="red")
lines(housepower$Date, housepower$Sub_metering_3, col="blue")
legend("topright",names(housepower)[6:8], lty=c(1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue"), cex=0.75, xjust=1)

dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()
