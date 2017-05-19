############### PLOT # 4 ##################
#
#     Assumptions:
#     The dataset file to be used is downloaded and saved into a "data" folder in the working directory.
#     The name of the file is household_power_consumption.txt

#     This is slightly different from the previous plots.
#     Here, we would need to plot 4 charts on the same PNG device.

#     Read the dataset into a data table
library( data.table)
mydataset <- fread( "./data/household_power_consumption.txt")

#     We now try to understand the data in hand by viewing the top few rows, and the structure of the dataset.
head( mydataset)
str( mydataset)

#     Combine Date and Time into a new column Date_Time. 
library(lubridate)
mydataset$Date_Time <- dmy_hms(paste( mydataset$Date, mydataset$Time))

#     We only need the data from the dates 2007-02-01 and 2007-02-02
mydataset <- mydataset[ mydataset$Date_Time >= ymd_hms("2007/02/01 00:00:00") & mydataset$Date_Time < ymd_hms("2007/02/03 00:00:00")]

#     Convert all relevant columns to numeric.
mydataset$Sub_metering_1 <- as.numeric( mydataset$Sub_metering_1)
mydataset$Sub_metering_2 <- as.numeric( mydataset$Sub_metering_2)
mydataset$Sub_metering_3 <- as.numeric( mydataset$Sub_metering_3)
mydataset$Global_active_power <- as.numeric( mydataset$Global_active_power)
mydataset$Voltage <- as.numeric( mydataset$Voltage)
mydataset$Global_reactive_power <- as.numeric( mydataset$Global_reactive_power)

#     Check for missing values.
#     Remember that the instructions said missing values are represented by "?".
#     as.numeric() would have coerced such values to NAs. Let's check if there are any NAs in our dataset for this column

sum( is.na( mydataset$Sub_metering_1))
sum( is.na( mydataset$Sub_metering_2))
sum( is.na( mydataset$Sub_metering_3))
sum( is.na( mydataset$Global_active_power))
sum( is.na( mydataset$Voltage))
sum( is.na( mydataset$Global_reactive_power))
#     The results are all zero, i.e. no missing values. We proceed as normal now.

#     We will now open a png device, and save the plots to the png file.
library( grDevices)
png( filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

#     We need to plot 4 charts, 2 on each of 2 rows
par(mfrow = c( 2, 2))

#     Plot for Global Active Power
with(mydataset, plot( Date_Time,Global_active_power,
      xlab = "",
      ylab = "Global Active Power",
      type = "l"
))
      
#     Plot for Voltage
with(mydataset, plot(
      Date_Time, Voltage,
      type = "l",
      xlab = "datetime",
      ylab = "Voltage"
))

#     Plot for Sub metering readings
with(mydataset, plot(
      Date_Time, Sub_metering_1,# Sub_metering_2, Sub_metering_3),
      type = "l",
      xlab = "",
      ylab = "Energy sub metering",
      col = "black"
))
      
# Plot sub metering 2 and 3 in red and blue
with( mydataset, lines(
      Date_Time, Sub_metering_2,
      type = "l",
      col = "red"
))
      
with(mydataset, lines(
      Date_Time, Sub_metering_3,
      type = "l",
      col = "blue"
))

legend( "topright",
      legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
      col = c("black", "red", "blue"),
      bty = "n",
      lty = 1)

#     Last plot :: Plot of Global_reactive_power
#     No ylab arg is needed, as the name of the variable is same as y-axis label
with(mydataset, plot(
      Date_Time, Global_reactive_power,
      type = "l",
      xlab = "datetime"
))

dev.off()

#     This saved a plot4.png file in the working directory. Looking at the file,
#     it indeed looks like the plot we wanted to create.

