############### PLOT # 1 ##################
#
#     Assumptions:
#     The dataset file to be used is downloaded and saved into a "data" folder in the working directory.
#     The name of the file is household_power_consumption.txt


#     Read the dataset into a data table
library( data.table)
mydataset <- fread( "./data/household_power_consumption.txt")

#     We now try to understand the data in hand by viewing the top few rows, and the structure of the dataset.
head( mydataset)
str( mydataset)

#     Let's change Date column to Date class, and exclude the dates which are not needed
mydataset$Date <- as.Date( mydataset$Date, format = "%d/%m/%Y")

#     We only need the data from the dates 2007-02-01 and 2007-02-02
mydataset <- mydataset[ mydataset$Date == as.Date("2007-02-01", format = "%Y-%m-%d") | mydataset$Date == as.Date("2007-02-02", format = "%Y-%m-%d")]

#     The first plot is a histogram for teh Global_active_power attribute.
#     We notice that this is currently saved as character. Let's change it to numeric.

mydataset$Global_active_power <- as.numeric( mydataset$Global_active_power)

#     Check for missing values.
#     Remember that the instructions said missing values are represented by "?".
#     as.numeric() would have coerced such values to NAs. Let's check if there are any NAs in our dataset for this column

sum( is.na( mydataset$Global_active_power))
#     The result is zero, i.e. no missing values. We proceed as normal now.

#     We will now open a png device, and save the plot to the png file.
library( grDevices)
png( filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
hist( mydataset$Global_active_power,
      freq = T,
      main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency",
      col = "red")
dev.off()

#     This saved a plot1.png file in the working directory. Looking at the file,
#     it indeed looks like the plot we wanted to create.




