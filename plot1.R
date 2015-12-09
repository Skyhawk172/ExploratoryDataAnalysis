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

# change first column to contain both date + time and save to PNG:
housepower$Date <- strptime(paste(housepower$Date, housepower$Time), format="%Y-%m-%d %H:%M:%S")

# remove the "time" column:
housepower <- select(housepower, -Time)

# plot histogram of Global active power:
par(mar = c(5,4.5,4,2) + 0.1)
hist(housepower$Global_active_power, breaks=12, col="red", xlab = "Global Active Power (kiloWatts)", main="Global Active Power")
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()
