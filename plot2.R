############### PLOT # 2 ##################
#
#     Assumptions:
#     The dataset file to be used is downloaded and saved into a "data" folder in the working directory.
#     The name of the file is household_power_consumption.txt

#     Thoughts on the plot to be generated
#     This looks like a time seriesp plot of of Global_active_power for the 2 days under consideration.
#     We would need to combine Date and Time to a single column having date as well as time in the day.
#     Separately, the x axis of the plot needs to be labeled as the weekdays


#     Read the dataset into a data table
library( data.table)
mydataset <- fread( "./data/household_power_consumption.txt")

#     We now try to understand the data in hand by viewing the top few rows, and the structure of the dataset.
head( mydataset)
str( mydataset)

#     Select only observations corresponding to dates 2007-02-01 and 2007-02-02
mydataset <- mydataset[ mydataset$Date == "01/02/2007" | mydataset$Date == "02/02/2007",]

#     Combine Date and Time into a new column Date_Time. 
library(lubridate)
mydataset$Date_Time <- dmy_hms(paste( mydataset$Date, mydataset$Time))

#     We only need the data from the dates 2007-02-01 and 2007-02-02
mydataset <- mydataset[ mydataset$Date_Time >= ymd_hms("2007/02/01 00:00:00") & mydataset$Date_Time < ymd_hms("2007/02/03 00:00:00")]

#     Global_active_power is currently saved as character. Let's change it to numeric.

mydataset$Global_active_power <- as.numeric( mydataset$Global_active_power)

#     Check for missing values.
#     Remember that the instructions said missing values are represented by "?".
#     as.numeric() would have coerced such values to NAs. Let's check if there are any NAs in our dataset for this column

sum( is.na( mydataset$Global_active_power))
#     The result is zero, i.e. no missing values. We proceed as normal now.

#     We will now open a png device, and save the plot to the png file.
library( grDevices)
png( filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c( 1, 1))
with( mydataset, 
      plot(
            Date_Time, Global_active_power,
            type = "l",
            xlab = "",
            ylab = "Global Active Power (kilowatts)"
      ))
dev.off()

#     This saved a rPlot2.png file in the working directory. Looking at the file,
#     it indeed looks like the plot we wanted to create.

