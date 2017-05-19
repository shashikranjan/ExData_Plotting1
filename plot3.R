############### PLOT # 3 ##################
#
#     Assumptions:
#     The dataset file to be used is downloaded and saved into a "data" folder in the working directory.
#     The name of the file is household_power_consumption.txt

#     Thoughts on the plot to be generated
#     This looks like a time series plot of of Sub_metering_1/2/3 for the 2 days under consideration.
#     This can be shown as a line chart with different colors for the three attributes.
#     We would need to combine Date and Time to a single column having date as well as time in the day.
#     Separately, the x axis of the plot needs to be labeled as the weekdays


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

#     Notice that Sub_metering_1 and _2 are currently saved as character. Let's change them to numeric.
mydataset$Sub_metering_1 <- as.numeric( mydataset$Sub_metering_1)
mydataset$Sub_metering_2 <- as.numeric( mydataset$Sub_metering_2)

#     Check for missing values.
#     Remember that the instructions said missing values are represented by "?".
#     as.numeric() would have coerced such values to NAs. Let's check if there are any NAs in our dataset for this column

sum( is.na( mydataset$Sub_metering_1))
sum( is.na( mydataset$Sub_metering_2))
sum( is.na( mydataset$Sub_metering_3))
#     The result is zero, i.e. no missing values. We proceed as normal now.

#     We will now open a png device, and save the plot to the png file.
library( grDevices)
png( filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c( 1, 1))
with( mydataset, 
      # Plot sub metering 1
      plot(
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
      lty = 1)
dev.off()

#     This saved a rPlot3.png file in the working directory. Looking at the file,
#     it indeed looks like the plot we wanted to create.

